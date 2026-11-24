-- View: public.freight_cost_vs_order_value

-- DROP VIEW public.freight_cost_vs_order_value;

CREATE OR REPLACE VIEW public.freight_cost_vs_order_value
 AS
 WITH order_metrics AS (
         SELECT oi.order_id,
            count(*) AS item_count,
            count(DISTINCT oi.seller_id) AS seller_count,
            sum(oi.price) AS order_value,
            sum(oi.freight_value) AS freight_cost
           FROM order_items oi
          GROUP BY oi.order_id
        )
 SELECT o.order_id,
    o.order_purchase_timestamp::date AS order_date,
    c.customer_state,
    om.item_count,
    om.seller_count,
    round(om.order_value, 2) AS order_value,
    round(om.freight_cost, 2) AS freight_cost,
    round(om.freight_cost / NULLIF(om.order_value, 0::numeric) * 100::numeric, 2) AS freight_pct_of_order_value
   FROM orders o
     JOIN order_metrics om ON o.order_id::text = om.order_id::text
     JOIN customers c ON o.customer_id::text = c.customer_id::text
  WHERE o.order_status::text <> 'canceled'::text
  ORDER BY (round(om.freight_cost / NULLIF(om.order_value, 0::numeric) * 100::numeric, 2)) DESC;

ALTER TABLE public.freight_cost_vs_order_value
    OWNER TO postgres;

