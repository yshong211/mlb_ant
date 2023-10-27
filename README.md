# mlb_ant: Major League Baseball Pitch Type Prediction

[**mlb_ant**](https://github.com/yshong211/mlb_ant) is a Data Science Project exploring various machine learning methods that will predict the major leaguers' pitch type, based on the game-situational data. This project draws inspiration from an intriguing analysis shared [here](https://towardsdatascience.com/predicting-mlb-pitch-probability-based-on-the-game-situation-1afc5a01cf3), utilizing comprehensive MLB game data available on the [Kaggle Website](https://www.kaggle.com/pschale/mlb-pitch-data-20152018). A substantial part of our methodology is influenced by this insightful [Google Colaboratory notebook](https://colab.research.google.com/drive/1VaHWXq2yYuH-S-6WL_WD8VFSugcgoiUz#scrollTo=eNI5nrnYrxPV).

## Project Overview

Initially, our endeavor was to reproduce the existing results, achieving a 51% prediction accuracy across 11 distinct pitch types using the XGBoostClassifier. Our primary dataset was the pitch data (`pitches.csv`), but our vision extended beyond mere replication. We hypothesized that integrating more situational variables—like the game's stadium, weather conditions, and wind directions—could refine our model's accuracy.

Here's how we enhanced our approach:

1. **Data Integration:** We amalgamated data from multiple sources, including `pitches.csv`, `atbats.csv`, `games.csv`, and `player_names.csv`, focusing on enriching the features used in our models.
2. **Feature Expansion:** Our models now consider additional factors such as temperature, wind conditions, and stadium characteristics. We recognized the unique pitching styles of individuals and incorporated data reflecting the proportion of pitch types thrown by each pitcher.
3. **Data Segmentation:** We homed in on the 2018 season for training and testing our models, ensuring contemporary relevance and uniformity in the data.
4. **Pitch Categorization:** For simplification and practicality, we combined certain pitch types, treating two-seam and four-seam fastballs as one category, and similarly grouping knuckleballs and knuckle-curves.

## Methodology and Insights

We experimented with several machine learning models, each offering different advantages. Consistency in testing was maintained by setting `random_state = 77777`. Below, we outline our experience and findings with each method:

### XGBoost

Remarkably efficient, XGBoost provided the quickest results and the best accuracy at 57%.

```python
xgb.XGBClassifier(eval_metric='mlogloss')
```

Despite extensive parameter tuning through Scikit-learn's GridSearchCV(), the default settings of XGBoost performed optimally, indicating a robustness in the algorithm.

### KNN(K-Nearest Neighbors)

The KNN model, while simpler, was significantly slower, achieving 56% accuracy with K = 49.

```python
KNeighborsClassifier(n_neighbors=11)
```

### Random Forest

Our Random Forest model was an improvement over KNN in terms of speed but marginally trailed in accuracy at 55%.

```python
RandomForestClassifier((n_estimators = 2000, max_depth = 10, min_samples_leaf = 12, min_samples_split = 16))
```

### Support Vector Machine

Due to its computational intensity, especially with large datasets, we couldn't feasibly implement the SVM for our full dataset.

```python
`svm.SVC(kernel = 'linear')`
```

SVM’s complexity, potentially reaching up to O(X * n^3), made it unsuitable for our extensive dataset.

## Conclusion

This project was an ambitious journey through data manipulation and advanced analytical modeling. While the integration of new features didn't dramatically enhance performance, likely due to overfitting in such a vast dataset, the experience underscored the intricacies of working with large-scale data and provided invaluable insights.

Moving forward, we aim to explore more dimensions, potentially incorporating player psychology and on-the-spot game decisions, to understand their impact on pitch selection. This exploration into real-world data has laid a solid foundation for future investigations and applications in sports analytics.
