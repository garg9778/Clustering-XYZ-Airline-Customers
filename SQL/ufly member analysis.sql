select * from sc_cust
order by avg_doc_amt desc;

# query for one time and repeat customers
select 
	standard_member,
    elite_member,
    non_member,
    count(1) as num_cust,
	avg(avg_age),
    avg(distinct_ticket_num),
    avg(num_flights),
    sum(case when first_booked = last_booked then 1 else 0 end) as one_time,
    sum(case when first_booked != last_booked then 1 else 0 end) as repeat_cust,
    avg(booked_coach),
    avg(booked_first),
    avg(booked_discount_first),
    avg(different_booked_travelled),
    avg(booking_chan_sca),
    avg(avg_doc_amt),
    avg(num_discounts),
    avg(num_direct),
    avg(num_short_halt),
    avg(num_long_halt)
from sc_cust
group by standard_member,
    elite_member,
    non_member;
    
    
    
select * from sc_cust
order by avg_doc_amt desc;


# query for stats by ufly member status
select 'standard_member',
    count(1) as num_cust,
    avg(avg_age),
    avg(distinct_ticket_num),
    avg(num_flights),
    sum(case when first_booked = last_booked then 1 else 0 end) as one_time,
    sum(case when first_booked != last_booked then 1 else 0 end) as repeat_cust,
    avg(booked_coach),
    avg(booked_first),
    avg(booked_discount_first),
    avg(different_booked_travelled),
    avg(booking_chan_sca),
    avg(avg_doc_amt),
    avg(num_discounts),
    avg(num_direct),
    avg(num_short_halt),
    avg(num_long_halt)
from sc_cust
where
    standard_member != 0 
group by left(last_booked, 4);


select 
	case when UflyMemberStatus ='' then 'Non-Member' else UflyMemberStatus end as member_status, 
	left(ServiceStartDate, 4) as service_start_yr,
	count(*) as num_flights,
	avg(TotalDocAmt) as amt_spent,
	sum(case when BookingChannel in ('SCA Website Booking', 'SY Vacation') then 1 else 0 end) as booked_from_sca,
    count(distinct concat(encryptedname, gendercode, birthdateid)) as num_customers
from 
sc_filtered
group by case when UflyMemberStatus ='' then 'Non-Member' else UflyMemberStatus end, left(ServiceStartDate, 4);