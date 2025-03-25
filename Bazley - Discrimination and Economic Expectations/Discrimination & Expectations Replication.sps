* Encoding: UTF-8.

* Name and load the dataset.
DATASET NAME discrim_exp.
DATASET ACTIVATE discrim_exp.

*********************************** Table 1: Summary Statistics ***********************************

* Produces all of Table 1 including p-values from two-sample t-tests.
T-TEST GROUPS=PervasiveDiscrim(1 0)
  /MISSING=ANALYSIS
  /VARIABLES=Age Female EducationLevel Income Married Race_White RiskTol Democrat EmployStatus
    NotHappyAtWork NumeracyScore FinLitScore FinDecMkr Attn_Incorrect
  /ES DISPLAY(FALSE)
  /CRITERIA=CI(.95).

* Panel A: Pervasive discrimination (Filtered where PervasiveDiscrim = 1).
USE ALL.
COMPUTE filter_$=(PervasiveDiscrim = 1).
VARIABLE LABELS filter_$ 'PervasiveDiscrim = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

DESCRIPTIVES VARIABLES=Age Female EducationLevel Income Married Race_White RiskTol Democrat 
    EmployStatus NotHappyAtWork NumeracyScore FinLitScore FinDecMkr Attn_Incorrect
  /STATISTICS=MEAN STDDEV.

FILTER off.

* Panel B: Rare discrimination (Filtered where PervasiveDiscrim = 0).
USE ALL.
COMPUTE filter_$=(PervasiveDiscrim = 0).
VARIABLE LABELS filter_$ 'PervasiveDiscrim = 0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

DESCRIPTIVES VARIABLES=Age Female EducationLevel Income Married Race_White RiskTol Democrat 
    EmployStatus NotHappyAtWork NumeracyScore FinLitScore FinDecMkr Attn_Incorrect
  /STATISTICS=MEAN STDDEV.

FILTER off.

*********************************** Table 3: Effects of Discrimination on Income UncertaintyModels (1) and (2) ***********************************

* Model 1: PervasiveDiscrim only.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN
  /DEPENDENT earn_sd
  /METHOD=ENTER PervasiveDiscrim.

* Model 2: PervasiveDiscrim + Demographic Controls.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN
  /DEPENDENT earn_sd
  /METHOD=ENTER PervasiveDiscrim Age Female EducationLevel Income Married Race_White RiskTol Democrat.

*********************************** Table 4:  Effects of Discrimination on Inflation Expectations Models (1) and (2) ***********************************
* Model 1: Regression with PervasiveDiscrim only.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN
  /DEPENDENT infl_mean
  /METHOD=ENTER PervasiveDiscrim.

* Model 2: Regression with PervasiveDiscrim and Demographic Controls.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN
  /DEPENDENT infl_mean
  /METHOD=ENTER PervasiveDiscrim Age Female EducationLevel Income Married Race_White RiskTol Democrat.
