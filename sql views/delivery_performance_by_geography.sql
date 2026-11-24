-- View: public.delivery_performance_by_geography

-- DROP VIEW public.delivery_performance_by_geography;

CREATE OR REPLACE VIEW public.delivery_performance_by_geography
 AS
 SELECT c.customer_state AS state,
    count(*) AS delivered_orders,
    avg(o.order_delivered_customer_date - o.order_purchase_timestamp) AS avg_delivery_time,
    round(count(*) FILTER (WHERE o.order_delivered_customer_date > o.order_estimated_delivery_date)::numeric * 100.0 / count(*)::numeric, 2) AS late_delivery_percentage
   FROM customers c
     JOIN orders o ON c.customer_id::text = o.customer_id::text
  WHERE o.order_status::text <> 'canceled'::text AND o.order_delivered_customer_date IS NOT NULL AND o.order_estimated_delivery_date IS NOT NULL
  GROUP BY c.customer_state
  ORDER BY (round(count(*) FILTER (WHERE o.order_delivered_customer_date > o.order_estimated_delivery_date)::numeric * 100.0 / count(*)::numeric, 2)) DESC;

ALTER TABLE public.delivery_performance_by_geography
    OWNER TO postgres;

