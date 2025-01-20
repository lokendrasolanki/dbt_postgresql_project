{{config (materialized='table')}}

/*
in this query we are getting data of which dirctor produces movie/tv shows in which genres along with each genre coune 
with total movies/Tv show 
*/

with
    director_genres as (
        select
            director,
            listed_in,
            count(*) as genre_count
        from
            {{ ref('netflix') }} n
            join {{ ref('netflix_listed_ins') }} nli on n.show_id = nli.show_id
        where
            n.director is not null
        group by
            director,
            listed_in
        HAVING
            COUNT(*) >= 3
    )
select
    director,
    STRING_AGG (listed_in || ' (' || genre_count || ')', ', ') as genre_distribution,
    sum(genre_count) total_titles
from
    director_genres
group by
    director
order by
    total_titles desc