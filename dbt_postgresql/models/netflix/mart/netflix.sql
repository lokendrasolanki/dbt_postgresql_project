{{config (materialized='table')}}


with cte as (
SELECT show_id, type, title, director, date_added, release_year, rating, duration, description
	from {{source('netflix_data', 'netflix_titles')}} n
)
select * from cte