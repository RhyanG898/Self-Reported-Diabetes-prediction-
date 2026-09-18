set maxvar 15000
use "C:\Users\rgmic\OneDrive\Desktop\PPG Coursework and Notes\DDP\LASI DTA\2_LASI_W1_Household_v4.dta"
merge 1:m hhid using "C:\Users\rgmic\OneDrive\Desktop\PPG Coursework and Notes\DDP\LASI DTA\3_LASI_W1_Individual_v4 (2).dta"
save "C:\Users\rgmic\STATAfiles\LASI_Merged_Wave_1.dta"
recode dm003 (1=1 "Male") (2=2 "Female"), g(sex)
tab sex
recode dm005 (45/59=1 "45-59") (60/69=2 "60-69") (70/79=3 "70-79") (80/max=4 "80+"), g(age_grp)
tab age_grp
tab religion
tab caste
recode dm008 (0=0 "no education") (1/2=1 "primary") (3/4=2 "secondary") (5/9=3 "higher") (else=0), g(edu)
recode dm021 (1=1 "currently married") (2=2 "widowed") (3/7=3 "D/S/D/N"), gen(marital)
tab marital
tab residence
tab mpce_quintile
recode ht401 (1=1) (2=0) (else=.), g(adl1)
recode ht402 (1=1) (2=0) (else=.), g(adl2)
recode ht403 (1=1) (2=0) (else=.), g(adl3)
recode ht404 (1=1) (2=0) (else=.), g(adl4)
recode ht405 (1=1) (2=0) (else=.), g(adl5)
recode ht406 (1=1) (2=0) (else=.), g(adl6)
recode ht407 (1=1) (2=0) (else=.), g(adl7)
gen ADL=adl1+adl2+adl3+adl4+adl5+adl6
tab ADL
recode ht002 (1=1) (2=0) (else=.), g(disease1)
recode ht003 (1=1) (2=0) (else=.), g(disease2)
recode ht004 (1=1) (2=0) (else=.), g(disease3)
recode ht005 (1=1) (2=0) (else=.), g(disease4)
recode ht006 (1=1) (2=0) (else=.), g(disease5)
recode ht007 (1=1) (2=0) (else=.), g(disease6)
recode ht008 (1=1) (2=0) (else=.), g(disease7)
recode ht009 (1=1) (2=0) (else=.), g(disease8)
recode ht010 (1=1) (2=0) (else=.), g(disease9)
gen Disease= disease1+disease2 +disease3 +disease4 +disease5 +disease6 +disease7+ disease8 + disease9
tab Disease
tab we004
recode we004 (1=1) (2=0) (else=.), g(current)
tab current
recode ADL (0=0) (1/6=1) (else=.), g(adl)
tab adl
recode Disease (0=0) (1=1) (2/7=2) (else=.), g(Multi_morbidity)
tab Multi_morbidity
tab he024
recode he024 (1=1) (2 3=0) (else=.), g(house_m)
tab he006
recode he006 (1 2 3 7 10= 1) (4 5 6 8 9 11=0) (else=.), g(water)
tab water
drop water
recode he006 (1 2 3 10= 1) (4 5 6 8 9 7 11=0) (else=.), g(water)
tab water
tab he013
recode he013 (1=1) (2=0) (else=.), g(electricity)
tab he014
gen cooking= inlist(he014, 1, 2, 4) if !missing(he014)
tab cooking
tab he004
recode he004 (1=1) (2/5=0) (else=.), g(toilet)
tab toilet
tab ad002
recode ad002 (1=1) (2=0) (else=.), g(asset1)
recode ad003 (1=1) (2=0) (else=.), g(asset2)
recode ad004 (1=1) (2=0) (else=.), g(asset3)
recode ad005 (1=1) (2=0) (else=.), g(asset6)
recode ad006 (1=1) (2=0) (else=.), g(asset4)
recode ad007 (1=1) (2=0) (else=.), g(asset5)
pca toilet water house_m cooking electricity asset1 asset2 asset3 asset4 asset5 asset6
estat kmo
screeplot, yline(1)
predict wealth_score, score
xtile w_trecile= wealth_score, nq(3)
xtile w_q= wealth_score, nq(5)
preserve
logit current i.w_q i.marital ib4.caste i.residence i.sex i.religion i.edu i.hc102 i.ad901, or
restore
keep if dm005>=60 & Multi_morbidity>=1 
logit current i.w_q i.marital ib4.caste i.residence i.sex i.religion i.edu i.hc102 i.ad901, or