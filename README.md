# 🚲 BikeStore End-to-End Data Warehouse Project

## 📌 Project Overview

This project demonstrates a complete end-to-end Data Warehouse solution built for a Bike Store business using SQL Server, SSIS, and Power BI.

The project transforms raw OLTP transactional data into a structured analytical Data Warehouse to support business intelligence, reporting, and decision-making.

## Key Features
- End-to-End ETL Pipeline
- Galaxy Schema Design
- SCD Type 2 Implementation
- Incremental Loading
- SQL Server Agent Automation
- Interactive Power BI Dashboard
- Fact & Dimension Modeling

---

# 🏗️ Architecture & Data Modeling

## 🔹 OLTP Source System

The source system is a Bike Store transactional database containing sales, customers, products, stores, inventory, and staff operations.

<p align="center">
  <img src="Images/Screenshot 2026-05-10 180857.png" width="750" alt="OLTP Model">
</p>

---

## 🔹 Galaxy Schema Design

The Data Warehouse was designed using a Galaxy Schema architecture with multiple fact tables sharing conformed dimensions.

### Fact Tables
- Fact_Sales
- Fact_Orders
- Fact_Inventory

### Dimension Tables
- Dim_Date
- Dim_Customer
- Dim_Product
- Dim_Store
- Dim_Staff
- Dim_Order_Status

### Design Concepts Applied
- Conformed Dimensions
- Surrogate Keys
- Degenerate Dimensions
- Junk Dimension
- Slowly Changing Dimensions (SCD Type 2)
- Transactional & Snapshot Fact Tables

<p align="center">
  <img src="Images/Screenshot 2026-05-10 192523.png" width="850" alt="Galaxy Schema">
</p>

---

# ⚙️ ETL Pipeline (SSIS)

The ETL pipeline was implemented using SQL Server Integration Services (SSIS) to move data from the OLTP source system into the Data Warehouse.

## ETL Layers
1. OLTP Source
2. Staging Area (STG)
3. Data Warehouse (DWH)

---

## 🔄 Control Flow — Source to Staging

This package extracts raw transactional data from the OLTP database and loads it into the staging layer.

<p align="center">
  <img src="Images/Screenshot 2026-05-10 183008.png" width="900" alt="Source To STG Flow">
</p>

---

## 🔄 Control Flow — Staging to Data Warehouse

This package transforms and loads cleansed data from the staging layer into dimension and fact tables.

<p align="center">
  <img src="Images/Screenshot 2026-05-10 183116.png" width="900" alt="STG To DWH Flow">
</p>

---

# 🔍 SSIS Data Flow Tasks

## Fact Sales Flow

Implemented lookup chains to resolve surrogate keys and prevent duplicate inserts while loading transactional sales data.

<p align="center">
  <img src="Images/Screenshot 2026-05-10 183419.png" width="900" alt="Fact Sales Flow">
</p>

---

## Fact Orders Flow

Aggregated order-level metrics including total revenue and total items per order.

<p align="center">
  <img src="Images/Screenshot 2026-05-10 183543.png" width="900" alt="Fact Orders Flow">
</p>

---

## Fact Inventory Flow

Implemented periodic snapshot loading for inventory tracking across stores and products.

<p align="center">
  <img src="Images/Screenshot 2026-05-10 183600.png" width="900" alt="Fact Inventory Flow">
</p>

---

# 📊 Power BI Dashboard

Built an interactive Power BI dashboard on top of the Data Warehouse to analyze:

- Sales Performance
- Revenue Trends
- Inventory Distribution
- Customer Behavior
- Product Categories
- Staff Performance

## Dashboard KPIs
- Total Revenue: $7.69M
- Total Quantity Sold: 14K
- Top Sales Staff: Marcelene Boyer ($2.62M)

<p align="center">
  <img src="Images/Screenshot 2026-05-10 192438.png" width="950" alt="Power BI Dashboard">
</p>

---

# ⏰ Deployment & Automation

The ETL solution was deployed to SSISDB and automated using SQL Server Agent.

## Automation Features
- Daily ETL Scheduling
- Automated Package Execution
- SSIS Catalog Deployment
- Execution Monitoring & Logging

---

# 🛠️ Technologies Used

- SQL Server
- SSIS (SQL Server Integration Services)
- SSMS
- Power BI
- T-SQL
- ETL
- Data Warehousing
- Dimensional Modeling

---

# 📂 Repository Structure

```bash
BikeStore-DataWarehouse-ETL
│
├── SQL/
├── SSIS/
├── PowerBI/
├── Documentation/
├── Images/
└── README.md
```

---

# 🚀 Key Skills Demonstrated

- ETL Development
- Data Warehousing
- SSIS
- SQL Development
- Data Modeling
- SCD Type 2
- Star & Galaxy Schema
- Business Intelligence
- Power BI Reporting
- SQL Server Agent Automation
