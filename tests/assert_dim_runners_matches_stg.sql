-- Fails for any row that is in dim_runners but not 
stg_runners, or the other way round.
(select * from {{ ref('dim_runners') }}
 except
 select * from {{ ref('stg_runners')}} )


union all

(select * from {{ ref('stg_runners')}}
 except
 select * from {{ ref('dim_runners') }})
