use sakila;

-- query 1
select title,rating from film where length in(select MIN(length) from film);

-- query 2
select title from film where length in(select MIN(length) from film) and (select count(length) from film where length in(select MIN(length) from film)) =1;

-- query 3
select distinct c.customer_id,c.first_name,c.last_name,c.email, a.*, p.amount as lowest_payment from
((
customer c inner join address a on c.address_id = a.address_id
) inner join payment p on c.customer_id = p.customer_id)
WHERE p.amount <= ALL (SELECT amount FROM payment WHERE customer_id = c.customer_id);

-- query 4
select distinct c.*,min(p.amount) as lowest_payment ,max(p.amount) as highest_payment from
(customer c inner join payment p on c.customer_id = p.customer_id)
group by c.customer_id;