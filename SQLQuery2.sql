/* 4.
select distinct
	trim(translate(a.order_id,'PO0','   ')) as [Order Reference],
	((case when order_date like '%-0%' then convert(date, order_date, 105)
		else convert(date,order_date,105) end)) as [Order Period],
	Supplier_Name as [Supplier Name],
	Order_total_amount as [Ordert Total Amount],
	Order_status as [Order Status],
	Invoice_reference as [Invoice Reference],
	case when c.INVOICE_STATUS = 'paid' then 'OK'
		when c.INVOICE_STATUS = 'Pending' then 'To Follow Up'
		else 'To Verify' end as [Action],
	c.INVOICE_STATUS
from orders a
join suppliers b
on a.supplier_id = b.supplier_id
join invoice c
on a.ORDER_ID = c.ORDER_ID
order by 2 desc
*/
/*
select distinct
	a.order_id,
	order_date,
	Supplier_name,
	cast(replace(translate(order_total_amount,',',' '),' ','') as int),
	order_status,
	c.INVOICE_REFERENCE
from orders a
join suppliers b
on a.supplier_id = b.supplier_id
join invoice c
on a.ORDER_ID = c.ORDER_ID
--order by 4 desc
where cast(replace(translate(order_total_amount,',',' '),' ','') as int) in ( 
			select distinct
				cast(replace(translate(order_total_amount,',',' '),' ','') as int)
			from orders
			order by 1 desc
			offset 2 rows
			fetch first 1 rows only)
*/

/* 5.
select distinct
	a.order_id,
	order_date,
	Supplier_name,
	ORDER_TOTAL_AMOUNT,
	order_status,
	c.INVOICE_REFERENCE
from orders a
join suppliers b
on a.supplier_id = b.supplier_id
join invoice c
on a.ORDER_ID = c.ORDER_ID
where a.order_id in 
(select 
 order_id
 from orders
 where cast(replace(translate(order_total_amount,',',' '),' ','') as int) in ( 
			select distinct
				cast(replace(translate(order_total_amount,',',' '),' ','') as int)
			from orders
			order by 1 desc
			offset 2 rows
			fetch first 1 rows only))
*/

/* 6.
select 
	SUPPLIER_NAME,
	a.supp_contact_name,
	SUBSTRING(a.supp_contact_number, 1, charindex(',',a.supp_contact_number)) as [Contact Number 1],
	SUBSTRING(a.supp_contact_number, charindex(',',a.supp_contact_number), len(a.supp_contact_number)) as [Contact Number 2],
	count(1) as [Total Number of Orders],
	sum(cast(replace(translate(order_total_amount,',',' '),' ','') as int)) Total_order
from  suppliers a
join orders b
	on a.supplier_id = b.supplier_id
group by a.SUPPLIER_NAME, a.supp_contact_name,
SUBSTRING(a.supp_contact_number, 1, charindex(',',a.supp_contact_number)),
SUBSTRING(a.supp_contact_number, charindex(',',a.supp_contact_number), len(a.supp_contact_number))
*/






