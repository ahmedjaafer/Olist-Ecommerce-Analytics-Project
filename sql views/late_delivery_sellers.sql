-- View: public.late_delivery_sellers

-- DROP VIEW public.late_delivery_sellers;

CREATE OR REPLACE VIEW public.late_delivery_sellers
 AS
 WITH seller_delivery AS (
         SELECT oi.seller_id,
            o.order_id,
            o.order_delivered_customer_date,
            o.order_estimated_delivery_date
           FROM order_items oi
             JOIN orders o ON oi.order_id::text = o.order_id::text
          WHERE o.order_status::text = 'delivered'::text AND o.order_delivered_customer_date IS NOT NULL AND o.order_estimated_delivery_date IS NOT NULL
        )
 SELECT s.seller_id,
    concat(initcap(s.seller_city::text), ', ', s.seller_state, ' (', "right"(s.seller_id::text, 4), ')') AS seller_label,
    count(DISTINCT sd.order_id) AS delivered_orders,
    count(DISTINCT sd.order_id) FILTER (WHERE sd.order_delivered_customer_date > sd.order_estimated_delivery_date) AS late_orders,
    round(count(DISTINCT sd.order_id) FILTER (WHERE sd.order_delivered_customer_date > sd.order_estimated_delivery_date)::numeric / NULLIF(count(DISTINCT sd.order_id), 0)::numeric * 100::numeric, 2) AS late_delivery_rate_pct
   FROM seller_delivery sd
     JOIN sellers s ON sd.seller_id::text = s.seller_id::text
  GROUP BY s.seller_id, s.seller_city, s.seller_state
  ORDER BY (round(count(DISTINCT sd.order_id) FILTER (WHERE sd.order_delivered_customer_date > sd.order_estimated_delivery_date)::numeric / NULLIF(count(DISTINCT sd.order_id), 0)::numeric * 100::numeric, 2)) DESC;

ALTER TABLE public.late_delivery_sellers
    OWNER TO postgres;

