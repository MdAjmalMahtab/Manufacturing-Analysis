# Manufacturing Analysis

## Table of Contents
1. [Project Overview](#project-overview)
2. [Data Sources](#data-sources)
3. [Tools](#tools)
4. [Data Cleaning/Preparation](#data-cleaningpreparation)
5. [KPIs (Key Performance Indicators)](#kpis-key-performance-indicators)
6. [Exploratory Data Analysis](#exploratory-data-analysis)
7. [Data Analysis](#data-analysis)
8. [Results/Findings](#resultsfindings)
9. [Recommendations](#recommendations)
10. [Limitations](#limitations)
11. [References](#references)

## Project Overview
The main objective of this project is to reduce wastage quantity and gain insights for lean manufacturing. This project, conducted as part of my internship, aims to analyze key performance indicators (KPIs) related to production and rejection, identify trends, uncover root causes of rejections, and suggest areas for improvement to achieve lean manufacturing goals.

## Data Sources
The primary dataset used for this analysis contains detailed information about the manufacturing process, including quantities produced, rejected, processed, and wastage, as well as employee and machine-specific data.

## Tools
- **Excel:** Data Cleaning and Preparation
- **MYSQL:** Data Analysis
- **PowerBI / Tableau:** Creating Reports and Dashboards

## Data Cleaning/Preparation
In the initial data preparation phase, we performed the following tasks:
- Data loading and inspection.
- Handling missing values and outiers.
- Data cleaning and formatting.

## KPIs (Key Performance Indicators)
- Manufacture Qty
- Rejected Qty
- Processed Qty
- Wastage Qty
- Employee Wise Rejected Qty
- Machine Wise Rejected Qty
- Production Comparison Trend
- Manufacture Vs Rejected
- Department Wise Manufacture Vs Rejected
- Employee Wise Rejected Qty

![Dashboard](https://github.com/user-attachments/assets/dc72e20f-9585-4446-9c87-321e4745ba2a)

## Exploratory Data Analysis
EDA involved exploring the manufacturing data to answer key questions, such as:
- What is the overall trend in manufactured and rejected quantities?
- Which employees and machines are associated with the highest rejection rates?
- What are the key areas (departments and processes) with the highest rejection rates?

## Data Analysis
We worked with the following SQL query to extract relevant data:

```sql
# 1.Manufactured Qty
select sum(`Manufactured Qty`) as Total_Manufactured_Qty from manufacturing_data;

# 2.Rejected Qty
select sum(`Rejected Qty`)as Total_Rejected_Qty from manufacturing_data;

# 3.Processed quantity
select sum(`Processed Qty`)as Total_Processed_Qty from manufacturing_data;

# 4.Wastage percentage
select concat(Round((sum(`Rejected Qty`)/sum(`Processed Qty`))*100,2),"%") as `Wastage_%` from manufacturing_data;

# 5.Emp wise Rejected Qty
select `Emp Name`,sum(`Rejected Qty`) as Emp_Rejected_Qty 
from manufacturing_data group by 1 having sum(`Rejected Qty`)!=0 order by 2 desc;

# 6. Machine wise Rejection Qty
select `Machine Name`,sum(`Rejected Qty`) as Machine_Rejected_Qty 
from manufacturing_data group by 1 having sum(`Rejected Qty`)!=0 order by 2 desc;

# 7. Production Comparison trend
select distinct `Fiscal Date`,Total_Produced_Qty, Total, 
concat(Round((Total_Produced_Qty/Total)*100,2),"%") as `%_of_Total` from
(select `Fiscal Date`, sum(`Produced Qty`) over () as Total,
sum(`Produced Qty`) over (partition by `Fiscal Date`) as Total_Produced_Qty
from manufacturing_data) as X
order by `%_of_Total` desc;

# 8. Manufactured Vs Rejected Qty
select sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Rejected Qty`)as Total_Rejected_Qty from manufacturing_data;

# 9.Dept wise manuf qty vs Rej Qty
select `Department Name`,sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Rejected Qty`)as Total_Rejected_Qty 
from manufacturing_data group by 1 order by 3 desc;

# 10. Delivery Status Vs Manufactured, Rejected & Processed Qty
select `Delivery Period`,sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Processed Qty`)as Total_Processed_Qty ,
sum(`Rejected Qty`)as Total_Rejected_Qty from manufacturing_data
group by 1 order by 2 desc;

# 11. Buyer Vs Manufactured and Rejected Qty
select Buyer, sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Rejected Qty`)as Total_Rejected_Qty from manufacturing_data
group by 1 order by 3 desc;

# 12. Operation name Vs Manufactured, Rejected & Processed Qty
select `Operation Name`,sum(`Manufactured Qty`) as Total_Manufactured_Qty,
sum(`Processed Qty`)as Total_Processed_Qty ,
sum(`Rejected Qty`)as Total_Rejected_Qty
from manufacturing_data group by 1 order by 4 desc;
```

## Results/Findings
The analysis results are summarized as follows:

- Manufactured Quantity: 8,67,66,796 units
- Rejected Quantity: 5,24,729 units
- Processed Quantity: 8,62,42,067 units
- Wastage Quantity: 0.61%
  
## Key Insights:
- High Rejection by Employee: Products manufactured by Shruti Singh have the highest rejection rate (520,867 units).
- High Rejection by Machines: Machines C007 (33,660), C022 (26,480), and C037 (23,480) have the highest rejection rates.
- Departmental Rejections:
  - More products are rejected in the CUT AND FOLD sector.
  - The Woven Labels Department has a high rejection rate.

## Recommendations
Based on the analysis, we recommend the following actions:

- Employee Performance Review: Investigate why products manufactured by Shruti Singh are getting rejected and provide necessary training or support.
- Machine Maintenance and Calibration: Focus on the top 10 machines with the highest rejection rates (C007, C0039, C022, C023, C037, C024, C008, C020, C018, C028) to identify and solve issues.
- Departmental Improvements: Pay special attention to the Woven Labels Department and the CUT AND FOLD sector to reduce the rejected quantity.
  
## Limitations
The analysis is based on a dataset from a single month, which may not fully represent seasonal trends or variations in rejection rates over a longer period.

## References
- [Download Files Here](https://1drv.ms/f/c/6993f333d4c84e65/EsLtgmm8tU9Llg10_9-pVBEBf44rfxtgucw1u6HGSkrYcw?e=m9Toaz)
- [Tableau Dashboard](https://public.tableau.com/app/profile/md.ajmal.mahtab/viz/Manufacturingtableau_17323785595210/Dashboard1?publish=yes)
