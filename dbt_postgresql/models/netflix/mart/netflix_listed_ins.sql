{{config (materialized='table')}}

with cte as (
select show_id, listed_in from {{source('netflix_data', 'netflix_titles')}}
)
select show_id,  unnest(string_to_array(listed_in,', ')) listed_in from cte
