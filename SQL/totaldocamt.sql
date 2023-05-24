select case when BaseFareAmt = 0 then 'Crew (Base Amount = 0)' else 'Others' end as customer_type,
case when UflyMemberStatus = '' then 'Non-member' else UflyMemberStatus end as member_status,
(count(*) / (select count(*) from sc_filtered))*100 as pct_doc_amt_0
from sc_filtered
where TotalDocAmt = 0
group by case when BaseFareAmt = 0 then 'Crew (Base Amount = 0)' else 'Others' end,
case when UflyMemberStatus = '' then 'Non-member' else UflyMemberStatus end
order by 1, case member_status
when 'Elite' then 1
when 'Standard' then 2
when 'Non-member'then 3 end;


select * from sc_filtered where TotalDocAmt = 0;
