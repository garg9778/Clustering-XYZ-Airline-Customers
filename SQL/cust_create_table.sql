use  expl_team_prj;             

drop table sc_cust;

create table sc_cust as
with data_clean_filter as
(
	select * 
	from 
		sun_country 
	where 
		MarketingAirlineCode='SY'
		and age<=100
		and age>=0
		and gendercode is not null
		and gendercode != ''
),
distinct_customers as
(
select 
	paxname, 
	encryptedname, 
    gendercode,
    birthdateid,
    avg(age) as avg_age,
    count(distinct ticketnum) as distinct_ticket_num,
    count(1) as num_flights,
    min(pnrcreatedate) as first_booked,
    max(pnrcreatedate) as last_booked,
    avg(STR_TO_DATE(ServiceStartDate, '%Y-%m-%d') - STR_TO_DATE(PNRCreateDate, '%Y-%m-%d')) as avg_days_booked_early,
    sum(case when BkdClassOfService = 'Coach' then 1 else 0 end) as booked_coach,
    sum(case when BkdClassOfService = 'First Class' then 1 else 0 end) as booked_first,
    sum(case when BkdClassOfService = 'Discount First Class' then 1 else 0 end) as booked_discount_first,
	sum(case when BkdClassOfService != TrvldClassOfService then 1 else 0 end) as different_booked_travelled,
    sum(case when BookingChannel = 'SCA Website Booking' then 1 else 0 end) as booking_chan_sca,
    avg(TotalDocAmt) as avg_doc_amt,
    sum(case when bookedproduct != '' then 1 else 0 end) as num_discounts,
    sum(case when UflyMemberStatus = 'Standard' then 1 else 0 end) as standard_member,
    sum(case when UflyMemberStatus = 'Elite' then 1 else 0 end) as elite_member,
    sum(case when UflyMemberStatus = '' then 1 else 0 end) as non_member,
    max(enrolldate) as enroll_date,
    sum(case when StopoverCode = '' then 1 else 0 end) as num_direct,
    sum(case when StopoverCode = 'O' then 1 else 0 end) as num_short_halt,
    sum(case when StopoverCode = 'X' then 1 else 0 end) as num_long_halt
from data_clean_filter
group by paxname, encryptedname, gendercode, birthdateid
)
select * from distinct_customers;


select * from sun_country 