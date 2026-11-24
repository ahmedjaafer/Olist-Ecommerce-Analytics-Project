-- View: public.avg_review_score_per_seller

-- DROP VIEW public.avg_review_score_per_seller;

CREATE OR REPLACE VIEW public.avg_review_score_per_seller
 AS
 WITH seller_order_reviews AS (
         SELECT oi.seller_id,
            r.order_id,
            avg(r.review_score) AS order_review_score
           FROM order_items oi
             JOIN reviews r ON oi.order_id::text = r.order_id::text
          GROUP BY oi.seller_id, r.order_id
        )
 SELECT s.seller_id,
    concat(initcap(s.seller_city::text), ', ', s.seller_state, ' (', "right"(s.seller_id::text, 4), ')') AS seller_label,
    count(*) AS reviewed_orders,
    round(avg(sor.order_review_score), 2) AS avg_review_score
   FROM seller_order_reviews sor
     JOIN sellers s ON sor.seller_id::text = s.seller_id::text
  GROUP BY s.seller_id, s.seller_city, s.seller_state
  ORDER BY (count(*)) DESC;

ALTER TABLE public.avg_review_score_per_seller
    OWNER TO postgres;

