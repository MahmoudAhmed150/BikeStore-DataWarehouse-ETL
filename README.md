# 🚲 Bike Store Data Warehouse: End-to-End BI Solution

This project demonstrates a full Business Intelligence lifecycle, transforming raw OLTP data into an optimized Data Warehouse (DWH) for strategic decision-making.

---

## 🏗️ 1. Architecture & Design

### Source System (OLTP)
The source is a relational database representing a Bike Store with 8 interrelated tables.
![Physical Model](Screenshots/image2.jpeg)

### Data Warehouse Design (Galaxy Schema)
I implemented a **Galaxy Schema** to handle multiple business processes (Sales, Inventory). It consists of:
- **3 Fact Tables:** Sales, Orders, and Inventory.
- **6 Dimensions:** Including Time, Staff, Customer, and Product dimensions.
![DWH Model](Screenshots/image10.jpeg)

---

## 🛠️ 2. ETL Process (SSIS)

The ETL (Extract, Transform, Load) process was built using **SQL Server Integration Services (SSIS)**.

### Data Flow Strategy:
1. **Staging Area:** Data is extracted from OLTP to a Staging (STG) database to minimize load on production.
2. **SCD Type 2:** Implemented **Slowly Changing Dimensions (Type 2)** for `Dim_Staff` and `Dim_Customer` to track historical changes (e.g., staff moving between stores).
3. **Surrogate Keys:** Used for all dimensions to ensure data integrity.

![SSIS Package](Screenshots/image15.jpeg)
*Example of the Control Flow and Data Flow for loading dimensions.*

---

## 📈 3. Data Analysis & Insights (Power BI)

The final layer is an interactive Power BI Dashboard that provides key business metrics:
- **Total Revenue:** $7.69M
- **Units Sold:** 14K
- **Top Sales Staff:** Marcelene Boyer ($2.62M).

![Power BI Dashboard](Screenshots/image28.jpeg)

### Key Analytical Queries:
- Analysis of sales performance by Category (Cruisers Bicycles being #1).
- Monthly trends identifying January as the peak revenue month.

---

## ⚙️ 4. Automation & Deployment
- **SQL Server Agent:** Scheduled jobs to automate the ETL pipeline daily.
- **SQL Scripts:** All DDL and DML scripts are provided in the `/SQL` directory.

---

## 🚀 How to Run
1. Clone the repository.
2. Run the SQL scripts in `/SQL` to set up the DWH.
3. Open the SSIS packages in Visual Studio to execute the ETL.
4. Open the `.pbix` file in Power BI Desktop to view the dashboard.
