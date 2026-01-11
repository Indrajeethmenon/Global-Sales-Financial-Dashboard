Create Database Sales;
use Sales;

CREATE TABLE Canada_sales (
    Transaction_id VARCHAR(250) PRIMARY KEY, 
    Purchase_date DATE NOT NULL,
    Country VARCHAR(50),
    product_id VARCHAR(250),
    Product_name VARCHAR(50),
    Category VARCHAR(50),
    Price_per_unit DECIMAL(10,2),
    Quantity_purchased INT,
    Cost_price DECIMAL(10,2),
    Discount DECIMAL(10,2),
    Payment_mode VARCHAR(50),
    Customer_age_group VARCHAR(50),
    Gender ENUM ('Male', 'Female', 'Other') NOT NULL, 
    Store_location VARCHAR(50),
    Sales_rep VARCHAR(50)
);


create table China_sales(
Transaction_id varchar(50) primary key,
Purchase_date Date not null,
Country Varchar(50),
product_id VARCHAR(250),
Product_name VARCHAR(50),
Category VARCHAR(50),
 Price_per_unit DECIMAL(10,2),
    Quantity_purchased INT,
    Cost_price DECIMAL(10,2),
    Discount DECIMAL(10,2),
    Payment_mode VARCHAR(50),
    Customer_age_group VARCHAR(50),
    Gender ENUM ('Male', 'Female', 'Other') NOT NULL, 
    Store_location VARCHAR(50),
    Sales_rep VARCHAR(50)
);

create table India_sales(
Transaction_id varchar(50) primary key,
Purchase_date Date not null,
Country Varchar(50),
product_id VARCHAR(250),
Product_name VARCHAR(50),
Category VARCHAR(50),
 Price_per_unit DECIMAL(10,2),
    Quantity_purchased INT,
    Cost_price DECIMAL(10,2),
    Discount DECIMAL(10,2),
    Payment_mode VARCHAR(50),
    Customer_age_group VARCHAR(50),
    Gender ENUM ('Male', 'Female', 'Other') NOT NULL, 
    Store_location VARCHAR(50),
    Sales_rep VARCHAR(50)
);

create table Nigeria_sales(
Transaction_id varchar(50) primary key,
Purchase_date Date not null,
Country Varchar(50),
product_id VARCHAR(250),
Product_name VARCHAR(50),
Category VARCHAR(50),
 Price_per_unit DECIMAL(10,2),
    Quantity_purchased INT,
    Cost_price DECIMAL(10,2),
    Discount DECIMAL(10,2),
    Payment_mode VARCHAR(50),
    Customer_age_group VARCHAR(50),
    Gender ENUM ('Male', 'Female', 'Other') NOT NULL, 
    Store_location VARCHAR(50),
    Sales_rep VARCHAR(50)
);

create table UK_sales(
Transaction_id varchar(50) primary key,
Purchase_date Date not null,
Country Varchar(50),
product_id VARCHAR(250),
Product_name VARCHAR(50),
Category VARCHAR(50),
 Price_per_unit DECIMAL(10,2),
    Quantity_purchased INT,
    Cost_price DECIMAL(10,2),
    Discount DECIMAL(10,2),
    Payment_mode VARCHAR(50),
    Customer_age_group VARCHAR(50),
    Gender ENUM ('Male', 'Female', 'Other') NOT NULL, 
    Store_location VARCHAR(50),
    Sales_rep VARCHAR(50)
);

create table US_sales(
Transaction_id varchar(50) primary key,
Purchase_date Date not null,
Country Varchar(50),
product_id VARCHAR(250),
Product_name VARCHAR(50),
Category VARCHAR(50),
 Price_per_unit DECIMAL(10,2),
    Quantity_purchased INT,
    Cost_price DECIMAL(10,2),
    Discount DECIMAL(10,2),
    Payment_mode VARCHAR(50),
    Customer_age_group VARCHAR(50),
    Gender ENUM ('Male', 'Female', 'Other') NOT NULL, 
    Store_location VARCHAR(50),
    Sales_rep VARCHAR(50)
);

Create table Sales_data as
select*from Canada_sales
union all
Select*from China_sales
union all
select*from India_sales
union all
Select*from Nigeria_sales
Union all
select*from UK_sales
union all
Select*from US_sales;

select* from Sales_data
where transaction_id is null
or country is null
or product_id is null
or product_name is null
or category is null
or price_per_unit is null
or Quantity_purchased is null
or Cost_price is null
or Discount is null
or Payment_mode is null
or Customer_age_group is null
or gender is null
or Store_location is null
or Sales_rep is null;


select  Transaction_id, count(*)
from sales_data
group by Transaction_id
having count(*)>1;

Alter table Sales_data
add column Total_Amount decimal (10,2);

select* from Sales_data

SET SQL_SAFE_UPDATES = 0;

UPDATE Sales_data 
SET Total_amount = (Price_per_unit * Quantity_purchased) - Discount;

Alter table Sales_data
add column Profit Decimal(10,2) not null;

Update Sales_data
set Profit = Total_amount - (Cost_price+Quantity_Purchased);

Select Country, sum(Total_Amount) as Total_Revenue,
Sum(profit) as Total_Profit
from sales_data
Group by Country
order by Total_Revenue asc;

Select product_name,
Sum(quantity_purchased) as Total_units_sold
from sales_data
group by product_name
order by Total_units_sold desc
Limit 5;

select Sales_rep, sum(Total_amount) as Total_revenue
from Sales_data
group by Sales_rep
order by Total_revenue desc
limit 5;

select Store_location, sum(Total_amount) as Total_revenue
from Sales_data
group by Store_location
order by total_revenue
limit 5;

select country,
max(total_amount) as Max_sales,
min(total_amount) as Min_sales,
Avg(total_amount) as Avg_sales,
Sum(total_amount) as Sum_Sales,
max(Profit) as Max_Profit,
min(Profit) as Min_Profit,
Avg(Profit) as Avg_Profit,
Sum(Profit) as Sum_Profit
from Sales_data
group by country;
