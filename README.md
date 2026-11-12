Predicting Self-Reported Diabetes Using Decision Trees: Evidence from NFHS-5

Rhyan George Michael
M.A. Public Policy & Governance, Tata Institute of Social Sciences

**Introduction**

Non-communicable diseases (NCDs), including diabetes, constitute an important public health concern. The use of machine learning models can help examine patterns in health data and identify the predictors associated with different health outcomes. This project uses a decision-tree classification model to predict self-reported current diabetes among respondents in India's National Family Health Survey (NFHS-5, 2019–21).

The objective is to examine the performance of a decision tree trained on socio-demographic and biomedical predictors. In particular, the project compares an unpruned decision tree with a depth-limited, cost-complexity-pruned model, focusing on how class imbalance affects the results.

**Data and methodology**

The data used for the analysis were extracted from three NFHS-5 files: the Household Member (PR), Individual Recode (IR) and Male Recode (MR) files. Information from the IR and MR files was combined and matched with the PR file to construct the analytical dataset. The outcome variable was drawn from respondents' reports of whether they currently had diabetes.

After cleaning the selected variables and excluding observations with missing values, the final analytical dataset contained 692,893 observations, with 12 predictors and one outcome variable. Only around 1.9% of observations reported diabetes, resulting in a heavily imbalanced dataset.

The predictors employed were hypertension, glucose, sector (rural/urban), wealth, age, gender, body mass index (BMI), education, alcohol use, smoking, systolic blood pressure and diastolic blood pressure.

The decision-tree models were developed in Python, using scikit-learn. Gini impurity was used as the splitting criterion, and balanced class weights were applied to account for the imbalance between the two outcome classes. The dataset was divided into training (60%), validation (20%) and testing (20%) sets using stratified sampling.

An initial unpruned decision tree was fitted on the development dataset (80%). For the second model, a maximum depth of 10 was combined with cost-complexity pruning. Due to computational limitations, a subset of 21 candidate alpha values was evaluated. The alpha value with the highest validation F1-score for the diabetes class was selected, after which the final model was refitted on the full development dataset. Both models were evaluated on the held-out test dataset.
**
Findings and interpretation**

The classification results highlight the importance of looking beyond accuracy when working with an imbalanced dataset.

Test-set metric

Unpruned tree

Depth-limited, pruned tree

Accuracy

96.94%

85.15%

Precision — diabetes (1)

17.31%

8.18%

Recall — diabetes (1)

16.15%

66.53%

F1-score — diabetes (1)

16.71%

14.57%

True positives

426

1,755

False positives

2,035

19,690

The unpruned model has a higher overall accuracy. However, this is misleading when considered in isolation, as the majority of observations do not report diabetes. The depth-limited and pruned model is better able to identify respondents reporting diabetes, with recall increasing from approximately 16% to 67%.

At the same time, the increase in recall comes at the cost of considerably lower precision. The number of false positives increases from 2,035 to 19,690, while the F1-score for the diabetes class also falls. Hence, the pruned model cannot be considered a universally better model simply because it captures more positive cases.

In the fitted pruned model, glucose (48.26%), hypertension (30.02%) and age (11.97%) had the highest feature-importance values. These values describe the contribution of predictors to the fitted tree's decisions; they do not indicate causal effects.

**Limitations and conclusion**

Predictive modelling can be useful in public health research, but caution is required when interpreting the findings. The outcome in this study is self-reported diabetes, rather than diabetes confirmed through clinical diagnosis. Moreover, measured glucose is one of the predictors, which limits the model's usefulness as a low-cost screening alternative. The complete-case approach may also introduce sample-selection bias, and not all possible inconsistencies in the blood-pressure readings were assessed.

The low precision of the pruned model is a particularly important limitation. Although it identifies a greater share of respondents reporting diabetes, it also incorrectly classifies many respondents as diabetes-positive. Consequently, the model should be understood as an exploratory classification exercise, not as a clinically validated diagnostic or screening tool.

Overall, the project demonstrates how model complexity, pruning and class imbalance can influence predictive performance, while also highlighting the need to interpret machine learning outputs within the limitations of the underlying health data.
