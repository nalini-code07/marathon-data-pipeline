-- Fails for any expected column that is missing from stg_runners,
-- and for any extra column (withdrawn_at must not leak through).
with expected as (
    select * from (values
        ('bib_number'), ('runner_name'),
('category'), ('registered_at')
    ) as t(column_name)
),

actual as (
    select column_name
    from information_schema.columns
    where table_name = '{{
ref("stg_runners").identifier }}'
)

select column_name, 'missing' as problem from expected
where column_name not in (select column_name from actual)

union all

select column_name, 'extra' as problem from actual
where column_name not in (select column_name from expected)