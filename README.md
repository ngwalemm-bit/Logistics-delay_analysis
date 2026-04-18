# Logistics Delay Analysis – Supply Chain Performance Study

## Objective
The goal of this project is to analyse shipment delays across transport modes, carriers, and routes to identify key inefficiencies and provide actionable insights.

## Dataset Description
The dataset consists of 4,000 shipment records and 25 products, including details on transport mode, carrier, delay days, and shipment routes.

## Tools Used
•	SQL (PostgreSQL)
•	Excel
•	Power BI

## Data Cleaning & Exploration Process

Initial exploration was conducted in Excel using pivot tables to quickly identify patterns in delays across transport modes, routes, and carriers.
This step helped form early hypotheses, which were later validated and expanded using SQL queries in PostgreSQL.

## Key Questions
•	Which transport mode has the highest delays?
•	Which routes contribute most to delays?
•	Which carriers are least efficient?
•	What are the main causes of delays?
•	Which products experience the most delays?

## Analysis & Insights 

### Transport Mode 
Sea freight shows the highest average delay, which is expected given the longer transit times compared to air and road.
However, road transport showing higher delays than air is notable, as road shipments are typically shorter and more predictable. This may indicate operational inefficiencies within road logistics that require further investigation

```sql
SELECT 
    transport_mode,
    COUNT(*) AS total_shipments,
    SUM(delay_days) AS total_delay_days,
    ROUND(AVG(delay_days), 2) AS avg_delay_days
FROM shipments
GROUP BY transport_mode
ORDER BY total_delay_days DESC;
```


### Top Delayed Routes
Analysis of delayed routes shows that countries such as the Netherlands, China, South Africa, and the USA are key contributors to delays.
The Netherlands stands out as having consistently high delays across both imports and exports, indicating systemic inefficiencies.
China and South Africa delays are more export-driven, while USA delays are more concentrated on imports.
External factors such as regulatory changes and trade policies may contribute to these patterns.

```sql
SELECT 
    route,
    COUNT(*) AS total_shipments,
    SUM(delay_days) AS total_delay_days,
    ROUND(AVG(delay_days), 2) AS avg_delay_days
FROM shipments
GROUP BY route
ORDER BY total_delay_days DESC
LIMIT 10;
```

### Carrier Performance
In sea freight, Maersk shows the highest average delays despite handling fewer shipments than MSC, which demonstrates stronger efficiency within MSC than Maersk.
This suggests potential operational inefficiencies within Maersk or differences in route allocation strategies. In road transport, DHL shows higher average delays despite handling fewer shipments than both Cargo Carriers and FedEx.
This is particularly concerning given that Cargo Carriers handles more complex shipments, indicating DHL may have process inefficiencies that require attention.

```sql
SELECT 
    carrier,
    COUNT(*) AS total_shipments,
    SUM(delay_days) AS total_delay_days,
    ROUND(AVG(delay_days), 2) AS avg_delay_days
FROM shipments
GROUP BY carrier
ORDER BY avg_delay_days DESC;
```


### Delay Reasons
Port congestion and weather conditions are the leading causes of delays, both of which are largely external and difficult to control.
However, delays caused by carrier issues, customs, and documentation highlight areas where internal processes and stakeholder coordination can be improved.
Improving staff training, documentation accuracy, and communication with carriers could help reduce these delays.

```sql
SELECT 
    delay_reason,
    COUNT(*) AS occurrences
FROM shipments
WHERE delay_reason IS NOT NULL
GROUP BY delay_reason
ORDER BY occurrences DESC;
```

### Products
Products such as chemicals and food show the highest delays, which is expected due to their classification as special cargo requiring additional handling, compliance, and inspections.
Clothing also shows elevated delays, likely due to customs requirements and documentation complexities.
Other product categories show relatively stable performance unless associated with non-standard cargo characteristics.

```sql
SELECT 
    p.product_category,
    COUNT(*) AS total_shipments,
    SUM(s.delay_days) AS total_delay_days,
    ROUND(AVG(s.delay_days), 2) AS avg_delay_days
FROM shipments s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.product_category
ORDER BY avg_delay_days DESC;
```

## Power BI Dashboard

The dashboard provides a visual summary of logistics performance, highlighting key delay drivers and operational bottlenecks.

### Dashboard Overview:

<img src="https://github.com/yourname/repo/blob/main/images/edal.png">

## Business Impact

Delays in shipments can lead to increased operational costs, reduced customer satisfaction, and potential loss of business.

Identifying inefficiencies across transport modes, carriers, and routes allows for targeted improvements that can enhance service delivery and profitability.

## Recommendations
•	Investigate and optimise road transport operations to identify and resolve inefficiencies.
•	Consider reallocating shipment volumes towards more efficient carriers to improve delivery performance.
•	Improve documentation and customs processes
•	Monitor high-risk routes like Netherlands & USA

## Dashboard Status
A Power BI dashboard will be added in the next phase of this project to visualize key findings across transport modes, carriers, routes, delay reasons, and product categories. The current project focuses on exploratory analysis and SQL-based insights.

## Conclusion
This analysis highlights key inefficiencies in logistics operations and provides a data-driven foundation for improving delivery performance. Ultimately, this project demonstrates how data analysis can be used to uncover operational inefficiencies and support data-driven decision-making in supply chain management.

 #### Key Takeaways
•	Sea freight dominates total delays
•	Road transport shows unexpected inefficiencies
•	Carrier performance varies significantly
•	External vs internal delay factors identified

## Limitations

•	The dataset is synthetic and may not fully capture real-world operational complexity.
•	Shipment volume distribution across carriers may influence total delay metrics, potentially biasing comparisons.
•	Some fields (e.g., delay reasons) may contain missing or generalized values, limiting deeper root-cause analysis.
•	The analysis does not account for seasonal trends or time-based patterns which may influence delay behaviour.



