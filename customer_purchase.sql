
select * from customer limit 20

select gender,sum(purchase_amount) as revenue
from customer 
group by gender


select customer_id,purchase_amount
from customer
where discount_applied='Yes'
AND purchase_amount >= ( select AVG(purchase_amount)
from customer)


select item_purchased,round(avg (review_rating ::numeric),2)
from customer
group by item_purchased
order by avg (review_rating )desc 
limit 5


select round(avg (purchase_amount :: numeric),2 ),shipping_type
from customer 
where shipping_type in ('Standard','Express')
group by shipping_type 


select subscription_status,
count(customer_id) as total_customer,
round(avg (purchase_amount),2) ag,
round(sum(purchase_amount),2) as sm
from customer
group by subscription_status


select  item_purchased,
round(100 * sum ( case when discount_applied='Yes' then 1
else 0 end )/count(*),2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5


with customer_type as (
select customer_id,previous_purchases,
case 
    when previous_purchases = 1 then 'new'
	when previous_purchases between 2 and 10 then 'returning'
	else 'loyal'
	end as customer_segment
from customer)
select customer_segment,count(*) as "number of customer"
from customer_type
group by customer_segment 



 
with item_counts as(
select category,
item_purchased,
count(customer_id) as total_orders,
row_number() over(partition by category order by count
(customer_id) desc) as item_rank 
from customer
group by category , item_purchased
)
select item_rank,category,item_purchased,total_orders
from item_counts
where item_rank <= 3;



select subscription_status,
count(customer_id) as repeat_buyers
from customer
where previous_purchases > 5
group by subscription_status





select age_group,
sum(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc


















