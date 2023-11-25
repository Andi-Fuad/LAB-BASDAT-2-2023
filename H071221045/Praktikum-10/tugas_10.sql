# Tampilkan judul dan tahun rilis film dengan durasi diatas 80 dan rating PG-13
SELECT title, release_year
FROM film
WHERE `length`>80 AND rating='PG-13';

SELECT * FROM film

# Tampilkan judul, tahun rilis, dan aktor/aktris yang membintangi film-film dengan rating R. 
# Urutkan hasilnya berdasarkan tahun rilis terbaru.
SELECT 
    f.title,
    f.release_year,
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name
FROM 
    film f
JOIN 
    film_actor fa 
	 USING(film_id)
JOIN 
    actor a
	 USING(actor_id)
WHERE 
    f.rating='R'
ORDER BY 
    f.release_year DESC;

SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM rental;
SELECT * FROM store;
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;

-- Terdapat seseorang yang menyukai menonton film, dia ingin mengetahui film apa yang bagus untuk dinonton yang memiliki genre Action dan rating R
-- saat ingin menonton film, dia ingin tahu apakah dia perlu untuk membuat popcorn, jika film tersebut diatas 90 menit, maka dia ingin menonton
-- film sambil makan popcorn, jika hanya sekitar 1 jam hingga 1 jam 30 menit, dia tidak perlu membuat popcorn. Setelah menonton film aksi tersebut
-- dia selanjutnya ingin merental film komedi untuk PG, dia ingin tahu yang mana film komedi yang dapat dirental dengan harga murah atau mahal,
-- dengan cara melihat rata-rata semua harga rental film lalu jika diatas rata-rata itu adalah film mahal, jika sebaliknya artinya film murah
-- tampilkan judul film, durasi, dan ratingnya beserta dari control flow yang diinginkan.
SELECT f.title, f.`length`,f.rating,
	 case
	 when f.`length`>90 
	 then 'Nonton Film sambil makan Popcorn'
	 when f.`length`>59 AND f.`length`<=90 
	 then 'Nonton Film tanpa makan Popcorn'
	 END AS 'a'
FROM film f
JOIN film_category fc
USING (film_id)
JOIN category c
USING (category_id)
WHERE c.name='Action' AND f.rating='R'

UNION

SELECT f.title, f.`length`, f.rating,
	 case
	 when f.rental_rate > (select AVG(rental_rate) FROM film)
	 then 'Film Mahal'
	 when f.rental_rate < (select AVG(rental_rate) FROM film)
	 then 'Film Murah'
	 end
FROM film f
JOIN film_category fc
USING (film_id)
JOIN category c
USING (category_id)
WHERE c.name='Comedy' AND f.rating='PG'