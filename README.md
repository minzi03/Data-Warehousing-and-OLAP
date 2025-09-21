# 🎥 Data Warehousing and OLAP Project

## 📌 Overview

This project demonstrates the **end-to-end development of a Data Warehouse and OLAP solution** using the **TMDB Movies dataset**.
It covers the full data pipeline:

* **Data Modeling with SSMS (SQL Server Management Studio)**
* **ETL with SSIS (SQL Server Integration Services)**
* **OLAP Cubes with SSAS (SQL Server Analysis Services)**
* **Analytical Queries with MDX**
* **Reports with SSRS, Excel, and Power BI**
* **Data Mining** extension: predicting movie revenues using machine learning

This project was developed as part of the **Data Warehousing & OLAP (IS217)** course.

---

## 📂 Repository Structure

```
minzi03-data-warehousing-and-olap/
├── Data/                # Raw datasets (CSV, TXT, Excel)
├── SSIS_TMDBMovies/     # SSIS ETL Project
├── SSAS_TMDBMovies/     # SSAS Cube Project
├── SSRS_TMDBMovies/     # SSRS Reports
├── Document/            # Reports, requirements, slides
├── class/               # Supporting class materials
├── Excel_TMDBMovies.xlsx
├── SQLQuery.sql         # SQL scripts
├── MDXQuery.mdx         # Sample MDX queries
├── Assets/              # Project screenshots
└── README.md
```

---

## 🗄️ SQL Server (SSMS)

The **SQL Server Management Studio (SSMS)** was used to design and manage the **Data Warehouse schema**.

* **Database Architecture**: Star schema design
* **Entity-Relationship Diagram (ERD)**: Logical view of dimensions and fact table
* **Fact Table**: Stores measures such as revenue, budget, ratings, and popularity

### 📷 Screenshots

| Architecture                                            | ERD Diagram                                   | Fact Table                                          |
| ------------------------------------------------------- | --------------------------------------------- | --------------------------------------------------- |
| ![SSMS Architecture](../Assets/SSMS/SSMS_architecture.png) | ![SSMS Diagram](../Assets/SSMS/SSMS_diagram.png) | ![SSMS Fact Table](../Assets/SSMS/SSMS_Fact_table.png) |

---

## 🔄 ETL Process (SSIS)

The **SSIS project (`SSIS_TMDBMovies`)** handles the ETL pipeline:

* Extract raw data from CSV/Excel
* Transform the data (cleaning, formatting, joining tables)
* Load into the **star schema warehouse**

### 📷 Screenshots

| Overview                                 | Main Pipeline                                             |
| ---------------------------------------- | --------------------------------------------------------- |
| ![SSIS Overview](../Assets/SSIS/SSIS_1.png) | ![SSIS Main Pipeline](../Assets/SSIS/SSIS_pipeline_main.png) |

| Data Flow 1                                        | Data Flow 2                                        | Control Flow                                 |
| -------------------------------------------------- | -------------------------------------------------- | -------------------------------------------- |
| ![SSIS Pipeline 1](../Assets/SSIS/SSIS_pipeline1.png) | ![SSIS Pipeline 2](../Assets/SSIS/SSIS_pipeline2.png) | ![SSIS Control Flow](../Assets/SSIS/SSIS_4.png) |

---

## 📦 OLAP Cubes (SSAS)

The **SSAS project (`SSAS_TMDBMovies`)** builds OLAP cubes for multidimensional analysis.

* **Cube**: `TMDB Movies.cube`
* **Dimensions**: Movie, Genre, Company, Country, Language, Date, Runtime, Adult
* **Measures**: Revenue, Budget, Vote Average, Popularity, Runtime

### 📷 Screenshots

| Architecture                                            | Diagram                                       | Dimensions                                          |
| ------------------------------------------------------- | --------------------------------------------- | --------------------------------------------------- |
| ![SSAS Architecture](../Assets/SSAS/SSAS_architecture.png) | ![SSAS Diagram](../Assets/SSAS/SSAS_diagram.png) | ![SSAS Dimensions](../Assets/SSAS/SSAS_dimensions.png) |

| Date Hierarchy                                              | Overview                                        | Query & Calculations                                                |
| ----------------------------------------------------------- | ----------------------------------------------- | ------------------------------------------------------------------- |
| ![SSAS Date Hierarchy](../Assets/SSAS/SSAS_date_hierarchy.png) | ![SSAS Overview](../Assets/SSAS/SSAS_overview.png) | ![SSAS Query Calculations](../Assets/SSAS/SSAS_query_calculations.png) |

---

## 📜 MDX Queries

File: **`MDXQuery.mdx`** contains sample OLAP queries, such as:

* Top 5 genres by average revenue
* Yearly budget vs. revenue trends
* Ratings comparison between US vs. Non-US productions

---

## 📑 Reporting with SSRS

The **SSRS project (`SSRS_TMDBMovies`)** delivers interactive reports for decision-making.

* Revenue distribution by **genre** and **decade**
* Top production studios
* Popularity and ratings

### 📷 Screenshots

| Report 1                                       | Report 2                                       | Report 3                                       |
| ---------------------------------------------- | ---------------------------------------------- | ---------------------------------------------- |
| ![SSRS Report 1](../Assets/SSRS/SSRS_report1.png) | ![SSRS Report 2](../Assets/SSRS/SSRS_report2.png) | ![SSRS Report 3](../Assets/SSRS/SSRS_report3.png) |

---

## 📊 Reports & Dashboards

In addition to SSRS, the project includes **Excel** and **Power BI** dashboards for business analysis.

* **Excel Report**: Pivot-based analysis for quick insights
* **Power BI Dashboard**: Interactive visuals for revenue, budget, ratings, and trends

### 📷 Screenshots

| Excel Report                                    | Power BI Dashboard                                   |
| ----------------------------------------------- | ---------------------------------------------------- |
| ![Excel Report](../Assets/Report/Excel_report.png) | ![Power BI Report](../Assets/Report/PowerBI_report.png) |

---

## 🤖 Data Mining: Movie Revenue Prediction

As an extension, machine learning was applied to **predict movie revenues**.

* **Dataset**: TMDB Movies dataset (\~15K films, 22 features → 57 engineered features)
* **Models Tested**: Linear Regression, Ridge, SVR, Decision Tree, Random Forest, Gradient Boosting, XGBoost, LightGBM, AdaBoost, k-NN
* **Best Model**: **Support Vector Regression (SVR)**

### Results

| Model             | MAPE | RMSE | R²   | Accuracy (%) |
| ----------------- | ---- | ---- | ---- | ------------ |
| **SVR**           | 5.86 | 1.21 | 0.92 | **94.14**    |
| **LightGBM**      | 5.90 | 1.20 | 0.92 | **94.10**    |
| XGBoost           | 6.11 | 1.23 | 0.92 | 93.89        |
| Gradient Boosting | 6.27 | 1.27 | 0.91 | 93.73        |
| Random Forest     | 6.84 | 1.38 | 0.89 | 93.16        |
| Linear Regression | 7.30 | 1.45 | 0.88 | 92.70        |

* **SVR achieved 94.14% accuracy (R² = 0.92)**
* **Top Features**: Budget, Vote Count, Vote Average, Production Studios, Genre Ranking

---

## 🛠️ Tools & Technologies

* **SQL Server**: Database & schema
* **SSMS**: Data modeling
* **SSIS**: ETL pipelines
* **SSAS**: OLAP cubes & MDX queries
* **SSRS**: Reporting
* **Excel / Power BI**: Dashboards
* **Python (scikit-learn, XGBoost, LightGBM)**: Data Mining

---

## 🚀 How to Run

1. **SQL Scripts** → Run `SQLQuery.sql` to create schema.
2. **ETL** → Open `SSIS_TMDBMovies.sln` and execute ETL pipeline.
3. **OLAP** → Deploy `SSAS_TMDBMovies.sln` and process cubes.
4. **Reports** → Open `SSRS_TMDBMovies.sln` for reports.
5. **Dashboards** → Use `Excel_TMDBMovies.xlsx` or Power BI.
6. **Data Mining** → Run `movie-revenue-prediction.ipynb`.

---

## 📌 Key Outcomes

* Built a **complete Data Warehouse** with star schema
* Automated **ETL pipeline with SSIS**
* Created **OLAP cubes with SSAS** for multidimensional analysis
* Developed **reports and dashboards** with SSRS, Excel, and Power BI
* Extended with **Machine Learning (SVR model, 94% accuracy)**
