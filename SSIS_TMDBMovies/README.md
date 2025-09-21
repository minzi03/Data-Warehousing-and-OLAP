## 🔄 ETL Process (SSIS)

The **SSIS project (`SSIS_TMDBMovies`)** manages the **Extract – Transform – Load** pipeline:

* Extract raw data from CSV/Excel sources
* Transform the data (cleaning, formatting, joining tables)
* Load into the **star schema warehouse**

**Star Schema Dimensions:**

* Dim Movie
* Dim Genre
* Dim Company
* Dim Country
* Dim Language
* Dim Date
* Dim Runtime
* Dim Adult

**Fact Table:**

* FactMovies (measures: revenue, budget, popularity, rating, runtime, …)

### 📷 Screenshots

| Overview                                 | Pipeline                                                  |
| ---------------------------------------- | --------------------------------------------------------- |
| ![SSIS Overview](Assets/SSIS/SSIS_1.png) | ![SSIS Main Pipeline](Assets/SSIS/SSIS_pipeline_main.png) |

| Data Flow 1                                        | Data Flow 2                                        | Control Flow                                 |
| -------------------------------------------------- | -------------------------------------------------- | -------------------------------------------- |
| ![SSIS Pipeline 1](Assets/SSIS/SSIS_pipeline1.png) | ![SSIS Pipeline 2](Assets/SSIS/SSIS_pipeline2.png) | ![SSIS Control Flow](Assets/SSIS/SSIS_4.png) |
