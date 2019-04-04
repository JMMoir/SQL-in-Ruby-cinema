DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;


CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  cash INT
);

CREATE TABLE films(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE tickets(
  id SERIAL PRIMARY KEY,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE
);
