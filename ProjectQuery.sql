/* 
	OBJECTIVE 1: Explore the items table
*/

-- 1. View the menu_items table and write a query to find the number of items on the menu.
use restaurant_db;

select *
from menu_items;

select count(*) as count_items
from menu_items;

-- 2. What are the least and most expensive items on the menu?
select *
from menu_items
order by price;

select *
from menu_items
order by price desc;

-- 3. How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
select count(*)
from menu_items
where category = 'italian';

select *
from menu_items
where category = 'italian'
order by price;

select *
from menu_items
where category = 'italian'
order by price desc;

-- 4. How many dishes are in each category? What is the average dish price within each category?
select category, count(*) as count_items
from menu_items
group by category;

select category, avg(price) as avg_price
from menu_items
group by category;

/*
	OBJECTIVE 2: Explore the orders table
*/

-- 1. View the order_details table. What is the date range of the table?
select *
from order_details;

select min(order_date), max(order_date)
from order_details;

-- 2. How many orders were made within this date range? How many items were ordered within this date range?
select count(distinct order_id)
from order_details;

select count(*)
from order_details;

-- 3. Which orders had the most number of items?
select order_id, count(item_id) as count_items
from order_details
group by order_id
order by count_items desc;

-- 4. How many orders had more than 12 items?
select count(*)
from
	(select order_id, count(item_id) as count_items
	from order_details
	group by order_id
	having count_items > 12)
    as count_orders;
    
/*
OBJECTIVE 3: Analyze customer behavior
*/

-- 1. Combine the menu_items and order_details tables into a single table.
select *
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id;
    
-- 2. What were the least and most ordered items? What categories were they in?
select item_name, category, count(item_name) as count_order
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
group by item_name, category
order by count_order desc;
    
-- 3. What were the top 5 orders that spent the most money?
select order_id, sum(price)
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
group by order_id
order by sum(price) desc
limit 5;

-- 4. View the details of the highest spend order. Which specific items were purchased?
select category, count(item_id) as count_items
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
where order_id = 440
group by category;

-- 5. BONUS: View the details of the top 5 highest spend orders.
select order_id, category, sum(price)
from order_details od left join menu_items mi
	on od.item_id = mi.menu_item_id
group by order_id, category
order by sum(price) desc
limit 5;