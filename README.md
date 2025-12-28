# Prophecy – CS50 Practice Problem

This project is a solution to the **Prophecy** practice problem from
[CS50x – Introduction to Computer Science](https://cs50.harvard.edu/x/practice/prophecy/).

The goal of this exercise is to design and populate a relational database
from a CSV file while enforcing proper **relational integrity**, **normalization**,
and **foreign key constraints**.

This repository provides **two approaches** to solve the problem:

1. **Pure SQL** – using `schema.sql` to create tables, normalize data, and populate them.  
2. **Python with CS50 SQL library** – using `schema.py` to read `students.csv` and populate `roster.db` with foreign keys.

---

## Problem Overview

Given a CSV file containing information about students, their Hogwarts houses,
and the heads of those houses, the task is to:

- Import the raw CSV data
- Design a normalized database schema
- Enforce referential integrity using foreign keys
- Populate the final tables correctly

---

## Database Design

The database is normalized into the following tables:

### `houses`
Stores unique Hogwarts houses.

- `id` – Primary key
- `house_name` – Unique house name

### `students`
Stores student information.

- `id` – Primary key
- `student_name` – Student name
- `house_id` – Foreign key referencing `houses(id)`

### `house_assignments`
Stores house heads.

- `id` – Primary key
- `name` – Head of house name
- `house_id` – Foreign key referencing `houses(id)`

---

## Data Import Strategy

### `1) Using SQL (`schema.sql`)`
- A temporary table is used to import raw CSV data without constraints.  
- Header row is removed manually.  
- Data is normalized and inserted into the final tables with proper foreign keys.  
- Indexes are created for foreign key columns for better performance.

### `2) Using Python (`schema.py`)`
- The CSV is read with Python’s `csv.DictReader`.  
- Sets and dictionaries are used to collect unique houses and heads.  
- `CS50 SQL` library is used to insert data into `roster.db` while resolving foreign keys in memory.  
- Foreign key constraints are enforced, and uniqueness checks prevent duplicates.

This approach shows how Python can simplify inserting many rows programmatically while maintaining database integrity.


---

## Foreign Key Enforcement

SQLite does not enforce foreign keys by default.
Therefore, foreign key checks are explicitly enabled at the start of the script:

```sql
PRAGMA foreign_keys = ON;
```

Integrity is verified after insertion using:

```sql
PRAGMA foreign_key_check;
```

---

## Indexing

Indexes are created on foreign key columns to improve query performance:

- `students.house_id`
- `house_assignments.house_id`

---

## Files

- `schema.sql` – Database schema, data insertion, and indexing
- `students.csv` – Source data provided by the problem set
- `schema.py` – Python script using CS50 SQL to import CSV data
- `roster.db` – SQLite database created by Python script or SQL script

---

## How to Run

### SQL Approach

```bash
sqlite3 prophecy.db < schema.sql
```

This will create the database, import the data, and enforce all constraints.

### Python Approach

```bash
python schema.py
```
Both methods will create a fully normalized database with correct foreign key relationships.

---

## Notes

- The temporary table in the SQL approach is dropped after insertion.

- Both methods ensure referential integrity and prevent duplicates.

- The database is ready for querying and further analysis.
---

## Author

Solution implemented as part of **CS50x Practice Problems**.
