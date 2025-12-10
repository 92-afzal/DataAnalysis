# Superstore Sales Insights Dashboard

## 📌 Project Overview
This project analyzes four years of Superstore sales data to uncover trends in revenue, profitability, regional performance, and customer behavior. The goal is to demonstrate end-to-end data analytics skills including data cleaning, SQL transformation, Python processing, and dashboard creation in Power BI.

## 🛠 Tools & Technologies
- **SQL (PostgreSQL)** – Data cleaning, validation, aggregation  
- **Python (Pandas)** – Data wrangling and preprocessing  
- **Power BI** – Dashboard creation, modeling, DAX measures  
- **GitHub** – Version control and project documentation  

## 📂 Dataset
Source: *Superstore Sales Dataset* (Kaggle)  
Tables used:
- `superstore_orders`
- `superstore_returns`
- `superstore_people`
- Custom `DateTable` created in Power BI

## ✔ Data Cleaning Steps
### Using SQL:
- Removed unintended duplicates  
- Checked for missing values  
- Converted order and ship dates to correct formats  
- Ensured numerical fields were consistent  
- Standardized categorical variables  

### Using Python:
- Further processed text fields  
- Validated numerical ranges  
- Exported a clean dataset to be used in Power BI  

## ✔ Data Modeling
A star schema was built inside Power BI:
- **Fact Table:** superstore_orders  
- **Dimensions:** People, Returns, DateTable, Category, Region, Customer  

Relationships:
- DateTable[Date] → Orders[order_date]  
- People → Orders(customer_id)  
- Returns → Orders(order_id)

## 🔢 Key DAX Measures
```DAX
Total Sales = SUM(superstore_orders[sales])
Total Profit = SUM(superstore_orders[profit])
Total Orders = DISTINCTCOUNT(superstore_orders[order_id])
Profit Margin = DIVIDE([Total Profit], [Total Sales])

Sales YoY = 
CALCULATE([Total Sales], SAMEPERIODLASTYEAR(DateTable[Date]))

Sales YoY % = 
DIVIDE([Total Sales] - [Sales YoY], [Sales YoY])

## Dashboard Images
images/Exective_summary.png
