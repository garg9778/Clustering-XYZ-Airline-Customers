with num_tickets as 
(
	select UflyMemberStatus, 
	avg(TotalDocAmt) as avg_doc_amt, count(distinct PNRLocatorID) as num_tickets  
	from sc_filtered 
	group by UflyMemberStatus
),
num_passengers as
(
	select UflyMemberStatus, 
    count(distinct concat(paxname, encryptedname, gendercode, birthdateid)) as num_cust
    from sc_filtered
    group by UflyMemberStatus
)
select 
	case when num_tickets.UflyMemberStatus = '' then 'Non-member' else num_tickets.UflyMemberStatus end as UflyMemberStatus,
    num_tickets.avg_doc_amt,
    num_tickets.num_tickets/ num_passengers.num_cust as avg_tickets_per_cust
from num_tickets
inner join num_passengers
on num_tickets.UflyMemberStatus = num_passengers.UflyMemberStatus;

select * from sc_cust;

select avg(TotalDocAmt) from sc_filtered where UflyMemberStatus = 'Elite' and BkdClassOfService = 'First Class' and CouponSeqNbr = '1';

select distinct ServiceStartDate from sc_filtered;

select distinct cardholder from sc_filtered ;

select distinct UflyMemberStatus from sc_filtered;

select * from sc_filtered where UflyMemberStatus = '' and cardholder = 'true';

select (select count(8) from sc_filtered where TotalDocAmt = 0)/ ((select count(8) from sc_filtered));

select count(1), UflyMemberStatus, BkdClassOfService
from sc_filtered 
where TotalDocAmt = 0
group by UflyMemberStatus, BkdClassOfService;

select *
from sc_filtered 
where TotalDocAmt = 0;


select count(8) from sc_filtered;

select * from sc_filtered;

select * from sc_cust
