use sakila;

-- No. 1
-- Tampilkan semua data rental yang di mana rental tersebut dilayani oleh staff yang memiliki id = 2 dan dirental pada bulan Mei pada tanggal 25
select * from rental
where staff_id = 2 and month(rental_date) = 5 and day(rental_date) =  25;


-- No. 2
-- Tampilkan judul film, total pembayaran, dan jumlah aktor yang berpartisipasi dalam film yang diawali huruf 'A' di mana total pembayaran yang dilakukan terhadap film itu lebih besar dari 100 dollar. Jangan lupa urutkan berdasarkan total pembayaran dari yang terkecil dulu.
select film.title 'judul film', sum(payment.amount) 'total pembayaran', count(actor.actor_id) 'jumlah aktor'
from film
join film_actor using (film_id)
join actor using (actor_id)
join inventory using (film_id)
join rental using (inventory_id)
join payment using (rental_id)
where film.title like "a%"
group by film.film_id
having sum(payment.amount) > 100
order by `total pembayaran`;


-- No. 3
(
select concat(customer.first_name, ' ', customer.last_name) 'Nama Lengkap',
sum(payment.amount) 'Keuangan',
case
	when sum(payment.amount) > (
		select avg(total) from (
			select sum(amount) 'total' from payment
			join customer using (customer_id)
			group by customer_id
	) as a) then 'Pelanggan Sultan'
	when sum(payment.amount) < (
		select avg(total) from (
			select sum(amount) 'total' from payment
			join customer using (customer_id)
			group by customer_id
	) as a) then 'Pelanggan Biasa'
end 'Kategori'
from customer
join payment using (customer_id)
where first_name like "a%"
group by customer_id
)
union
(
select concat(actor.first_name, ' ', actor.last_name), sum(payment.amount),
case
	when sum(payment.amount) > (
		select avg(pendapatan) from (
			select sum(payment.amount) 'pendapatan' from actor
			join film_actor using (actor_id)
			join film using (film_id)
			join inventory using (film_id)
			join rental using (inventory_id)
			join payment using (rental_id)
			group by actor.actor_id
	) as a) then 'Artis Sultan'
    when sum(payment.amount) < (
		select avg(pendapatan) from (
			select sum(payment.amount) 'pendapatan' from actor
			join film_actor using (actor_id)
			join film using (film_id)
			join inventory using (film_id)
			join rental using (inventory_id)
			join payment using (rental_id)
			group by actor.actor_id
	) as a) then 'Artis Biasa'
end
from actor
join film_actor using (actor_id)
join film using (film_id)
join inventory using (film_id)
join rental using (inventory_id)
join payment using (rental_id)
where actor.first_name like "a%"
group by actor.actor_id
);


--------------
select film.title, count(actor.actor_id) from film
join film_category using (film_id)
join category using (category_id)
join film_actor using (film_id)
join actor using (actor_id)
where category.name = 'Sci-Fi' or category.name = 'Action'
group by film.film_id;

select avg(jumlah) from (
	select count(film.film_id) 'jumlah'
	from actor
	join film_actor using (actor_id)
	join film using (film_id)
	group by actor.actor_id
) as a;

select concat(customer.first_name, ' ', customer.last_name) 'nama lengkap', sum(amount) from customer
join payment using (customer_id)
group by customer_id
having sum(amount) > (select avg(total) from (
	select sum(amount) 'total' from payment
    join customer using (customer_id)
    group by customer_id
) as a);

select * from film
where length > (
	select avg(rata_rata) from (
		select length 'rata_rata' from film
    ) as a
);

select avg(jumlah) from (
	select count(rental.rental_id) 'jumlah' from film
	join inventory using (film_id)
	join rental using (inventory_id)
	group by film.film_id
) as a;

select concat(actor.first_name, ' ', actor.last_name) 'nama', sum(payment.amount) from actor
join film_actor using (actor_id)
join film using (film_id)
join inventory using (film_id)
join rental using (inventory_id)
join payment using (rental_id)
group by actor.actor_id
having sum(payment.amount) > (
	select avg(pendapatan) from (
		select sum(payment.amount) 'pendapatan' from actor
		join film_actor using (actor_id)
		join film using (film_id)
		join inventory using (film_id)
		join rental using (inventory_id)
		join payment using (rental_id)
		group by actor.actor_id
    ) as a
);








