{{config (materialized='table')}}


with cte as (
select n.show_id, n.cast as cast_ from {{source('netflix_data', 'netflix_titles')}} n
)
select show_id, {{unnest_comma_separated('cast_')}} as cast from cte