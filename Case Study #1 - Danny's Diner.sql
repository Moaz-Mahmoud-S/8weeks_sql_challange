create database dannys_diner 
use dannys_diner
drop database dannys_diner 
create table menu
(
product_id int primary key,
product_name varchar(5),
price int
);

create table members
(
customer_id varchar(1)primary key,
join_date datetime
);

create table sales
(
product_id int foreign key REFERENCES menu(product_id),
customer_id varchar(1) foreign key REFERENCES members(customer_id),
order_date date
);

-------------------------------- Data insertion --------------------------------
INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09'),
  ('C', '2021-01-11');

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', 1),
  ('A', '2021-01-01', 2),
  ('A', '2021-01-07', 2),
  ('A', '2021-01-10', 3),
  ('A', '2021-01-11', 3),
  ('A', '2021-01-11', 3),
  ('B', '2021-01-01', 2),
  ('B', '2021-01-02', 2),
  ('B', '2021-01-04', 1),
  ('B', '2021-01-11', 1),
  ('B', '2021-01-16', 3),
  ('B', '2021-02-01', 3),
  ('C', '2021-01-01', 3),
  ('C', '2021-01-01', 3),
  ('C', '2021-01-07', 3);

-------------------------------- What is the total amount each customer spent at the restaurant? --------------------------------

select sum([price]) , [customer_id]
from [dbo].[sales]
inner join [dbo].[menu] on [dbo].[menu].product_id = [dbo].[sales].product_id
group by [dbo].[sales].customer_id

-------------------------------- How many days has each customer visited the restaurant? --------------------------------

select count(DATEPART(DAY,[order_date])) , [customer_id]
from [dbo].[sales]
group by [dbo].[sales].customer_id

-------------------------------- What was the first item from the menu purchased by each customer? --------------------------------
select MIN([order_date]), [product_id] , [customer_id]
from [dbo].[sales]
group by [product_id] , [customer_id]

-------------------------------- What is the most purchased item on the menu and how many times was it purchased by all customers? --------------------------------

select top(1) count([product_id]),[product_id]
from [dbo].[sales]
group by [product_id]
order by count([product_id]) desc

-------------------------------- Which item was the most popular for each customer? --------------------------------
select count([product_id]),[customer_id],[product_id]
from [dbo].[sales]
group by [customer_id],[product_id]
order by count([product_id]) desc

-------------------------------- Which item was purchased just before the customer became a member? --------------------------------
ALTER TABLE [dbo].[members]
ALTER COLUMN  [join_date] date;


select [product_id] ,[dbo].[sales].[customer_id]
from [dbo].[sales]
inner join [dbo].[members] on [dbo].[members].customer_id = [dbo].[sales].customer_id
where [order_date] < [join_date]

