# Olist Brazilian E-Commerce Dataset
# Data Quality Assessment Report

## 1. Introduction

### Objective

The purpose of this assessment is to evaluate the quality, consistency, completeness, and structural integrity of the Brazilian E-Commerce Public Dataset by Olist before conducting business analysis and developing predictive models.

The assessment examines seven relational tables and focuses on identifying potential data quality issues that could affect analytical results.

The following dimensions were investigated:

- Data completeness: identification and quantification of missing values.
- Data uniqueness: detection of duplicate records and repeated identifiers.
- Data validity: identification of invalid or suspicious numerical values.
- Data consistency: investigation of inconsistencies between related attributes.
- Referential integrity: verification of relationships between tables.
- Temporal consistency: examination of missing timestamps across order lifecycle stages.

The findings were used to establish appropriate data cleaning decisions while preserving the original source data.

---

## 2. Dataset Overview

The dataset consists of seven tables describing different aspects of Olist's e-commerce marketplace.

### 2.1 Table dimensions

| Table | Rows | Columns |
|---|---:|---:|
| Orders | 99,441 | 8 |
| Customers | 99,441 | 5 |
| Order Items | 112,650 | 7 |
| Products | 32,951 | 9 |
| Sellers | 3,095 | 4 |
| Payments | 103,886 | 5 |
| Reviews | 99,224 | 7 |
| **Total** | **630,688** | **45** |

The dataset contains 630,688 records across 45 columns.

### 2.2 Table grain and structure

Understanding the grain of each table is important to avoid incorrect joins and duplicated records during analysis.

| Table | Grain |
|---|---|
| Orders | One record per order |
| Customers | One record per customer identifier |
| Order Items | One record per item within an order |
| Products | One record per product |
| Sellers | One record per seller |
| Payments | One record per payment associated with an order |
| Reviews | One review record associated with an order |

An order can contain multiple items, involve multiple sellers, and have multiple payment records. Consequently, joining these tables without considering their relationships can multiply rows and distort aggregate calculations.

---

## 3. Missing Values Analysis

Missing values were examined across all seven tables to understand their extent and potential impact.

### 3.1 Orders table

| Column | Missing Values | Missing Percentage |
|---|---:|---:|
| order_delivered_customer_date | 2,965 | 2.98% |
| order_delivered_carrier_date | 1,783 | 1.79% |
| order_approved_at | 160 | 0.16% |

The missing timestamps are not necessarily random errors. Some are associated with orders that were canceled, unavailable, or had not progressed through the corresponding delivery stage.

These values were investigated further by comparing missing timestamps with order statuses.

### 3.2 Products table

| Column | Missing Values | Missing Percentage |
|---|---:|---:|
| product_category_name | 610 | 1.85% |
| product_name_lenght | 610 | 1.85% |
| product_description_lenght | 610 | 1.85% |
| product_photos_qty | 610 | 1.85% |
| product_weight_g | 2 | 0.01% |
| Product dimensions | 2 each | 0.01% each |

The same 610 product records are missing the category, name length, description length, and photo quantity attributes.

This suggests that these records have incomplete product metadata rather than four independent missing-value problems.

The remaining missing physical attributes affect very few records.

### 3.3 Reviews table

| Column | Missing Values | Missing Percentage |
|---|---:|---:|
| review_comment_title | 87,656 | 88.34% |
| review_comment_message | 58,247 | 58.70% |

The review text fields contain a substantial number of missing values.

However, missing review comments do not necessarily indicate poor data quality. Customers may submit a numerical review score without providing a written comment.

Therefore, these fields should not be treated as mandatory for analyses based on review scores.

### 3.4 Other tables

No missing values were identified in the remaining columns of the Customers, Order Items, Sellers, and Payments tables during the initial assessment.

---

## 4. Order Lifecycle Timestamp Investigation

Missing timestamps in the Orders table were investigated by examining their relationship with `order_status`.

This step was necessary because a missing delivery timestamp can be expected for an order that was canceled or had not reached the corresponding stage of fulfillment.

### 4.1 Missing approval timestamps

A total of 160 orders have a missing `order_approved_at` value.

| Order Status | Orders |
|---|---:|
| canceled | 141 |
| delivered | 14 |
| created | 5 |
| **Total** | **160** |

Most missing approval timestamps belong to canceled orders.

However, 14 delivered orders also have missing approval timestamps, indicating incomplete lifecycle information.

### 4.2 Missing carrier delivery timestamps

A total of 1,783 orders have a missing `order_delivered_carrier_date` value.

| Order Status | Orders |
|---|---:|
| unavailable | 609 |
| canceled | 550 |
| invoiced | 314 |
| processing | 301 |
| created | 5 |
| approved | 2 |
| delivered | 2 |
| **Total** | **1,783** |

Most missing carrier timestamps are associated with orders that were canceled, unavailable, or had not yet progressed to the carrier delivery stage.

Two delivered orders have missing carrier timestamps, indicating incomplete delivery lifecycle records.

### 4.3 Missing customer delivery timestamps

A total of 2,965 orders have a missing `order_delivered_customer_date` value.

| Order Status | Orders |
|---|---:|
| shipped | 1,107 |
| canceled | 619 |
| unavailable | 609 |
| invoiced | 314 |
| processing | 301 |
| delivered | 8 |
| created | 5 |
| approved | 2 |
| **Total** | **2,965** |

The majority of missing customer delivery timestamps are associated with orders that were not recorded as delivered.

However, eight orders marked as delivered have a missing customer delivery timestamp.

### 4.4 Key observation

A total of 23 delivered orders were identified with at least one missing timestamp among the three investigated lifecycle fields:

- 14 with missing approval timestamps.
- 2 with missing carrier delivery timestamps.
- 8 with missing customer delivery timestamps.

These category counts overlap, so they should not be added together to calculate the number of unique affected orders.

The presence of missing lifecycle timestamps in delivered orders indicates incomplete operational records.

### 4.5 Recommended treatment

Missing timestamps should not be globally deleted or replaced with estimated values.

The appropriate treatment depends on the analytical task:

- For general business analysis, retain the records and interpret missing timestamps in their operational context.
- For delivery-time calculations, exclude records that lack the timestamps required for the specific calculation.
- For supervised late-delivery prediction, include only eligible delivered orders with valid purchase, estimated delivery, and actual customer delivery timestamps.

This preserves the original information while ensuring that analytical calculations use valid observations.

---

## 5. Duplicate Records Investigation

### 5.1 Exact duplicate records

The initial assessment did not identify exact duplicate rows in the source tables.

However, a separate investigation was performed on the `review_id` column in the Reviews table because it was expected to identify individual review records.

### 5.2 Duplicate review identifiers

The investigation identified:

- 99,224 original review records.
- 789 duplicated `review_id` groups.
- 814 excess records associated with those duplicated identifiers.

The duplicated records were examined by comparing their review attributes.

The investigation found that duplicated records shared:

- The same review identifier.
- The same review score.
- The same review comment title and message.
- The same review creation and answer timestamps.
- The same customer identifier.

The main difference was the `order_id` associated with the records.

This indicated that the duplicated review identifiers represented repeated review information associated with different orders.

### 5.3 Cleaning decision

The decision was to deduplicate the Reviews table using `review_id`, keeping the first occurrence of each identifier.

This operation removes 814 excess records.

| Metric | Before Cleaning | After Cleaning |
|---|---:|---:|
| Total rows | 99,224 | 98,410 |
| Duplicate review ID groups | 789 | 0 |
| Excess records removed | — | 814 |

The original source table remains unchanged. The deduplicated version is intended to be stored separately in the cleaned dataset.

This decision prevents repeated review identifiers from potentially inflating review-related analytical results.

---

## 6. Referential Integrity Assessment

Referential integrity checks were performed to verify that records in related tables reference existing records in their parent tables.

The following relationships were investigated:

| Child Table | Reference Column | Parent Table | Parent Column |
|---|---|---|---|
| Orders | customer_id | Customers | customer_id |
| Order Items | order_id | Orders | order_id |
| Order Items | product_id | Products | product_id |
| Order Items | seller_id | Sellers | seller_id |
| Payments | order_id | Orders | order_id |
| Reviews | order_id | Orders | order_id |

No orphan records were identified in the six foreign-key relationship checks.

This indicates that the investigated records have corresponding parent records in the related tables.

It is important to distinguish referential integrity from uniqueness: a valid foreign-key reference does not necessarily mean that the referenced identifier is unique in every table. The Reviews table, for example, required a separate investigation of duplicated review identifiers.

---

## 7. Zero-Value Investigation

Numerical columns were examined for zero values that could potentially represent invalid or incomplete information.

Zero values were not automatically considered errors because their validity depends on the meaning of the corresponding attribute.

### 7.1 Product weight

Four product records were identified with a `product_weight_g` value of zero.

A product with zero physical weight is generally not meaningful for the intended weight-based analysis.

**Cleaning decision:** Convert these zero values to missing values (`NaN`) when preparing the cleaned product data.

This avoids treating invalid zero weights as legitimate measurements.

### 7.2 Payment value

Nine payment records were identified with a `payment_value` of zero.

Their payment types were:

| Payment Type | Zero-Value Records |
|---|---:|
| voucher | 6 |
| not_defined | 3 |
| **Total** | **9** |

Some affected orders also had other positive payment records.

These zero values should be investigated in the context of the complete order payment rather than automatically removed.

### 7.3 Payment installments

Two credit-card payment records were identified with zero installments.

A zero installment count is not a meaningful value for a credit-card installment payment.

**Cleaning decision:** Treat these records as invalid installment values and convert them to missing values in the relevant cleaned analytical dataset.

### 7.4 Freight value

A total of 383 records were identified with zero `freight_value`.

Unlike zero product weight or zero installments, zero freight values may be legitimate depending on the transaction.

**Cleaning decision:** Retain the values unless further business evidence establishes that they are invalid.

---

## 8. Outlier Investigation

Numerical columns were examined for potential outliers using statistical distribution analysis and the Interquartile Range (IQR) method.

The IQR method identifies observations outside the following bounds:

- Lower bound = Q1 - 1.5 × IQR
- Upper bound = Q3 + 1.5 × IQR

These observations are statistical outliers, not necessarily data entry errors.

For example, unusually high order prices, freight values, or product dimensions may represent legitimate transactions.

**Cleaning decision:** Do not automatically remove IQR outliers.

They should be interpreted in the context of the corresponding business variable and retained unless there is sufficient evidence that the values are invalid.

---

## 9. Summary of Data Quality Findings

The assessment identified several issues requiring different treatment depending on their nature.

| Data Quality Issue | Finding | Recommended Treatment |
|---|---|---|
| Missing order timestamps | Missing values across three lifecycle fields | Preserve and handle according to analytical requirements |
| Missing product metadata | 610 products missing four descriptive attributes | Preserve missing values; handle during relevant analysis |
| Missing product physical attributes | A small number of missing values | Preserve and investigate where relevant |
| Missing review comments | High proportion of missing written comments | Retain; written comments are optional |
| Duplicate review identifiers | 789 duplicated groups and 814 excess records | Deduplicate by `review_id`, keeping first |
| Referential integrity | No orphan records in six checks | No corrective action required |
| Zero product weights | 4 records | Convert to missing values for weight analysis |
| Zero payment values | 9 records | Investigate in payment context |
| Zero installments | 2 credit-card records | Treat as invalid/missing installment values |
| Zero freight values | 383 records | Retain unless proven invalid |
| Statistical outliers | Potential outliers in numerical attributes | Investigate; do not automatically delete |

---

## 10. Data Cleaning Decisions

Based on the assessment, the following cleaning decisions were established:

1. Preserve the original source tables to maintain data traceability.
2. Create cleaned copies rather than modifying the original data.
3. Deduplicate the Reviews table using `review_id`, retaining the first occurrence.
4. Convert zero product weights to missing values for appropriate analytical use.
5. Treat zero credit-card installments as invalid values.
6. Investigate zero payment values without automatically removing them.
7. Preserve zero freight values unless evidence indicates otherwise.
8. Retain missing order timestamps and handle them according to the requirements of each analysis.
9. Avoid automatically deleting statistical outliers.
10. Validate table relationships and row counts after cleaning operations.

The cleaned dataset should be stored separately from the original source tables, allowing the raw data to remain available for verification and reproducibility.

---

## 11. Conclusion

The data quality assessment provided an understanding of the completeness, consistency, and structural integrity of the Olist Brazilian E-Commerce dataset.

Although the dataset contains missing values, repeated review identifiers, and several suspicious numerical values, most issues can be handled through targeted cleaning decisions rather than indiscriminate deletion.

The investigation also demonstrated the importance of understanding the business context behind data quality problems. For example, missing delivery timestamps are often related to order status, while missing review comments are not necessarily errors.

The resulting cleaning strategy preserves useful information, avoids unnecessary data loss, and provides a more reliable foundation for subsequent SQL analysis, Power BI dashboards, and machine learning development.

**The original source data is retained, while cleaning operations are applied to separate analytical copies.**
