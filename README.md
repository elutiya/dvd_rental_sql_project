# DVD Rental SQL Project

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-007396?style=flat&logo=sql&logoColor=white)

## Project Overview

This project is a comprehensive SQL-based analysis and management system using the **DVD Rental Database** on **PostgreSQL**. It covers both **data definition/manipulation (DDL/DML)** and **data querying (DQL)** scenarios. The main goal is to demonstrate SQL proficiency in:

- Creating and populating temporary and permanent tables
- Handling complex queries using joins, aggregates, and subqueries
- Performing data analysis to support business decision-making

The project is structured into **Section 1** (Scenario-Based DDL/DML) and **Section 2** (DQL/Data Analysis & Case Studies).

---

## Folder Structure
```text
dvd_rental_sql_project/
│
├── README.md
│
├── queries.sql
```

---

## Section 1: DDL and DML (Scenario-Based)

### **Scenario 1: New Customer Rental**

This scenario simulates a new customer visiting the store to rent a movie. Steps include:

1. **Create temporary table `new_customer`**
   * Captures all new customer data before inserting into the permanent table.
   
2. **Insert sample customer into `new_customer`**
   * Ensures data integrity without affecting existing customers.
   
3. **Insert new customer into `customer` table**
   * Requires first inserting the corresponding address into the `address` table due to foreign key constraints.
   
4. **Simulate a rental**
   * Insert a record into `rental` table linking the customer to an inventory item and staff member.
   
5. **Record a payment**
   * Insert into the `payment` table for the rental with amount and payment date.

> **Note:** Using temporary tables allows validation and staging of data without affecting the permanent database until all constraints are met.

### **Scenario 2: New Film and Inventory**

This scenario simulates adding a newly released film and updating store inventory:

1. **Create temporary table `new_film`**
   * Holds new film details including `title`, `description`, `release_year`, `language_id`, `rental_duration`, `rental_rate`, `length`, `replacement_cost`, and `mpaa_rating`.
   
2. **Insert the new film into `new_film`**
   * Example: `"AI Revolution"`, a PG-13 sci-fi thriller.
   
3. **Insert into the permanent `film` table**
   * Copies data from `new_film` while adding `last_update`.
   
4. **Add multiple inventory copies**
   * Inserts 3 new copies into the `inventory` table across available stores.

> **Purpose:** This ensures the store database remains up-to-date with new film releases and available stock.

---

## Section 2: DQL - Data Query Language

### **General Analysis (Queries 8-15)**

* List top 10 longest movies
* Find customers with more than 10 rentals
* Calculate average rental rate by movie rating
* Identify top 5 cities by customer count
* Total revenue collected by staff members
* Most rented films and rental counts
* Customer with highest total payments
* Movies never rented

---

### **Case Studies**

#### **Case Study 1: Customer Behavior Analysis**

* Identify loyal customers for marketing campaigns
* Criteria: rented > 20 movies and spent > $100
* Output: full name, email, total rentals, total payments

#### **Case Study 2: Film Performance Review**

* Identify underperforming films (rented < 5 times)
* Output: film title, rental count, average rental rate
* Sort by rental count ascending and limit results to 20 films

---

## GitHub Workflow

1. **Clone repository**
2. **Create feature branch** (e.g., `feature/section1-senario2`)
3. Add or update SQL scripts
4. Commit changes with clear messages
5. Push branch to GitHub
6. Open Pull Request for review

---

## Authors

* **Team Project:** DVD Rental Database SQL Project
* **Contributors:** Yalew Wondimgezaw, Eleni Tesheshigo, Tesfaye Hankebo, and Haiyleyesus Abayneh

---

> This project demonstrates hands-on SQL proficiency using PostgreSQL for real-world rental store operations, including customer management, film inventory, and data-driven business analysis.
