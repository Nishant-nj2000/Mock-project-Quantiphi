create or replace TABLE MOCK_PROJECT_DB.PUBLIC."Demorgaphics_data_2015" (
	"primaryid" NUMBER(38,0) NOT NULL,
	"caseid" NUMBER(38,0),
	"i_f_code" VARCHAR(40),
	"event_dt" TIMESTAMP_NTZ(9),
	"mfr_dt" TIMESTAMP_NTZ(9),
	"init_fda_dt" TIMESTAMP_NTZ(9),
	"fda_dt" TIMESTAMP_NTZ(9),
	"rept_cod" VARCHAR(40),
	"mfr_num" VARCHAR(255),
	"mfr_sndr" VARCHAR(100),
	"age" NUMBER(38,0),
	"age_cod" VARCHAR(10),
	"age_grp" VARCHAR(10),
	"sex" VARCHAR(10),
	"wt" NUMBER(38,0),
	"wt_cod" VARCHAR(10),
	"rept_dt" TIMESTAMP_NTZ(9),
	"occp_cod" VARCHAR(10),
	"reporter_country" VARCHAR(40),
	"occr_country" VARCHAR(10),
	"serialid" NUMBER(38,0),
	primary key ("primaryid")
);




create or replace TABLE MOCK_PROJECT_DB.PUBLIC."DrugInformation_data_2015" (
	"primaryid" NUMBER(38,0),
	"caseid" NUMBER(38,0),
	"drug_seq" NUMBER(38,0),
	"role_cod" VARCHAR(10),
	"drugname" VARCHAR(16777216),
	"prod_ai" VARCHAR(16777216),
	"val_vbm" NUMBER(38,0),
	"route" VARCHAR(255),
	"dose_vbm" VARCHAR(16777216),
	"cum_dose_chr" NUMBER(38,10),
	"cum_dose_unit" VARCHAR(255),
	"rechal" VARCHAR(255),
	"dose_amt" VARCHAR(16777216),
	"dose_unit" VARCHAR(255),
	"dose_form" VARCHAR(255),
	"dose_freq" VARCHAR(255),
	"serialid" NUMBER(38,0)
);





create or replace TABLE MOCK_PROJECT_DB.PUBLIC."DrugTherapyDuration_data_2015" (
	"primaryid" NUMBER(38,0),
	"caseid" NUMBER(38,0),
	"dsg_drug_seq" NUMBER(38,0),
	"start_dt" TIMESTAMP_NTZ(9),
	"start_dt_unparsed" NUMBER(38,0),
	"end_dt" TIMESTAMP_NTZ(9),
	"end_dt_unparsed" NUMBER(38,0),
	"dur_cod" VARCHAR(40),
	"serialid" NUMBER(38,0)
);



create or replace TABLE MOCK_PROJECT_DB.PUBLIC."EventTerms_data_2015" (
	"primaryid" NUMBER(38,0),
	"caseid" NUMBER(38,0),
	"pt" VARCHAR(4000),
	"drug_rec_act" VARCHAR(4000),
	"serialid" NUMBER(38,0)
);




create or replace TABLE MOCK_PROJECT_DB.PUBLIC."PatientOutcomes_data_2015" (
	"primaryid" NUMBER(38,0),
	"caseid" NUMBER(38,0),
	"outc_cod" VARCHAR(10),
	"outc_cod_description" VARCHAR(255),
	"serialid" NUMBER(38,0)
);




create or replace TABLE MOCK_PROJECT_DB.PUBLIC."PreferredTermIndicators_data_2015" (
	"primaryid" NUMBER(38,0),
	"caseid" NUMBER(38,0),
	"indi_drug_seq" NUMBER(38,0),
	"indi_pt" VARCHAR(4000),
	"serialid" NUMBER(38,0)
);


create or replace TABLE MOCK_PROJECT_DB.PUBLIC."ReportSources_data_2015" (
	"primary_id" NUMBER(38,0),
	"caseid" NUMBER(38,0),
	"rpsr_code" VARCHAR(10),
	"serialid" NUMBER(38,0)
);