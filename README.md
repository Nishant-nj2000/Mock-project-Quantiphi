# Mock-project-Quantiphi

## Data Description:

This dataset talks about the medication error reports, submitted to the FDA, to support the
post-marketing safety surveillance program for drug and therapeutic biologic products. The structure of
the AERS database adheres to the international safety reporting guidance issued by the International
Conference on Harmonisation (ICH E2B). Adverse events and medication errors are coded to terms in the
Medical Dictionary for Regulatory Activities (MedDRA) terminology.

------------------------------------------------------------------------------------------------------------------------

## Data Files:

https://drive.google.com/file/d/1XiRsJBIZpb2sZ2caThtjj71nAzl3rGEq/view?usp=sharing

------------------------------------------------------------------------------------------------------------------------

## Technologies Used:

● IICS

● PowerBI

● Snowflake

● Python

● SQL

------------------------------------------------------------------------------------------------------------------------

## Architecture diagram
![image](https://user-images.githubusercontent.com/72196083/179357224-346a6da0-e587-4753-b05a-ccf29e82d441.png)

------------------------------------------------------------------------------------------------------------------------

## SQL

### ● Creating schema for all the tables
```
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
```
------------------------------------------------------------------------------------------------------------------------

## ETL

### ● Configured snowflake connector in IICS to fetch the tables which were uploaded using the below .py script

Load.py
```
#Importing the required packages for all your data framing needs.
from tokenize import String
import pandas as pd
#The Snowflake Connector library.
import snowflake.connector as snow
from snowflake.connector.pandas_tools import write_pandas


conn = snow.connect(user="NISHANT007",
password="Gangsternj@27",
account="in17047.uae-north.azure",
#(the prefix in your snowflake space... for example, company.snowflakecomputing.com would just be "company" as the ACCOUNT name)
warehouse="MOCK_PROJECT",
database="MOCK_PROJECT_DB",
schema="PUBLIC")

#Create a cursor object.
cur = conn.cursor()

##Phase II: Upload from the Exported Data File.
#Let's import a new dataframe so that we can test this.
original = r"C:\Users\nisha\Downloads\Medication_Error_Effect_Datasets\DrugInformation_data_2015.csv" # <- Replace with your path.
delimiter = "," # Replace if you're using a different delimiter.

#Get it as a pandas dataframe.
total = pd.read_csv(original, sep = delimiter, low_memory=False)

#Actually write to the table in snowflake.
write_pandas(conn, total, "DrugInformation_data_2015")

#(Optionally, you can check to see if what you loaded is identical to what you have in your pandas dataframe. Perhaps... a topic for a future blog post.)

##Phase III: Turn off the warehouse.
#Create a cursor object.
cur = conn.cursor()

sql = "ALTER WAREHOUSE MOCK_PROJECT SUSPEND"
cur.execute(sql)

#Close your cursor and your connection.
cur.close()
conn.close()
```
------------------------------------------------------------------------------------------------------------------------

## Data warehouse

### Source Tables:
  ![image](https://user-images.githubusercontent.com/72196083/179357635-02fbddf4-8f87-443f-a3c2-31fa22b51418.png)

### Step 1: Go to Admin Panel

  ![image](https://user-images.githubusercontent.com/72196083/179357653-d837e5ea-f69e-4851-a029-10c67192ccf8.png)

### Step 2: Go to Add-On Connectors

  ![image](https://user-images.githubusercontent.com/72196083/179357667-e72b8963-9b82-49d2-9801-10dd56996178.png)

### Step 3: Search for Snowflake connector and activate it.

  ![image](https://user-images.githubusercontent.com/72196083/179357680-95595cf0-6a6b-4534-9ce6-eeba553146fa.png)

### Step 4: Go to Data Integration

  ![image](https://user-images.githubusercontent.com/72196083/179357712-e4c5725e-438c-48f0-b701-ce8ffaca8a93.png)

### Step 5: Create a new mapping

  ![image](https://user-images.githubusercontent.com/72196083/179357754-f9a29604-a8af-431e-9916-c08dd7b51785.png)

### Step 6: Source

  ![image](https://user-images.githubusercontent.com/72196083/179357770-a0a38d5a-1bd9-4296-8e92-b061123beaa8.png)

### Step 7: Configure connection (if not exists) create a new Connection, test it and save.

  ![image](https://user-images.githubusercontent.com/72196083/179357878-3d9f6773-1919-4cd2-8097-9e10d4cc5ebb.png)

### Step 8: Create Mapping

  #### ● Aggregator - Remove Duplicate Records
  
  ![image](https://user-images.githubusercontent.com/72196083/179358119-b3cf573f-e13f-4d2a-bb33-64e1ef84031e.png)

    (a) Select a column on whose basis you want to delete duplicate records

    (b) Check the Sorted Input
    ![image](https://user-images.githubusercontent.com/72196083/179358127-c2231b63-069a-4f10-9a1a-3d3f5b41a772.png)

  #### ● (OPTIONAL) Expression - Derive age group from the age column
  
  ![image](https://user-images.githubusercontent.com/72196083/179358162-452fe0a0-2175-475d-92d6-5b6a9c08c1c5.png)

    (a) Add a new expression
    ![image](https://user-images.githubusercontent.com/72196083/179358180-8ff23e5e-8dfe-4fc2-9372-2f205479972a.png)

  #### ● Filter - Remove records with NULL values.
  
  ![image](https://user-images.githubusercontent.com/72196083/179358200-867f9a61-10e4-4a70-801f-44b8942b5c03.png)

    (a) Select Advanced from the dropdown and use Decode to write multiple conditions
    and validate it.
    ![image](https://user-images.githubusercontent.com/72196083/179358228-08cfd09e-46dc-4dbe-8330-206e650a825b.png)
    
  ### ● Target
  
  ![image](https://user-images.githubusercontent.com/72196083/179358241-d440de19-21eb-489c-8579-edf9b897072a.png)

    (a) Repeat Step 7 if the target connection is not created.

    (b) Select Object or Create a new at runtime
    ![image](https://user-images.githubusercontent.com/72196083/179358272-45d276b5-ad47-4e1c-8913-ae67ba33b38e.png)

    (c) Choose operation as INSERT if creating a new at runtime or update if object already exists
    ![image](https://user-images.githubusercontent.com/72196083/179358338-decc2c9a-4639-4720-8f4f-ac8f58cf3a60.png)

  #### Step 9 : Save and Run the Mapping
  
  ![image](https://user-images.githubusercontent.com/72196083/179358403-49ee88df-cc46-4943-8128-bee0e3ba7ecc.png)

------------------------------------------------------------------------------------------------------------------------

## Target Tables:

![image](https://user-images.githubusercontent.com/72196083/179358420-5e99dec6-0d7b-44d8-8b1b-35984c3d3fec.png)

------------------------------------------------------------------------------------------------------------------------

## Transformations used:

● Source

● Filter

● Aggregator

● Function Expression

● Target

------------------------------------------------------------------------------------------------------------------------

## Data modeling

### ● Identify dimensions and facts and perform data modeling.
  Dimension Tables :
  
    1. Demorgaphics_data_2015
    2. DrugInformation_data_2015
    3. ReportSources_data_2015
  
  Fact Tables :
  
    1. DrugTherapyDuration_data_2015
    2. EventTerms_data_2015
    3. PatientOutcomes_data_2015
    4. PreferredTermIndicator_data_2015
    
![image](https://user-images.githubusercontent.com/72196083/179358628-495465d7-fa60-4701-a78d-f4b43c155046.png)

------------------------------------------------------------------------------------------------------------------------

## Dashboarding and story building

### ● Dashboarding using PowerBI | Snowflake DWH

![image](https://user-images.githubusercontent.com/72196083/179358773-6c9857f1-7b3b-4238-90dd-655042e10eb0.png)

![image](https://user-images.githubusercontent.com/72196083/179358787-9a743b37-b45e-47ee-8016-7af7c1dc914e.png)

![image](https://user-images.githubusercontent.com/72196083/179358799-36258264-f0a1-4ebf-ba31-ca1fca5aa4d5.png)

![image](https://user-images.githubusercontent.com/72196083/179358805-b9665577-5f14-4040-b895-873af7366457.png)

------------------------------------------------------------------------------------------------------------------------

## References
● https://onlinehelp.informatica.com/IICS/prod/admin/en/index.htm#page/aa-admin-whats-new/
Serverless_runtime_environments.html
● https://docs.snowflake.com/en/
● https://stackoverflow.com/
● Questions and Answers on FDA's Adverse Event Reporting System (FAERS) | FDA
● Qlik Sense (fda.gov)


