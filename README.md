# mlb_ant: Major League Baseball Pitch Type Prediction

[**mlb_ant**](https://github.com/yshong211/mlb_ant) is a Data Science Project exploring various machine learning methods that will predict the major leaguers' pitch type, based on the game-situational data. The initial idea came from [here](https://towardsdatascience.com/predicting-mlb-pitch-probability-based-on-the-game-situation-1afc5a01cf3), with the MLB Data being available at [Kaggle Website](https://www.kaggle.com/pschale/mlb-pitch-data-20152018). Majority of the idea came from this [Google Colaboratory](https://colab.research.google.com/drive/1VaHWXq2yYuH-S-6WL_WD8VFSugcgoiUz#scrollTo=eNI5nrnYrxPV), which can also be redirected from the "here" above.

## Approach

The initial approach of this project was done by first attempting to replicate the result that was already available: getting 51% overall accuracy over 11 pitch types (using XGBoostClassifier). The features that were used for prediction were all directly related to pitches only (available at `pitches.csv`), but we were also hoping that we can add more features, such as in which stadium were the games played, how was the weather condition, as well as the direction of the wind. Therefore, we decided to include those.

We first merge all the information from `pitches.csv`, `atbats.csv`, `games.csv`, and `player_names.csv`. We train and test our model based on year 2018 data only. In addition to what were done to the codes from [Colab](https://colab.research.google.com/drive/1VaHWXq2yYuH-S-6WL_WD8VFSugcgoiUz#scrollTo=eNI5nrnYrxPV), we add the new feature that accounts for the temperature, wind, and the stadium. Moreover, we have decided to include the proportion of pitch types thrown by each individual pitcher, hoping that our machine learning model will pick up the fact that each individual pitcher throws different, certain types of pitches. Hence, we included the current weighing scheme for pitch type proportion by year as following: **2017 : 2018 = 1 : 4**. Also, for convenience, we combined the pitch types for two-seam fastball and four-seam fastball as one fastball, and knuckleball and knuckle-curve as one knuckleball.

So far, we have used the following machine learning algorithms:
* XGBoost
* KNN
* Random Forest
* Support Vector Machine

Note that for consistency, we have used the parameter `random_state = 77777`.

### XGBoost

XGBoost shows the fastest runtime, with the highest accuracy which is 57 percent

`xgb.XGBClassifier(eval_metric='mlogloss')`

### KNN

`KNeighborsClassifier(n_neighbors=11)`

KNN takes much longer runtime than XGBoost. Had the accuracy of 56 percent

### Random Forest

`RandomForestClassifier((n_estimators = 2000, max_depth = 10,
 min_samples_leaf = 12,
 min_samples_split = 16))`

Runtime was faster than KNN. Accuracy of 55 percent

### Support Vector Machine

`svm.SVC(kernel = 'linear')`

Even with the sample size of 1000, SVM takes a very long time... Therefore, we could not run with SVM since our size of dataset is more than 700000



