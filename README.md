# mlb_ant: Major League Baseball Pitch Type Prediction

[**mlb_ant**](https://github.com/yshong211/mlb_ant) is a Data Science Project exploring various machine learning methods that will predict the major leaguers' pitch type, based on the game-situational data. The initial idea came from [here](https://towardsdatascience.com/predicting-mlb-pitch-probability-based-on-the-game-situation-1afc5a01cf3), with the MLB Data being available at [Kaggle Website](https://www.kaggle.com/pschale/mlb-pitch-data-20152018). Majority of the idea came from this [Google Colaboratory](https://colab.research.google.com/drive/1VaHWXq2yYuH-S-6WL_WD8VFSugcgoiUz#scrollTo=eNI5nrnYrxPV), which can also be redirected from the "here" above.

## Approach

The initial approach of this project was done by first attempting to replicate the result that was already available: getting 51% overall accuracy over 11 pitch types (using XGBoostClassifier). The features that were used for prediction were all directly related to pitches only (available at `pitches.csv`), but we were also hoping that we can add more features, such as in which stadium were the games played, how was the weather condition, as well as the direction of the wind. Therefore, we decided to include those.

We first merge all the information from `pitches.csv`, `atbats.csv`, `games.csv`, and `player_names.csv`. We train and test our model based on year 2018 data only. In addition to what were done to the codes from [Colab](https://colab.research.google.com/drive/1VaHWXq2yYuH-S-6WL_WD8VFSugcgoiUz#scrollTo=eNI5nrnYrxPV), we add the new feature that accounts for the temperature, wind, and the stadium. Moreover, ~~mention about recency feature~~

So far, we have used the following machine learning algorithms:
* XGBoost
* KNN
* Naïve Bayes

### XGBoost

`xgb.XGBClassifier(eval_metric='mlogloss')`

### KNN

`KNeighborsClassifier(n_neighbors=11)`

### Naïve Bayes

