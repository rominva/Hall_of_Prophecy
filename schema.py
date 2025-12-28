import csv
from cs50 import SQL

# 1) Import data from csv to python variables
students = []
houses = set()
heads = set()

with open("students.csv", "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        student_name = row["student_name"]
        house_name = row["house"]
        head_name = row["head"]

        houses.add(house_name)
        heads.add((head_name, house_name))
        students.append({"student_name": student_name, "house": house_name})


# 2) Create empty Tables in SQL

# 3) Connect to database
db = SQL("sqlite:///roster.db")  # For SQLite, file.db must exist

# 4) Enable foreign key constraints
db.execute("PRAGMA foreign_keys = ON")

# 5) Insert data into houses table
for house in houses:
    # Check for existing data to avoid UNIQUE constraint errors
    rows = db.execute("SELECT id FROM houses WHERE house_name = ?", house)
    if len(rows) == 0:
        db.execute("INSERT INTO houses (house_name) VALUES(?)", house)


# 6) Insert data into house_assignments table
for head_name, house_name in heads:
    house_id = db.execute("SELECT id FROM houses WHERE house_name = ?", house_name)[0]["id"]

    # check for the existing data
    rows = db.execute("SELECT id FROM house_assignments WHERE name = ?", head_name)
    if len(rows) == 0:
        db.execute("INSERT INTO house_assignments (name, house_id) VALUES(?,?)", head_name, house_id)


# 7) Insert data into students table
for student in students:
    student_name = student["student_name"]
    student_house = student["house"]

    house_id = db.execute("SELECT id FROM houses WHERE house_name = ?", student_house)[0]["id"]

    # check for existing data
    rows = db.execute("SELECT id FROM students WHERE student_name = ?", student_name)
    if len(rows) == 0:
        db.execute("INSERT INTO students (student_name, house_id) VALUES(?, ?)", student_name, house_id)


print("Data has been inserted successfully!")