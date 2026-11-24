# Olist E-Commerce Analytics & Late Delivery Prediction

An end-to-end Brazilian e-commerce analytics project leveraging Python, PostgreSQL, and Power BI to assess business performance, uncover actionable insights, and explore sales, customer, seller, and delivery trends. Includes comprehensive data quality analysis, interactive dashboards, and an XGBoost model for late-delivery prediction.

---

## 1. Project Overview

This project explores the Brazilian E-Commerce Public Dataset by Olist, which contains approximately 100,000 orders made between 2016 and 2018.

The objective is to transform raw transactional data into meaningful business insights through data exploration, data quality assessment, SQL-based analysis, interactive visualization, and machine learning.

The project covers multiple aspects of e-commerce operations, including sales performance, product categories, customer behavior, seller performance, payment methods, customer satisfaction, and delivery efficiency.

In addition to historical business analysis, a machine learning model is developed to identify orders at risk of late delivery, providing an opportunity to explore how predictive analytics can support operational decision-making.

## 2. Business Objectives

The main objectives of this project are to:

- Understand and assess the quality of a real-world e-commerce dataset.
- Identify missing values, duplicates, inconsistencies, and data integrity issues.
- Prepare and analyze relational data using PostgreSQL and SQL.
- Investigate sales, product, customer, seller, payment, and delivery performance.
- Identify relationships between delivery performance and customer satisfaction.
- Develop interactive Power BI dashboards to communicate business findings.
- Build and evaluate machine learning models for late-delivery prediction.
- Translate analytical findings into actionable business recommendations.

## 3. Technologies & Tools

| Technology | Purpose |
|---|---|
| Python | Data exploration, cleaning, preparation, and machine learning |
| Pandas & NumPy | Data manipulation and numerical analysis |
| Matplotlib & Seaborn | Data visualization |
| PostgreSQL | Relational database management |
| SQL | Data exploration, business analysis, and analytical views |
| Power BI | Interactive dashboards and business intelligence |
| Scikit-learn | Data preprocessing and machine learning |
| XGBoost | Gradient-boosted classification model |
| Jupyter Notebook | Interactive development and analysis |

## 4. Dataset

This project uses the **Brazilian E-Commerce Public Dataset by Olist**, available on Kaggle.

**Dataset source:** [Brazilian E-Commerce Public Dataset by Olist – Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains approximately 100,000 orders and several relational tables describing different aspects of the marketplace.

### Dataset tables

| Table | Description |
|---|---|
| Orders | Order status and purchase, approval, and delivery timestamps |
| Customers | Customer identifiers and geographical information |
| Order Items | Products purchased, sellers, prices, and freight values |
| Products | Product categories and physical attributes |
| Sellers | Seller identifiers and geographical information |
| Payments | Payment methods, values, and installments |
| Reviews | Customer review scores and comments |

**Note:** The original dataset files are not included in this repository due to their size. Download them directly from Kaggle before reproducing the project.

## 5. Project Workflow

The project follows an end-to-end analytical workflow:

1. Data collection and database setup.
2. Data understanding and exploration.
3. Data quality assessment.
4. Data cleaning and preparation.
5. SQL business analysis and cross-analysis.
6. Power BI dashboard development.
7. Machine learning data preparation and feature engineering.
8. Predictive model development and evaluation.
9. Business recommendations.

## 6. Data Understanding & Quality Assessment

The seven source tables were explored to understand their structure, relationships, data types, and completeness.

The initial dataset contains:

- 630,688 total records across seven tables.
- 45 columns in total.
- Approximately 99,441 orders.

The data quality assessment investigated:

- Missing values across all tables.
- Duplicate records and repeated review identifiers.
- Invalid and potentially inconsistent values.
- Zero-valued numerical attributes.
- Referential integrity between related tables.
- Missing order lifecycle timestamps.

Special attention was given to understanding the context of missing values rather than automatically deleting or imputing them.

Cleaning decisions were made according to the analytical purpose of each dataset, while preserving the original source data.

## 7. SQL Business Analysis

PostgreSQL was used to structure the data and perform business-oriented analysis.

A collection of 26 SQL views was developed to organize analytical queries and make the results accessible for further analysis and Power BI visualization.

### Main analytical areas

**Sales & Revenue Analysis**
- Revenue trends over time.
- Month-over-month revenue growth.
- Revenue distribution across geographical regions.

**Product Analysis**
- Product and category performance.
- Revenue contribution by product category.
- Product price and sales analysis.

**Customer Analysis**
- Customer acquisition trends.
- Geographical distribution of customers.
- Customer-related purchasing patterns.

**Seller Analysis**
- Top sellers by order volume.
- Top sellers by revenue.
- Seller delivery performance.

**Payment Analysis**
- Payment method distribution.
- Revenue by payment method.
- Installment behavior.

**Delivery Analysis**
- On-time versus late deliveries.
- Monthly delivery performance.
- Delivery performance across geographical regions.
- Seller-related delivery patterns.

**Customer Satisfaction Analysis**
- Review score distribution.
- Average review scores over time.
- Relationship between delivery time and customer satisfaction.
- Review performance across product categories and sellers.

**Cross-Analysis**
- Delivery performance versus customer satisfaction.
- Category revenue versus customer satisfaction.
- Geographical delivery performance.
- Seller-related operational performance.

## 8. Power BI Dashboard

An interactive Power BI dashboard was developed to communicate the main findings and provide an overview of marketplace performance.

### Dashboard pages

- **Data Understanding:** Dataset overview and key structural information.
- **Data Quality:** Missing values, duplicates, and data quality indicators.
- **Executive KPIs:** High-level marketplace performance indicators.
- **Time Analysis:** Order and revenue trends over time.
- **Product Analysis:** Product and category performance.
- **Customer Analysis:** Customer-related insights.
- **Business Recommendations:** Proposed actions based on analytical findings.

The dashboard connects historical business performance with practical recommendations for improving operational efficiency and customer experience.

Dashboard screenshots and the Power BI file are provided in the `power_bi/` directory.

## 9. Machine Learning: Late Delivery Prediction

### 9.1 Business Problem

Late deliveries can negatively affect customer satisfaction and marketplace performance.

The objective of this machine learning task is to predict whether an order will arrive later than its estimated delivery date, using information available at the time of purchase.

This can potentially help identify orders that deserve additional operational monitoring.

### 9.2 Target Definition

The target variable is `late_delivery`:

- `1`: Actual customer delivery date is later than the estimated delivery date.
- `0`: Actual customer delivery date is on time or earlier.

Only delivered orders with the required timestamps were included in the supervised modeling dataset.

The final modeling dataset contained 96,470 eligible orders:

| Delivery outcome | Orders | Percentage |
|---|---:|---:|
| On time or early | 88,644 | 91.89% |
| Late | 7,826 | 8.11% |
| **Total** | **96,470** | **100%** |

### 9.3 Feature Engineering

Features were constructed using information available at purchase time.

Examples include:

- Purchase hour, weekday, month, and quarter.
- Weekend purchase indicator.
- Estimated delivery duration.
- Number of items per order.
- Total order price.
- Total freight value.
- Number of sellers involved.
- Main product category.
- Customer and seller geographical information.
- Same-state customer and seller indicator.

Post-purchase information, such as actual delivery timestamps and carrier handover dates, was not used as a predictor.

### 9.4 Model Development

Four classification algorithms were evaluated:

1. Logistic Regression
2. Random Forest
3. HistGradientBoosting
4. XGBoost

A chronological training, validation, and testing strategy was used to evaluate the models on progressively later periods.

The preprocessing pipeline included numerical imputation and scaling, categorical imputation, and one-hot encoding.

Class imbalance was addressed during model development, and classification thresholds were selected using validation data.

### 9.5 Model Comparison

The following results were obtained on the untouched test set:

| Model | Accuracy | Late Precision | Late Recall | Late F1 | PR-AUC |
|---|---:|---:|---:|---:|---:|
| Logistic Regression | 91.29% | 12.16% | 10.38% | 11.20% | 10.46% |
| Random Forest | 89.83% | 10.23% | 11.85% | 10.98% | 9.76% |
| HistGradientBoosting | 89.39% | 10.66% | 13.61% | 11.96% | 10.18% |
| **XGBoost** | **87.44%** | **14.12%** | **27.03%** | **18.55%** | **11.70%** |

XGBoost achieved the strongest overall late-delivery detection performance among the evaluated models.

### 9.6 Final Model Evaluation

The selected XGBoost model achieved:

| Metric | Result |
|---|---:|
| Selected classification threshold | 0.50 |
| Accuracy | 87.44% |
| Late precision | 14.12% |
| Late recall | 27.03% |
| Late F1-score | 18.55% |
| Average Precision (PR-AUC) | 11.70% |

Despite outperforming the other evaluated models on late-delivery detection, the results reveal important limitations.

The model identifies approximately 27% of actual late orders, while its relatively low precision indicates a substantial number of false-positive predictions.

Therefore, the model should be considered a proof of concept for delivery-risk identification rather than a production-ready prediction system.

## 10. Business Recommendations

Based on the business analysis and predictive modeling, several potential actions can be considered:

**1. Proactive Delivery Monitoring**

Use predictive risk scores to identify orders that may require additional monitoring and operational follow-up.

**2. Seller Performance Management**

Monitor sellers with recurring delivery issues and investigate opportunities to improve order preparation and dispatch processes.

**3. Regional Logistics Optimization**

Identify geographical areas with weaker delivery performance and investigate possible logistics bottlenecks.

**4. More Realistic Delivery Estimates**

Review estimated delivery windows in areas or situations where historical delivery performance indicates systematic delays.

**5. Improved Customer Communication**

Provide proactive delivery updates and revised delivery expectations when delays become likely.

These recommendations represent proposed business actions based on historical analysis and predictive findings. Their actual effectiveness would need to be validated through operational implementation.

## 11. Project Limitations

Several limitations should be considered:

- The dataset represents historical marketplace activity from 2016 to 2018.
- The dataset does not provide a complete view of the operational causes behind delivery delays.
- The late-delivery target is imbalanced, with late orders representing approximately 8.11% of eligible modeling records.
- The selected XGBoost model has limited late-delivery precision and recall.
- The model has not been deployed into a live operational environment.
- Predictive performance on future data may differ from the historical test results.

Further improvements could include additional logistics-related features, better access to operational data, model calibration, and evaluation on more recent datasets.

## 12. Repository Structure

```text
olist-ecommerce-analytics/
│
├── README.md
├── requirements.txt
├── .gitignore
│
├── data/
│   └── README.md
│
├── notebooks/
│   └── [Jupyter notebooks]
│
├── sql/
│   ├── data_quality/
│   ├── business_analysis/
│   ├── cross_analysis/
│   └── views/
│
├── power_bi/
│   ├── Olist_Analytics_Dashboard.pbix
│   └── screenshots/
│
├── machine_learning/
│   └── [Machine learning notebooks and results]
│
└── reports/
    └── business_recommendations.md
```

## 13. How to Reproduce the Project

### Prerequisites

- Python
- PostgreSQL
- pgAdmin (optional, for database management)
- Power BI Desktop
- Jupyter Notebook or JupyterLab

### Step 1: Obtain the Dataset

Download the original dataset from:

[Olist Brazilian E-Commerce Dataset – Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

### Step 2: Set Up PostgreSQL

Create a PostgreSQL database and import the downloaded CSV files into the appropriate tables.

### Step 3: Execute SQL Scripts

Run the SQL scripts provided in the `sql/` directory to perform the analyses and recreate the analytical views.

### Step 4: Set Up Python

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/olist-ecommerce-analytics.git

cd olist-ecommerce-analytics
```

Install the required dependencies:

```bash
pip install -r requirements.txt
```

Configure your PostgreSQL connection using your own local database credentials. Do not commit passwords or other secrets.

### Step 5: Run the Notebooks

Open JupyterLab or Jupyter Notebook and execute the notebooks in the appropriate order.

### Step 6: Explore the Power BI Dashboard

Open the `.pbix` file using Power BI Desktop and configure the database connection for your local PostgreSQL environment.

## 14. Author

**[Your Name]**

Data Analytics & Big Data Graduate

- GitHub: [Your GitHub Profile](https://github.com/YOUR_USERNAME)
- LinkedIn: [Your LinkedIn Profile](https://www.linkedin.com/)

---

*This project was developed as a practical demonstration of end-to-end data analytics, business intelligence, and predictive modeling using a real-world e-commerce dataset.*
