DROP DATABASE IF EXISTS warehouse;
CREATE DATABASE wаrehouse;
USE wаrehouse;

CREATE TABLE clients(
  id int not null auto_increment PRIMARY KEY,
  name varchar(255) not null,
  address varchar(255) not null,
  phone varchar(12) not null,
  email varchar(255)
  );

CREATE TABLE stockGroups(
  id int not null auto_increment PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE brands(
  id int not null auto_increment PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE models(
  id int not null auto_increment PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  brand_id int not null,
  group_id int not null,
  FOREIGN KEY(brand_id) references brands(id),
  FOREIGN KEY(group_id) references stockGroups(id)
);

CREATE TABLE stock(
  id int not null auto_increment PRIMARY KEY,
  groups_id int not null,
  brand_id int not null,
  model_id int  not null,
  quantity int not null,
  price double not null,
  FOREIGN KEY (groups_id) REFERENCES stockGroups(id),
  FOREIGN KEY (brand_id) REFERENCES brands(id),
  FOREIGN KEY (model_id) REFERENCES models(id)
);

CREATE TABLE orders(
  id int not null auto_increment PRIMARY KEY,
  client_id int not null,
  stock_id int not null,
  or_qty int not null,
  dateOfOrder DATE not null,
  FOREIGN KEY (client_id) REFERENCES clients(id),
  FOREIGN KEY (stock_id) references stock(id)
);

CREATE TABLE discount(
  id int not null auto_increment PRIMARY KEY,
  stock_id int not null,
  min_qty int not null,
  disc_percentage int not null,
  FOREIGN KEY (stock_id) references stock(id)
);

CREATE TABLE payments(
  id int not null auto_increment PRIMARY KEY,
  order_id int not null,
  client_id int not null,
  total double not null,
  pay_Date DATE not null,
  FOREIGN KEY (client_id) REFERENCES clients(id),
  FOREIGN KEY (order_id) references orders(id)
);

CREATE TABLE deliveries(
  id int not null auto_increment PRIMARY KEY,
  stock_id int not null,
  client_id int not null,
  del_qty int not null,
  del_date DATE not null,
  FOREIGN KEY (client_id) REFERENCES clients(id),
  FOREIGN KEY (stock_id) references stock(id)
);


INSERT INTO clients (name, address, phone, email)
VALUES ('Technopolis', 'ul. Okolovrasten pat 265', '02 921 1111', 'orders@technopolis.bg'),
		('TechMart', 'bul. Simeonovsko Shose 138', '02 405 1379', 'orders@techmart.bg'),
        ('Zora', 'ul. Profesor Stoyan Kirkovich 13', '02 887 9495', 'orders@zora.bg');

INSERT INTO stockGroups (name)
VALUES ('Electronics'),
		('Home Appliances');

INSERT INTO brands (name)
VALUES ('Samsung'),
		('Bosch');

INSERT INTO models (name, brand_id, group_id)
VALUES ('Galaxy S20', 1, 1),
		('KGN36NLEA', 2, 2);

INSERT INTO stock (groups_id, brand_id, model_id, quantity, price)
VALUES (1, 1, 1, 100, 799.99),
		(2, 2, 2, 50, 1099.99);

INSERT INTO orders (client_id, stock_id, or_qty, dateOfOrder)
VALUES (1, 1, 2, '2022-01-01'),
		(2, 2, 5, '2022-01-20'),
		(3, 2, 7, '2022-01-20');

INSERT INTO discount (stock_id, min_qty, disc_percentage)
VALUES (1, 10, 10),
		(2, 5, 10);

INSERT INTO payments (order_id, client_id, total, pay_Date)
SELECT orders.id, orders.client_id, stock.price * orders.or_qty, CURDATE()
FROM orders
INNER JOIN stock ON orders.stock_id = stock.id;


INSERT INTO deliveries (client_id, stock_id, del_qty, del_date)
VALUES (1, 1, 1, '2022-01-10'),
		(2, 2, 1, '2022-01-20');