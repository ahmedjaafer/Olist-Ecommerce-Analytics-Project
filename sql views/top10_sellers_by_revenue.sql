-- View: public.top10_sellers_by_revenue

-- DROP VIEW public.top10_sellers_by_revenue;

CREATE OR REPLACE VIEW public.top10_sellers_by_revenue
 AS
 WITH seller_revenue AS (
         SELECT oi.seller_id,
            sum(p.payment_value * oi.price / NULLIF(order_totals.item_total, 0::numeric)) AS revenue
           FROM order_items oi
             JOIN orders o ON oi.order_id::text = o.order_id::text
             JOIN ( SELECT payments.order_id,
                    sum(payments.payment_value) AS payment_value
                   FROM payments
                  GROUP BY payments.order_id) p ON oi.order_id::text = p.order_id::text
             JOIN ( SELECT order_items.order_id,
                    sum(order_items.price) AS item_total
                   FROM order_items
                  GROUP BY order_items.order_id) order_totals ON oi.order_id::text = order_totals.order_id::text
          WHERE o.order_status::text <> 'canceled'::text
          GROUP BY oi.seller_id
        )
 SELECT s.seller_id,
    concat(initcap(s.seller_city::text), ', ', s.seller_state, ' (', "right"(s.seller_id::text, 4), ')') AS seller_label,
    round(sr.revenue, 2) AS total_revenue
   FROM seller_revenue sr
     JOIN sellers s ON sr.seller_id::text = s.seller_id::text
  ORDER BY sr.revenue DESC
 LIMIT 10;

ALTER TABLE public.top10_sellers_by_revenue
    OWNER TO postgres;

