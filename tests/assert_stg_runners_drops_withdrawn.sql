-- Fails for every runner that is in the wrong place:
-- a withdrawn runner who made it into stg_runners,
-- or an active runner who went missing from it.
select r.bib_number, 'withdrawn but kept' as problem from raw_runners r
join {{ ref('stg_runners') }} s on s.bib_number = r.bib_number where r.withdrawn_at is not null

union all

select r.bib_number, 'active but dropped' as problem from raw_runners r
left join {{ ref('stg_runners') }} s on s.bib_number = r.bib_number where r.withdrawn_at is null and s.bib_number is null