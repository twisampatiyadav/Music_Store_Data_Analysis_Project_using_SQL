create database music_database;
use music_database;

## 1.Who is the senior most employee based on job title?
select last_name,first_name from employee order by levels desc limit 1;

## 2.Which countries have the most Invoices?
select count(*) as c,billing_country from invoice group by billing_country order by c desc;

## 3.What are top 3 values of total invoice?
select * from invoice order by total desc limit 3;

## 4.Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.
##   Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
select billing_city as city , sum(total) as total from invoice group by billing_city order by total desc limit 1;

## 5.Who is the best customer? The customer who has spent the most money will be declared the best customer.
##   Write a query that returns the person who has spent the most money
select distinct c.customer_id,concat(c.first_name ,c.last_name) as best_customer,sum(i.total) over(partition by c.customer_id ) as total_spent
from customer c
join invoice i on c.customer_id = i.customer_id
order by total_spent desc
limit 1;

## 6.Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
##   Return your list ordered alphabetically by email starting with A.
select distinct email as Email,first_name as FirstName, last_name as LastName, genre.name as Name
from customer
join invoice on invoice.customer_id = customer.customer_id
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
order by email;


## 7.Let's invite the artists who have written the most rock music in our dataset.
##   Write a query that returns the Artist name and total track count of the top 10 rock bands.
select distinct artist.artist_id, artist.name,COUNT(artist.artist_id) over (partition by artist.artist_id) as number_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
order by number_of_songs desc
limit 10;

## 8.Return all the track names that have a song length longer than the average song length.
##   Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first
select name,milliseconds
from track
where milliseconds > (
	select avg(milliseconds) as avg_track_length
	from track )
order by milliseconds desc;




