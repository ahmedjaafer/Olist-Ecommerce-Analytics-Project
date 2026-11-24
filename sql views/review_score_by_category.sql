-- View: public.review_score_by_category

-- DROP VIEW public.review_score_by_category;

CREATE OR REPLACE VIEW public.review_score_by_category
 AS
 WITH category_order_reviews AS (
         SELECT p.product_category_name,
            r.order_id,
            avg(r.review_score) AS order_review_score
           FROM reviews r
             JOIN order_items oi ON r.order_id::text = oi.order_id::text
             JOIN products p ON oi.product_id::text = p.product_id::text
          WHERE r.review_score >= 1 AND r.review_score <= 5 AND p.product_category_name IS NOT NULL
          GROUP BY p.product_category_name, r.order_id
        )
 SELECT product_category_name,
    count(*) AS reviewed_orders,
    round(avg(order_review_score), 2) AS avg_review_score
   FROM category_order_reviews
  GROUP BY product_category_name
  ORDER BY (round(avg(order_review_score), 2)) DESC;

ALTER TABLE public.review_score_by_category
    OWNER TO postgres;

