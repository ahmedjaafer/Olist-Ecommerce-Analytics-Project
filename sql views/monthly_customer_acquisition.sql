-- View: public.monthly_customer_acquisition

-- DROP VIEW public.monthly_customer_acquisition;

CREATE OR REPLACE VIEW public.monthly_customer_acquisition
 AS
 WITH first_purchase AS (
         SELECT orders.customer_id,
            date_trunc('month'::text, min(orders.order_purchase_timestamp)) AS first_purchase_month
           FROM orders
          GROUP BY orders.customer_id
        )
 SELECT first_purchase_month AS month,
    count(*) AS new_customers
   FROM first_purchase
  GROUP BY first_purchase_month
  ORDER BY first_purchase_month;

ALTER TABLE public.monthly_customer_acquisition
    OWNER TO postgres;

