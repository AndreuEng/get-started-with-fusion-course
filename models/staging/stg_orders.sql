with

source as (
select * from {{ ref('raw_orders') }}
),

renamed as (
select
---------- ids
id as order_id,
store_id as location_id,
customer as customer_id,
---------- numerics
subtotal as subtotal_cents,
tax_paid as tax_paid_cents,
order_total as order_total_cents,
{{ cents_to_dollars('subtotal') }} as subtotal,

----------- made correction to this missing macro that caused the tax_paid to be set multipled by 100
{{ cents_to_dollars('tax_paid') }} as tax_paid,

{{ cents_to_dollars('order_total') }} as order_total,
---------- timestamps
cast(ordered_at as date) as order_date

from source
)
select * from renamed