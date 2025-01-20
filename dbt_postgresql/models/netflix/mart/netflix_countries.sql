{{config (materialized='table')}}

with cte as (
select show_id, country from {{source('netflix_data', 'netflix_titles')}}
)
select show_id, {{unnest_comma_separated('country')}} as country from cte