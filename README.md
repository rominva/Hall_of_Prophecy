# Prophecy – CS50 Practice Problem

This project is a solution to the **Prophecy** practice problem from
[CS50x – Introduction to Computer Science](https://cs50.harvard.edu/x/practice/prophecy/).

The goal of this exercise is to design and populate a relational database
from a CSV file while enforcing proper **relational integrity**, **normalization**,
and **foreign key constraints**.

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

Because CSV files do not enforce data types or constraints, the import process
is performed in two stages:

1. **Temporary table (`temp`)**
   - Raw CSV data is imported without constraints
   - Header row is removed explicitly

2. **Final tables**
   - Tables with proper primary keys and foreign keys are created
   - Data is inserted using `JOIN`s to map textual house names to numeric IDs

This approach ensures clean data and strict referential integrity.

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

---

## How to Run

```bash
sqlite3 prophecy.db < schema.sql
```

This will create the database, import the data, and enforce all constraints.

---

## Notes

- The temporary table is dropped after data insertion.
- The database is fully normalized.
- All foreign key relationships are validated.

---

## Author

Solution implemented as part of **CS50x Practice Problems**.
