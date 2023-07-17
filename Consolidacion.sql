--Agregar, actualizar y eliminar instancias de actor, staff y customer

--Actor
insert into actor values(default,'Forest', 'Whitaker', default);
update actor 
set first_name = 'Al',
	last_name = 'Pacino'
where actor_id = 202;
delete from actor where actor_id=202;

--Staff
insert into staff values(default, 'Pablo', 'Gutierrez', 606, 'pablo.gutierrez.u@gmail.com', 1, default, 'pablo_rmk', default, default, null)
update staff 
set email = 'pablo.rain.maker@gmail.com',
	password = '12345678'
where staff_id = 3;
delete from staff where staff_id=3;

--Customer
insert into customer values(default, 1, 'Jośe', 'Lota', 'pepelota@gmail.com', 6, default, default, default, 1);
update customer
set address_id = 10,
	first_name = 'Pepe',
	email = 'pepe.lota@hotmail.com'
where customer_id = 600;
delete from actor where actor_id=600

-- Listar rentals y customers dado un año y mes
select 	dos.rental_id,
		dos.title,
		uno.customer_id,
		uno.first_name, 
		uno.last_name, 
		uno.email, 
		uno.address, 
		uno.district, 
		uno.postal_code, 
		uno.phone, 
		uno.city, 
		uno.country,
		extract(month from rental_date) rental_month,
		extract(year from rental_date) rental_year
from 
		(select cu.customer_id, 
		 		cu.first_name, 
		 		cu.last_name, cu.email, 
		 		adcico.address, adcico.district, 
		 		adcico.postal_code, adcico.phone, 
		 		adcico.city, adcico.country  
		 from customer cu 
		 inner join 
		 		(select ad.address_id, 
				 		ad.address, 
				 		ad.district, 
				 		ad.postal_code, 
				 		ad.phone, 
				 		cico.city, 
				 		cico.country 
				 from address ad 
				 inner join 
				 		(select ci.city_id, 
						 		ci.city, co.country 
						 from city ci 
						 inner join country co 
						 on ci.country_id = co.country_id) cico 
				 on cico.city_id = ad.city_id) adcico 
		 on cu.address_id = adcico.address_id) uno 
						 inner join 
						 		(select ren.rental_id, 
								 		ren.customer_id, 
								 		ren.rental_date, 
								 		infil.title 
								 from rental ren 
								 inner join 
								 		(select inv.inventory_id, 
										 		fil.title 
										 from inventory inv 
										 inner join film fil 
										 on inv.film_id = fil.film_id) infil 
								  on infil.inventory_id = ren.inventory_id) dos 
on uno.customer_id = dos.customer_id
where extract(month from rental_date) = 8 
and extract(year from rental_date) = 2005
order by dos.title;

-- Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.

select payment_id, date(payment_date), amount from payment

-- Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.

select 	film_id, 
		title, 
		description, 
		rating, 
		release_year, 
		rental_rate
from film 
where rental_rate > 4 
and release_year = 2006 
order by film_id
--	Todas las peliculas tienen release_year =  2006 en la tabla film, por lo que la instruccion "where rental_rate > 4 and release_year = 2006"
-- podría simplificarse a "where rental_rate > 4", sólo para este caso.

-- Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si
-- éstas pueden ser nulas, y su tipo de dato correspondiente.

SELECT  t1.TABLE_NAME AS nombre_tabla,
 		t1.COLUMN_NAME AS nombre_columna,
 		t1.IS_NULLABLE AS puede_ser_nulo,
 		t1.DATA_TYPE AS tipo_de_dato
FROM INFORMATION_SCHEMA.COLUMNS t1
INNER JOIN PG_CLASS t2 
ON (t2.RELNAME = t1.TABLE_NAME)
WHERE t1.TABLE_SCHEMA = 'public'
ORDER BY t1.TABLE_NAME;


