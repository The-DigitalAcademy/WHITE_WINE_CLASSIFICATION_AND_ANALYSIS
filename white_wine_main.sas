%web_drop_table(WORK.WINE);


FILENAME REFFILE '/home/u62791186/ATM_System/WhiteWineAnalysis/winequality_white.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.WINE;
	GETNAMES=YES;
	DELIMITER=';';
	DATAROW=2;
RUN;


proc means data=work.wine nmiss n;
run;

proc means data=work.wine;
run;

proc sort data=wine out=no_dups_data nodupkey;
    by _all_;
run;

title 'Distributing the percentage of wine quality';
proc sgplot data=WORK.no_dups_data;
	vbar quality / datalabel stat=percent
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;


proc corr data=WORK.no_dups_data pearson nosimple noprob plots=none;
	var 'residual sugar'n 'volatile acidity'n alcohol sulphates 'fixed acidity'n 
	    'citric acid'n chlorides 'free sulfur dioxide'n 'total sulfur dioxide'n
	    pH density;
	with quality;
run;


DATA WORK.no_dups_data;
 ATTRIB quality_label LENGTH=$5;
 SET WORK.no_dups_data;
 SELECT;
 WHEN (quality <= 5) quality_label = 'Bad';
 OTHERWISE quality_label = 'Good';
 END;


title'Distributing the percentage of wine quality';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / datalabel stat=percent
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Average of alcohol per wine quality';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response=alcohol stat=mean datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Average of sulphates per wine quality';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response=sulphates stat=mean datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Average of free sulfur dioxide per wine quality';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response='free sulfur dioxide'n stat=mean datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Average of total sulfur dioxide per wine quality';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response='total sulfur dioxide'n stat=mean datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Average of residual sugar per wine quality';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response='residual sugar'n stat=mean datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Average of chlorides per wine quality';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response=chlorides stat=mean datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Relationship between quality label and alcohol';
proc sgplot data=WORK.no_dups_data;
	vbox alcohol / category=quality_label;
	yaxis grid;
run;


title 'Relationship between quality label and sulphates';
proc sgplot data=WORK.no_dups_data;
	vbox sulphates / category=quality_label;
	yaxis grid;
run;

title 'Relationship between quality label and pH';
proc sgplot data=WORK.no_dups_data;
	vbox pH / category=quality_label;
	yaxis grid;
run;

title 'Quality label and density correlation';
proc sgplot data=WORK.no_dups_data;
	vbox density / category=quality_label;
	yaxis grid;
run;


title 'Wine quality vs alcohol';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response=alcohol datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Wine quality vs sulphates';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response=sulphates datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Wine quality vs pH';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response=pH datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Fixed acidity vs wine quality';
proc sgplot data=WORK.no_dups_data;
	vbar quality_label / response='fixed acidity'n datalabel
	categoryorder=respdesc nostatlabel;
	yaxis grid;
run;

title 'Relationship between alcohol and density based on wine quality';
proc sgplot data=WORK.no_dups_data;
	scatter x=alcohol y=density / group=quality_label;
	xaxis grid;
	yaxis grid;
run;


title 'Relationship between pH and fixed acidity based on wine quality';
proc sgplot data=WORK.no_dups_data;
	scatter x=pH y='fixed acidity'n / group=quality_label;
	xaxis grid;
	yaxis grid;
run;

title 'Relationship between alcohol and pH based on wine quality';
proc sgplot data=WORK.no_dups_data;
	scatter x=alcohol y=pH / group=quality_label;
	xaxis grid;
	yaxis grid;
run;

title 'Relationship between alcohol and volatile acidity based on wine quality';
proc sgplot data=WORK.no_dups_data;
	scatter x=alcohol y='volatile acidity'n / group=quality_label;
	xaxis grid;
	yaxis grid;
run;

title 'Relationship between alcohol and citric acid based on wine quality';
proc sgplot data=WORK.no_dups_data;
	scatter x=alcohol y='citric acid'n / group=quality_label;
	xaxis grid;
	yaxis grid;
run;

title 'Relationship between alcohol and residual sugar based on wine quality';
proc sgplot data=WORK.no_dups_data;
	scatter x=alcohol y='residual sugar'n / group=quality_label;
	xaxis grid;
	yaxis grid;
run;
title 'Relationship between alcohol and fixed acidity based on wine quality';
proc sgplot data=WORK.no_dups_data;
	scatter x=alcohol y='fixed acidity'n / group=quality_label;
	xaxis grid;
	yaxis grid;
run;