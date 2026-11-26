-- Fails for any split_id that is missing from fct_splits,
-- appears more than once, or does not exist in raw_splits.
with fct as (
    select split_id, count(*) as time_seen
    from {{ ref('fct_splits') }}
    group by split_id
)

select r.split_id, 'missing' as problem
from raw_splits r
left join fct f on f.split_id = r.split_id
where f.split_id is null

union all 

select split_id, 'duplicate' as problem from fct
where times_seen > 1

union all 

select f.split_id, 'not in raw' as problem
from fct f
left join raw_splits r on r.split_id = f.split_id
where r.split_id is null