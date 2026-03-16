

-- Scenario 2: A new film is released and needs to be added to the system.
DROP TABLE IF EXISTS new_film;
-- 6. Create a temporary table new_film with fields such as title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, and rating.
CREATE TEMP TABLE new_film (
    title VARCHAR(255),
    description TEXT,
    release_year INT,
    language_id INT,
    rental_duration INT,
    rental_rate NUMERIC(4,2),
    length INT,
    replacement_cost NUMERIC(5,2),
    mpaa_rating mpaa_rating  -- use the enum type
);

-- 7. Insert a record for the new film into new_film table.
INSERT INTO new_film
(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, mpaa_rating)
VALUES
('AI Revolution', 'A sci-fi thriller about the rise of AI in 2030.', 2026, 1, 7, 3.99, 120, 19.99, 'PG-13');

-- 8. Insert the new film into the main film table using the data from new_film.
INSERT INTO film
(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update)
SELECT
    title,
    description,
    release_year,
    language_id,
    rental_duration,
    rental_rate,
    length,
    replacement_cost,
    mpaa_rating,
    NOW()  -- last_update
FROM new_film;

-- 9. Add inventory: insert 3 available copies of this new film into the inventory table, assigning them to different store locations.
-- There are 2 stores (store_id = 1 and store_id = 2)
-- Assign inventory to different stores
INSERT INTO inventory (film_id, store_id, last_update)
VALUES
(
    (SELECT film_id FROM film WHERE title='AI Revolution' LIMIT 1),
    1,
    NOW()
),
(
    (SELECT film_id FROM film WHERE title='AI Revolution' LIMIT 1),
    2,
    NOW()
),
(
    (SELECT film_id FROM film WHERE title='AI Revolution' LIMIT 1),
    1,
    NOW()
);