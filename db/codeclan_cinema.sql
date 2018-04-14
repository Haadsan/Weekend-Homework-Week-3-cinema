DROP TABLE ticket;
DROP TABLE customer;
DROP TABLE film;

CREATE TABLE customer(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  funds  INT
);



CREATE TABLE film (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT
);



CREATE TABLE ticket (

  Id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customer(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES film(id) ON DELETE CASCADE

);
