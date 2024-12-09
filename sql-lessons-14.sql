select * from orders;

create table order_items (
    item_id uuid Primary key default uuid_generate_v1(),
    order_id uuid,
    product_id uuid default uuid_generate_v1(),
    quantity int,
    price decimal,
	foreign key (order_id) references orders(id)
)

SELECT 
    column_name, 
    data_type, 
    is_nullable, 
    column_default 
FROM 
    information_schema.columns
WHERE 
    table_name = 'order_items';

insert into order_items (order_id, quantity, price) values
    ('e9b5f417-1436-48c5-8b6e-93ab872f90b6', 3, 2),
    ('32bdf60a-62ed-4a13-826b-e57f4b44f89e', 1, 5),
    ('51a6c384-d50a-47b2-bf0f-593b81a57c09', 21, 1);

create materialized view my_orders_summary as
select 
	o.id,
	sum(oi.quantity * oi.price) as total_amount,
	count(oi.item_id) as total_items
from
	orders as o
join 
	order_items as oi on oi.order_id = o.id
group by 
	o.id;

explain analyze SELECT * FROM my_orders_summary;

SELECT * FROM my_orders_summary;

REFRESH MATERIALIZED VIEW my_orders_summary;

