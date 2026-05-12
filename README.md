# 🚲 Bike Store End-to-End BI & Data Warehouse Project

This project transforms raw transactional data from a Bike Store OLTP system into a structured Data Warehouse (DWH) designed for advanced business analytics. 

---

## 🏗️ 1. Project Architecture

### Source System (OLTP)
[cite_start]The source consists of 8 tables capturing sales, inventory, and operations[cite: 13].
![Source System Model](Images/Screenshot%202026-05-10%20183419.png)

### Data Warehouse Design (Galaxy Schema)
[cite_start]I designed a **Galaxy Schema** consisting of **3 Fact Tables** sharing conformed dimensions to provide cross-functional insights[cite: 31, 34]:
- [cite_start]**Fact_Sales:** Transactional grain (individual items)[cite: 23, 25].
- [cite_start]**Fact_Orders:** Order-level summary[cite: 23].
- [cite_start]**Fact_Inventory:** Periodic snapshot of stock levels[cite: 23, 25].

![Galaxy Schema Model](Images/Screenshot%202026-05-10%20183543.png)

---

## 🛠️ 2. ETL Framework (SSIS)

[cite_start]The ETL pipeline was developed using **SQL Server Integration Services (SSIS)** to manage two main stages[cite: 41]:
1. [cite_start]**Source to STG:** Raw extraction into a staging layer[cite: 42].
2. [cite_start]**STG to DWH:** Transformation and loading with **SCD Type 2** implementation for `Dim_Staff` and `Dim_Customer` to maintain historical records[cite: 43, 87, 102].

![ETL Control Flow](Images/Screenshot%202026-05-10%20183600.png)
[cite_start]*Automated ETL execution flows built for high reliability[cite: 195, 210].*

---

## 📈 3. Data Insights & Visualization

[cite_start]Leveraging the DWH, I built an interactive **Power BI Dashboard** to monitor performance[cite: 212]:
- [cite_start]**Key Metrics:** $7.69M Total Sales, 14K Units Sold[cite: 215, 216].
- [cite_start]**Insights:** Identified **Trek Slash 8** as the top revenue generator ($555,558)[cite: 148].
- [cite_start]**Staff Performance:** Ranked **Marcelene Boyer** as the top seller with $2.6M in revenue[cite: 157].

![Power BI Dashboard](Images/Screenshot%202026-05-10%20192523.png)

---

## ⚙️ 4. Automation & Maintenance
- [cite_start]**Scheduled Jobs:** Configured a **SQL Server Agent Job** named `Run_ETL_Packages` to refresh the data automatically every day at midnight[cite: 195, 198, 204].
- [cite_start]**Referential Integrity:** Enforced via foreign key constraints between all Fact and Dimension tables[cite: 39].

---

## 🚀 How to Explore
1. [cite_start]**SQL Scripts:** Check `/SQL` for DDL, DML, and Analytical Queries[cite: 143].
2. [cite_start]**ETL Packages:** Explore `/SSIS` for the `.dtsx` package logic[cite: 41].
3. [cite_start]**Visualization:** Open the `.pbix` file in `/Power BI`[cite: 212].
