* Encoding: UTF-8.
* Table 1: Descriptive Statistics

* Load the two datasets dataset.

GET
  STATA FILE='C:\Users\cchow\OneDrive - Bentley '+
    'University\CliftonDocs\Class_1-24-24\ExePhDQuant\Assignments Fall 2024\Research Paper '+
    'Replication Data\Colella Moral Support Performance Data\dta\data_1_liga.dta'.
DATASET NAME DataSet8 WINDOW=FRONT.
DATASET NAME liga.

GET
  STATA FILE='C:\Users\cchow\OneDrive - Bentley '+
    'University\CliftonDocs\Class_1-24-24\ExePhDQuant\Assignments Fall 2024\Research Paper '+
    'Replication Data\Colella Moral Support Performance Data\dta\data_2_copa.dta'.
DATASET NAME DataSet8 WINDOW=FRONT.
DATASET NAME copa.

* Load the liga dataset.
DATASET ACTIVATE liga.

* T1 Before/Panel A.
USE ALL.
COMPUTE filter_$=(law = 0).
VARIABLE LABELS filter_$ 'law = 0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
DESCRIPTIVES VARIABLES=visitor_loser visitor_winner draw
    score_diff goals_t1 goals_t2
    tot_red_cards_t1 tot_red_cards_t2
    yellow_cards_t1 yellow_cards_t2
    penalty_awarded_t1 penalty_awarded_t2
    /STATISTICS=MEAN STDDEV.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST]
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.
FILTER OFF.

* T1 After/Panel A.
USE ALL.
COMPUTE filter_$=(law = 1).
VARIABLE LABELS filter_$ 'law = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
DESCRIPTIVES VARIABLES=visitor_loser visitor_winner draw
    score_diff goals_t1 goals_t2
    tot_red_cards_t1 tot_red_cards_t2
    yellow_cards_t1 yellow_cards_t2
    penalty_awarded_t1 penalty_awarded_t2
    /STATISTICS=MEAN STDDEV.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST]
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.
FILTER OFF.

* Load the copa dataset.
DATASET ACTIVATE copa.

* T1 Before/Panel B.
USE ALL.
COMPUTE filter_$=(law = 0).
VARIABLE LABELS filter_$ 'law = 0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
DESCRIPTIVES VARIABLES=visitor_loser visitor_winner draw
  /STATISTICS=MEAN STDDEV.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST]
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.
FILTER OFF.

* T1 After/Panel B.
USE ALL.
COMPUTE filter_$=(law = 1).
VARIABLE LABELS filter_$ 'law = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.
DESCRIPTIVES VARIABLES=visitor_loser visitor_winner draw
  /STATISTICS=MEAN STDDEV.
  OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST]
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.
FILTER OFF.

* Table 2: Linear Regression

* Load the liga dataset.
DATASET ACTIVATE liga.

* T2 Regression 1: OLS.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT visitor_loser
  /METHOD=ENTER law.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST] 
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.

* T2 Regression 1: Robust SE.
UNIANOVA visitor_loser WITH law
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT PARAMETER
  /CRITERIA=ALPHA(.05)  
  /ROBUST=HC3
  /DESIGN=law.

* T2 Regression 5: Including dummies for Club_ID_t1.
UNIANOVA visitor_loser BY Club_ID_t1 WITH law
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT PARAMETER
  /CRITERIA=ALPHA(.05)
  /ROBUST=HC3
  /DESIGN=law Club_ID_t1.

* T2 Regression 6: Including dummies for Club_ID_t2.
UNIANOVA visitor_loser BY Club_ID_t2 WITH law
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT PARAMETER
  /CRITERIA=ALPHA(.05)
  /ROBUST=HC3
  /DESIGN=law Club_ID_t2.

*  Table 4: Linear Regression

* Load the copa dataset.
DATASET ACTIVATE copa.

* T4 Regression 1: Linear Regression.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT visitor_loser
  /METHOD=ENTER law.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST] 
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.

* T4 Regression 1: Robust SE.
UNIANOVA visitor_loser WITH law
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT PARAMETER
  /CRITERIA=ALPHA(.05)  
  /ROBUST=HC3
  /DESIGN=law.

* T4 Regression 5: Including dummies for Club_ID_t1.
UNIANOVA visitor_loser BY Club_ID_t1 WITH law
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT PARAMETER
  /CRITERIA=ALPHA(.05)
  /ROBUST=HC3
  /DESIGN=law Club_ID_t1.

* T4 Regression 6: Including dummies for Club_ID_t2.
UNIANOVA visitor_loser BY Club_ID_t2 WITH law
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT PARAMETER
  /CRITERIA=ALPHA(.05)
  /ROBUST=HC3
  /DESIGN=law Club_ID_t2.



* Load liga dataset.
DATASET ACTIVATE liga.

*Table 6 to be done manually through drag and drop

* Table 6: Multiple Linear Regression with Restricted Models

* Load liga dataset.
DATASET ACTIVATE liga.

* Create interaction terms.
COMPUTE visitbig5_homebig5 = big_5_visitor * big_5_local.
COMPUTE visitbig5_homebig5_ban = big_5_visitor * big_5_local * law.
EXECUTE.

* T6 Regression 1.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT visitor_loser
  /METHOD=ENTER law   big_5_visitor   big_5_local   law_big_5_visitor   law_big_5_local   visitbig5_homebig5   visitbig5_homebig5_ban.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST] 
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.

* T6 Regression 5: No Home Team (Does not replicate paper!).
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT visitor_loser
  /METHOD=ENTER law   big_5_visitor   law_big_5_visitor   law_big_5_local   visitbig5_homebig5   visitbig5_homebig5_ban.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST] 
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.

* T6 Regression 6: No Away Team (Does not replicate paper!).
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT visitor_loser
  /METHOD=ENTER  law   big_5_local   law_big_5_visitor   law_big_5_local   visitbig5_homebig5   visitbig5_homebig5_ban.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST] 
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.

* T6 Regression 7: No Home or Away Team (Does not replicate paper!).
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS
  /CRITERIA=PIN(.05) POUT(.10) TOLERANCE(.0001)
  /NOORIGIN 
  /DEPENDENT visitor_loser
  /METHOD=ENTER  law   law_big_5_visitor   law_big_5_local   visitbig5_homebig5   visitbig5_homebig5_ban.
OUTPUT MODIFY
  /REPORT PRINTREPORT=NO
  /SELECT TABLES
  /IF COMMANDS=[LAST] 
  /TABLECELLS SELECT=[BODY] SELECTCONDITION=ALL FORMAT="F.3" APPLYTO=CELL.
