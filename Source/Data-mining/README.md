# 🎬 Movie Revenue Prediction - Data Mining Project

## Introduction

This project focuses on analyzing and predicting box office revenues using machine learning and data analysis techniques. The main goal is to build a model that can accurately forecast a movie’s revenue based on relevant features.

## Project Background

The film industry has been rapidly growing, with blockbuster hits grossing hundreds of millions of dollars worldwide. However, alongside major successes, many movies still fail at the box office. Understanding the factors that drive box office revenue is crucial for producers and industry stakeholders.

## Dataset

* **Source**: TMDb (The Movie Database)
* **Initial Size**: 15,937 movies
* **Original Attributes**: 22 columns
* **Target Variable**: Revenue

### Key Features:

* **Basic Info**: Title, Overview, Release Date, Runtime
* **Ratings**: Vote Average, Vote Count, Popularity
* **Production**: Budget, Production Companies, Production Countries
* **Classification**: Genres, Original Language, Spoken Languages
* **Others**: Adult, Homepage, Status

## Workflow

### 1. Data Exploration and Preprocessing (EDA)

#### Data Cleaning:

* Removed movies with `revenue = 0` but already released
* Removed movies with `vote_average = 0` and `vote_count = 0`
* Handled unrealistic runtimes (> 300 mins or < 50 mins)
* Imputed missing budgets (< 10,000 USD) using **KNN Imputer**

#### Handling Missing Values:

* Homepage → created binary variable `has_homepage`
* Tagline → created binary variable `has_tagline`
* Genres, Production Companies, Countries → filled with `'None'`

### 2. Feature Engineering - Created 57 New Features

#### Time Features:

* **Decades**: 1960s, 1970s, …, 2010s
* **Release Day**: MondayRelease … SundayRelease
* **Seasons**: Winter, Spring, Summer, Fall

#### Language Features:

* `originally_english`: whether the original language is English
* `released_in_english`: whether it was released in English
* `num_languages`: number of spoken languages

#### Production Features:

* `usa_produced`: produced in the US
* `num_production_countries`: number of producing countries
* `topStudio`: top-ranked studios
* `numTopStudios`: number of top studios involved
* `studioRank`: ranking of the studio
* `num_studios`: total production companies

#### Genre Features:

* Binary encoding for 19 genres: Action, Adventure, Animation, Comedy, Crime, Documentary, Drama, Family, Fantasy, History, Horror, Music, Mystery, Romance, Science Fiction, TV Movie, Thriller, War, Western
* `genre_rank`: revenue-based genre ranking
* `num_genres`: number of genres

#### Other Features:

* `title_len`: title length
* `runtime_processed`: processed runtime
* `budget_processed`: processed budget
* `adult`: adult film flag
* `status`: movie status

### 3. Data Transformation

* Applied **log transformation (log1p)** to all numerical features
* Target variable: `log_revenue`

## Machine Learning Models

### Evaluated Algorithms:

1. Linear Regression
2. Ridge Regression
3. Support Vector Regression (SVR)
4. k-Nearest Neighbors (k-NN)
5. Decision Tree
6. Random Forest
7. Gradient Boosting
8. AdaBoost
9. XGBoost
10. LightGBM

### Optimization:

* **GridSearchCV** with 5-fold cross-validation
* Scoring metric: Negative Root Mean Squared Error
* Train/Test split: 80/20

## Results

### Model Performance Comparison

| Model             | MAPE  | RMSE | R²   | Accuracy (%) |
| ----------------- | ----- | ---- | ---- | ------------ |
| **SVR**           | 5.86  | 1.21 | 0.92 | **94.14**    |
| **LightGBM**      | 5.90  | 1.20 | 0.92 | **94.10**    |
| XGBoost           | 6.11  | 1.23 | 0.92 | 93.89        |
| Gradient Boosting | 6.27  | 1.27 | 0.91 | 93.73        |
| Random Forest     | 6.84  | 1.38 | 0.89 | 93.16        |
| Linear Regression | 7.30  | 1.45 | 0.88 | 92.70        |
| Ridge Regression  | 7.30  | 1.45 | 0.88 | 92.70        |
| AdaBoost          | 8.26  | 1.58 | 0.86 | 91.74        |
| Decision Tree     | 9.20  | 1.74 | 0.83 | 90.80        |
| k-NN              | 11.43 | 2.08 | 0.76 | 88.57        |

### Best Model: Support Vector Regression (SVR)

* **Accuracy**: 94.14%
* **MAPE**: 5.86%
* **RMSE**: 1.21 (log scale)
* **R² Score**: 0.92
* **Average Error**: \~30M USD

### Top 5 Most Important Features (from Random Forest):

1. **Budget**
2. **Vote Count**
3. **Vote Average**
4. **Production Studios**
5. **Genre Ranking**

## Conclusion

### Achievements:

* Successfully built a prediction model with **94.14% accuracy**
* Generated 57 new features from 22 original ones
* Compared the performance of **10 ML algorithms**
* Identified the most important revenue-driving factors

### Limitations:

* Average error of \~30M USD, which may be significant for low-grossing films
* Missing factors such as **marketing budget** and **star power**
* Dataset skewed by high-revenue blockbusters

### Future Work:

* Incorporate marketing budget and cast/crew star power
* Apply **deep learning and ensemble stacking** methods
* Analyze separately for **indie vs. blockbuster films**
* Include **social media sentiment & buzz** data
