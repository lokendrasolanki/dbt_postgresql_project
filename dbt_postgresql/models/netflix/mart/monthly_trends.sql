{{config (materialized='table')}}
-- in this we will be analyzing the monthly trends of the netflix data where we will get count of  
--  tv shows and movies added each month allong with total count of tv shows and movies
with
    monthly_trends as (
        select
            type,
            DATE_TRUNC ('month', TO_DATE (date_added, 'Month DD, YYYY')) AS month_added,
            count(*) total_shows
            from {{ ref('netflix') }}
        WHERE
            date_added IS NOT NULL
        group by
            month_added,
            type
    )
select
    month_added,
    sum(
        case
            when lower(trim(type)) = 'movie' then total_shows
            else 0
        end
    ) total_movies,
    sum(
        case
            when lower(trim(type)) = 'tv show' then total_shows
            else 0
        end
    ) total_shows,
    sum(total_shows) total_movies_and_shows
from
    monthly_trends
group by
    month_added
order by
    month_added desc