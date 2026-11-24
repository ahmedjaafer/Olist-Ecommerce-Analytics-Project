# Olist Brazilian E-Commerce Analytics
# Business Recommendations Report

## 1. Executive Summary

This report presents strategic recommendations based on the analysis of the Brazilian E-Commerce Public Dataset by Olist.

The project investigated marketplace performance across several business dimensions, including sales, products, customers, sellers, payments, delivery operations, and customer satisfaction.

The analysis was conducted using Python, PostgreSQL, SQL, Power BI, and machine learning techniques.

In addition to identifying historical business patterns, a predictive model was developed to explore the possibility of identifying orders at risk of late delivery.

The findings highlight opportunities to improve delivery monitoring, seller performance management, regional logistics, delivery estimates, and customer communication.

The recommendations in this report are proposed actions based on historical analytical findings. Their effectiveness would need to be validated through implementation and subsequent performance monitoring.

---

## 2. Business Context

E-commerce marketplaces depend on several interconnected operational processes to deliver a satisfactory customer experience.

Order processing, seller performance, logistics, delivery estimates, and customer communication can all influence marketplace performance.

The Olist dataset provides information about these processes through transactional records, delivery timestamps, geographical attributes, payment information, and customer reviews.

The project examined these dimensions to identify potential areas for operational improvement.

The main business priorities identified for further investigation are:

1. Improving delivery performance and reducing late deliveries.
2. Monitoring seller operational performance.
3. Identifying geographical areas requiring logistics attention.
4. Improving the accuracy of estimated delivery dates.
5. Protecting customer satisfaction through better communication.
6. Using predictive analytics to support proactive delivery monitoring.

---

## 3. Key Analytical Findings

### 3.1 Delivery Performance

Delivery performance was investigated using order purchase dates, estimated delivery dates, actual delivery dates, and order statuses.

The analysis included:

- Monthly delivery performance.
- On-time versus late delivery comparisons.
- Delivery performance across geographical regions.
- Seller-related delivery performance.
- The relationship between delivery time and customer review scores.

The analysis provides a basis for identifying delivery patterns and investigating potential operational bottlenecks.

**Business implication:**

Delivery performance should be monitored continuously rather than evaluated only through overall marketplace averages. Monthly, regional, and seller-level analysis can help identify areas that deserve further investigation.

### 3.2 Seller Performance

Seller performance was investigated using order volumes, revenue-related measures, and delivery performance.

The analysis included:

- Top sellers by order volume.
- Top sellers by revenue.
- Seller delivery performance.
- Average review scores per seller.

These dimensions provide complementary views of seller activity.

A seller with high order volume or revenue may have a significant operational impact on the marketplace. However, commercial performance alone does not establish delivery reliability or customer satisfaction.

**Business implication:**

Seller performance management should combine commercial indicators with operational and customer satisfaction metrics.

### 3.3 Geographical Performance

The analysis examined customer and seller geographical information to investigate differences in sales and delivery performance across Brazilian states.

Relevant analyses included:

- Revenue distribution by state.
- Category revenue across geographical regions.
- Delivery performance by geography.
- Customer and seller location comparisons.

Geographical differences may reflect variations in transportation distances, logistics infrastructure, seller distribution, or other operational factors.

However, these factors cannot be established as the causes of observed differences using the available dataset alone.

**Business implication:**

Regional delivery performance should be monitored to identify areas that may benefit from additional logistics investigation.

### 3.4 Customer Satisfaction

Customer satisfaction was investigated using review scores and review-related information.

The analysis included:

- Review score distribution.
- Average review scores over time.
- Review scores across product categories.
- Average review scores per seller.
- Delivery time versus review score.
- Category revenue versus customer satisfaction.

These analyses help investigate how customer satisfaction varies across different aspects of marketplace activity.

Delivery performance deserves particular attention because the relationship between delivery time and review scores can help identify potential customer experience issues.

**Business implication:**

Delivery-related customer experience should be treated as an important operational performance indicator alongside sales and revenue.

### 3.5 Late-Delivery Prediction

A machine learning model was developed to investigate whether orders could be classified as late or on time using information available at purchase time.

Four algorithms were evaluated:

- Logistic Regression.
- Random Forest.
- HistGradientBoosting.
- XGBoost.

XGBoost achieved the strongest late-delivery detection results on the chronological test set.

Its test performance was:

| Metric | Result |
|---|---:|
| Accuracy | 87.44% |
| Late precision | 14.12% |
| Late recall | 27.03% |
| Late F1-score | 18.55% |
| Average Precision (PR-AUC) | 11.70% |

The model detected 276 of the 1,021 late orders in the test set.

However, it also generated 1,678 false-positive predictions.

This means that many orders predicted to be late were ultimately delivered on time or early.

**Business implication:**

Predictive analytics could eventually support proactive delivery monitoring, but the current model should be treated as an experimental decision-support tool rather than a reliable automated alerting system.

---

## 4. Strategic Business Recommendations

### Recommendation 1: Establish Proactive Delivery Monitoring

**Business challenge**

Late deliveries can negatively affect customer experience and create additional operational workload.

Monitoring delivery performance only after an order has been delivered limits the opportunity to intervene before a delay occurs.

**Recommended actions**

- Monitor orders throughout the fulfillment and delivery process.
- Develop operational dashboards to track delivery performance.
- Identify orders that require additional investigation.
- Monitor delivery performance by month, geographical region, and seller.
- Evaluate the feasibility of using predictive risk scores to prioritize manual review.

**Expected benefits**

- Earlier identification of potential delivery issues.
- Improved visibility into delivery operations.
- More informed operational decision-making.
- Opportunities to reduce avoidable delivery delays.

**Performance indicators**

- Late delivery rate.
- On-time delivery rate.
- Average delivery time.
- Number of orders requiring operational intervention.
- Percentage of flagged orders that ultimately become late.

**Priority:** High.

### Recommendation 2: Strengthen Seller Performance Management

**Business challenge**

Sellers contribute directly to marketplace operations through order preparation, product availability, and dispatch activities.

Evaluating sellers exclusively through order volume or revenue does not provide a complete picture of their operational performance.

**Recommended actions**

- Establish a seller performance monitoring framework.
- Evaluate delivery performance alongside order volume and revenue.
- Monitor seller review scores and customer satisfaction.
- Investigate sellers with recurring delivery issues.
- Identify high-performing sellers and examine practices that could be replicated.

**Expected benefits**

- Better visibility into seller operational performance.
- Improved identification of recurring delivery problems.
- More informed seller support and performance discussions.
- Better alignment between commercial performance and customer experience.

**Performance indicators**

- Seller late delivery rate.
- Seller on-time delivery rate.
- Average seller review score.
- Number of orders handled per seller.
- Revenue contribution per seller.

**Priority:** High.

### Recommendation 3: Improve Regional Logistics Monitoring

**Business challenge**

Delivery performance and revenue contribution can differ across geographical regions.

A single marketplace-wide delivery performance indicator may conceal regional differences.

**Recommended actions**

- Monitor delivery performance across Brazilian states.
- Compare regional late delivery rates and average delivery times.
- Investigate geographical areas with consistently weaker delivery performance.
- Examine customer and seller locations to identify potential logistics challenges.
- Evaluate whether additional logistics support or alternative fulfillment arrangements are justified.

**Expected benefits**

- Better understanding of geographical delivery differences.
- Improved identification of regional operational bottlenecks.
- More informed logistics planning.
- Better allocation of operational resources.

**Performance indicators**

- Late delivery rate by state.
- Average delivery time by state.
- Order volume by geographical region.
- Revenue contribution by state.
- On-time delivery rate by region.

**Priority:** High.

### Recommendation 4: Improve Estimated Delivery Accuracy

**Business challenge**

Estimated delivery dates establish customer expectations.

When estimates consistently differ from actual delivery times, customers may experience unexpected delays and reduced satisfaction.

**Recommended actions**

- Compare estimated delivery times with actual delivery times.
- Monitor estimation accuracy across geographical regions.
- Investigate recurring differences between estimated and actual delivery dates.
- Review delivery estimates for regions or operational situations with persistent delays.
- Consider more context-aware delivery estimates using historical delivery patterns.

**Expected benefits**

- More realistic delivery expectations.
- Improved customer experience.
- Better visibility into delivery estimation performance.
- Reduced gap between promised and actual delivery times.

**Performance indicators**

- Difference between actual and estimated delivery dates.
- Percentage of orders delivered after the estimated date.
- Average delivery estimation error.
- Estimation accuracy by geographical region.

**Priority:** High.

### Recommendation 5: Improve Customer Communication During Delivery Delays

**Business challenge**

Unexpected delivery delays can negatively affect the customer experience.

Even when a delay cannot be avoided, providing timely and accurate information can help customers understand the situation.

**Recommended actions**

- Provide timely delivery status updates.
- Notify customers when an expected delivery delay becomes apparent.
- Communicate revised delivery expectations where possible.
- Monitor review scores in relation to delivery performance.
- Investigate recurring delivery-related customer complaints.

**Expected benefits**

- Greater transparency during the delivery process.
- Better customer expectations management.
- Improved customer experience.
- Opportunities to reduce dissatisfaction caused by unexpected delays.

**Performance indicators**

- Average customer review score.
- Review score distribution.
- Customer satisfaction by delivery outcome.
- Delivery-related review trends.

**Priority:** Medium to High.

### Recommendation 6: Develop Predictive Analytics for Operational Decision Support

**Business challenge**

Historical reporting explains what has already happened, but it does not necessarily identify which future orders may require additional attention.

Predictive modeling offers an opportunity to investigate potential delivery risks earlier.

**Recommended actions**

- Continue improving the late-delivery prediction model.
- Investigate additional operational and logistics-related features.
- Evaluate model calibration and classification thresholds.
- Prioritize model evaluation using late-delivery precision, recall, F1-score, and Average Precision rather than accuracy alone.
- Test the model on more recent data before considering operational use.
- Assess the cost of false-positive alerts against the potential cost of missed late deliveries.

**Expected benefits**

- Better understanding of factors associated with late deliveries.
- Potential prioritization of operational monitoring.
- Improved use of historical data for decision support.
- A foundation for future predictive analytics applications.

**Performance indicators**

- Late-delivery precision.
- Late-delivery recall.
- Late-delivery F1-score.
- Average Precision (PR-AUC).
- False-positive rate.
- Percentage of actual late deliveries identified.

**Priority:** Medium.

**Important limitation**

The current XGBoost model achieved 14.12% late precision and 27.03% late recall on the test set.

Its false-positive volume is substantial. Consequently, it should not be used to automatically trigger costly interventions or customer notifications.

Further validation and improvement are required before operational deployment.

---

## 5. Implementation Roadmap

The recommendations can be organized into three stages.

### Stage 1: Establish Operational Visibility

**Focus:** Improve monitoring and identify existing performance issues.

Actions:

- Establish delivery performance monitoring.
- Create seller performance indicators.
- Monitor regional delivery performance.
- Review delivery estimation accuracy.

### Stage 2: Improve Operational Processes

**Focus:** Address recurring problems identified through monitoring.

Actions:

- Investigate sellers with recurring delivery issues.
- Examine geographical delivery bottlenecks.
- Review delivery estimation practices.
- Improve communication with customers experiencing delays.

### Stage 3: Introduce Predictive Decision Support

**Focus:** Explore the use of predictive analytics in operational processes.

Actions:

- Improve and validate the late-delivery prediction model.
- Evaluate alert thresholds based on operational costs.
- Test predictions on more recent data.
- Consider integrating validated risk scores into operational monitoring.

The implementation order should be adjusted according to operational resources, business priorities, and the results of further investigation.

---

## 6. Recommended Performance Monitoring Framework

The following indicators can help evaluate whether the proposed actions lead to improvements.

| Business Area | KPI | Purpose |
|---|---|---|
| Delivery | Late delivery rate | Monitor delivery delays |
| Delivery | On-time delivery rate | Measure delivery reliability |
| Delivery | Average delivery time | Monitor delivery duration |
| Sellers | Seller late delivery rate | Identify operational issues |
| Sellers | Average seller review score | Monitor customer satisfaction |
| Geography | Late delivery rate by state | Identify regional differences |
| Geography | Revenue by state | Monitor geographical business contribution |
| Estimation | Estimated versus actual delivery difference | Evaluate estimate accuracy |
| Customer Experience | Average review score | Monitor customer satisfaction |
| Predictive Analytics | Late delivery recall | Measure detected late orders |
| Predictive Analytics | Late delivery precision | Measure the reliability of positive predictions |

These KPIs should be monitored over time to identify trends and assess the impact of any operational changes.

---

## 7. Limitations and Considerations

The recommendations are based on historical data and should be interpreted within the limitations of the analysis.

1. **Historical dataset:** The dataset covers marketplace activity from 2016 to 2018 and may not represent current operational conditions.

2. **Limited operational information:** The available data does not fully explain the causes of delivery delays, such as warehouse capacity, transportation disruptions, or specific carrier issues.

3. **Correlation versus causation:** Relationships between delivery performance, seller activity, and customer satisfaction do not independently establish causal relationships.

4. **Predictive model limitations:** The selected XGBoost model has limited late-delivery precision and recall and is not ready for automated operational deployment.

5. **Financial limitations:** The dataset does not provide sufficient cost and profit information to quantify the financial impact of the proposed recommendations.

6. **Implementation validation:** The expected benefits are potential outcomes. They must be measured after implementation rather than assumed.

---

## 8. Conclusion

The analysis of the Olist marketplace demonstrates how combining data analytics, business intelligence, and predictive modeling can provide a broader understanding of e-commerce operations.

The main opportunities for improvement concern delivery performance, seller monitoring, geographical logistics, delivery estimation, and customer communication.

The proposed recommendations translate the analytical findings into potential business actions, while the performance monitoring framework provides a basis for evaluating their effectiveness.

The late-delivery prediction model also demonstrates the potential of machine learning to complement historical reporting. However, its current performance highlights the importance of proper validation and realistic expectations before introducing predictive systems into operational decision-making.

Ultimately, the objective is not simply to analyze historical marketplace data, but to use the resulting insights to support better operational decisions and improve the overall customer experience.
