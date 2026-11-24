-- View: public.delivery_time_vs_review_score

-- DROP VIEW public.delivery_time_vs_review_score;

CREATE OR REPLACE VIEW public.delivery_time_vs_review_score
 AS
 WITH delivery_reviews AS (
         SELECT o.order_id,
            r.review_score,
                CASE
                    WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'On Time'::text
                    WHEN (o.order_delivered_customer_date - o.order_estimated_delivery_date) <= '3 days'::interval THEN '1-3 Days Late'::text
                    WHEN (o.order_delivered_customer_date - o.order_estimated_delivery_date) <= '7 days'::interval THEN '4-7 Days Late'::text
                    WHEN (o.order_delivered_customer_date - o.order_estimated_delivery_date) <= '14 days'::interval THEN '8-14 Days Late'::text
                    ELSE '15+ Days Late'::text
                END AS delay_group
           FROM orders o
             JOIN reviews r ON o.order_id::text = r.order_id::text
          WHERE o.order_status::text <> 'canceled'::text AND o.order_delivered_customer_date IS NOT NULL AND o.order_estimated_delivery_date IS NOT NULL AND r.review_score IS NOT NULL
        )
 SELECT delay_group,
    count(DISTINCT order_id) AS orders,
    round(avg(review_score), 2) AS avg_review_score,
    round(count(DISTINCT order_id)::numeric * 100.0 / sum(count(DISTINCT order_id)) OVER (), 2) AS percentage_of_orders
   FROM delivery_reviews
  GROUP BY delay_group
  ORDER BY (
        CASE delay_group
            WHEN 'On Time'::text THEN 1
            WHEN '1-3 Days Late'::text THEN 2
            WHEN '4-7 Days Late'::text THEN 3
            WHEN '8-14 Days Late'::text THEN 4
            WHEN '15+ Days Late'::text THEN 5
            ELSE NULL::integer
        END);

ALTER TABLE public.delivery_time_vs_review_score
    OWNER TO postgres;

