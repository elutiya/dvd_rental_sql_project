# DVD Rental SQL Project

## Project Overview
This project is a capstone for the Datanomics Data Analytics program. It uses the PostgreSQL DVD Rental database to perform **scenario-based DDL and DML operations** and explore data using **DQL queries**.  

The goal is to simulate real-world operations like adding new customers, films, rentals, and analyzing customer and film performance.

---

## Folder Structure

```
dvd_rental_sql_project/
│
├── README.md                  # Project overview, instructions, folder structure
│
├── section1_queries/          # Scenario 1 & Scenario 2 scripts
│   ├── new_customer.sql       # Scenario 1: New Customer & Rental
│   └── new_film_inventory.sql # Scenario 2: New Film & Inventory
│
├── section2_queries/          # Section 2: DQL / SELECT queries
    ├── general_analysis.sql   # Queries 8-15 (top movies, customers, revenue, etc.)
    └── case_studies.sql       # Case Study 1 & 2 (loyal customers, underperforming films)

````

---

## Section 1 - Scenario 2: New Film & Inventory

In this scenario, we simulate adding a new film to the DVD Rental database and making it available in store inventory.

### Steps Performed:

1. **Temporary Table Creation**

   * Created a temporary table `new_film` to stage film data before inserting into the main `film` table.

2. **Insert New Film Data**

   * Inserted a new film record into `new_film` with fields:

     * `title`, `description`, `release_year`, `language_id`, `rental_duration`, `rental_rate`, `length`, `replacement_cost`, `mpaa_rating`
   * Inserted into the main `film` table with `last_update = NOW()`.

3. **Add Inventory Copies**

   * Added **three copies** of the new film into `inventory`, assigned to existing stores.
   * Ensures foreign key constraints are satisfied.

### Notes:

* `mpaa_rating` is an **enum type**, so string values are cast (e.g., `'PG-13'::mpaa_rating`).
* Temporary tables allow **safe staging** before updating main tables.
* Inventory insertion guarantees the film is **available for rental**.

### Test Queries:

```
-- Verify new film
SELECT * FROM film WHERE title='AI Revolution';

-- Verify inventory copies
SELECT * FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title='AI Revolution');
```

---

## Section 2 – Data Query Language (DQL)

This section contains SQL queries for **analyzing the DVD Rental database**:

### General Analysis (Queries 8-15)

* `general_analysis.sql`
* Example queries include:

  * Top 10 longest movies
  * Customers who rented more than 10 movies
  * Average rental rate by rating
  * Top 5 cities with most customers
  * Total revenue per staff
  * Most rented films
  * Customer who spent the most
  * Movies never rented

### Case Studies (Customer & Film)

* `case_studies.sql`
* Case Study 1: Identify loyal customers (rented >20 movies and spent >$100)
* Case Study 2: Identify underperforming films (rented <5 times)

---

## Instructions to Run

1. Clone the repository:

```
git clone https://github.com/elutiya/dvd_rental_sql_project.git
```

2. Run Section 1 scripts (Scenario 1 first if ready, then Scenario 2).

3. Run Section 2 scripts to perform data analysis (if ready).

4. Test queries can be executed to verify insertion and results.

```

