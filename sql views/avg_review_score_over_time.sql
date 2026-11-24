-- View: public.avg_review_score_over_time

-- DROP VIEW public.avg_review_score_over_time;

CREATE OR REPLACE VIEW public.avg_review_score_over_time
 AS
 SELECT date_trunc('month'::text, review_creation_date)::date AS review_month,
    count(*) AS review_count,
    round(avg(review_score), 2) AS avg_review_score
   FROM reviews
  WHERE review_score >= 1 AND review_score <= 5 AND review_creation_date IS NOT NULL
  GROUP BY (date_trunc('month'::text, review_creation_date))
  ORDER BY (date_trunc('month'::text, review_creation_date)::date);

ALTER TABLE public.avg_review_score_over_time
    OWNER TO postgres;

