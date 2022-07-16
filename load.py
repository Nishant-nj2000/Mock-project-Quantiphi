#Importing the required packages for all your data framing needs.
from tokenize import String
import pandas as pd
# The Snowflake Connector library.
import snowflake.connector as snow
from snowflake.connector.pandas_tools import write_pandas


conn = snow.connect(user="NISHANT007",
password="Gangsternj@27",
account="in17047.uae-north.azure",
# (the prefix in your snowflake space... for example, 
# company.snowflakecomputing.com would just be "company" as the ACCOUNT name)
warehouse="MOCK_PROJECT",
database="MOCK_PROJECT_DB",
schema="PUBLIC")

# Create a cursor object.
cur = conn.cursor()

## Phase II: Upload from the Exported Data File.
# Let's import a new dataframe so that we can test this.
original = r"C:\Users\nisha\Downloads\Medication_Error_Effect_Datasets\DrugInformation_data_2015.csv" # <- Replace with your path.
delimiter = "," # Replace if you're using a different delimiter.

# Get it as a pandas dataframe.
total = pd.read_csv(original, sep = delimiter, low_memory=False)

# Actually write to the table in snowflake.
write_pandas(conn, total, "DrugInformation_data_2015")

# (Optionally, you can check to see if what you loaded is identical
# to what you have in your pandas dataframe. Perhaps... a topic for a future 
# blog post.)

## Phase III: Turn off the warehouse.
# Create a cursor object.
cur = conn.cursor()

sql = "ALTER WAREHOUSE MOCK_PROJECT SUSPEND"
cur.execute(sql)

# Close your cursor and your connection.
cur.close()
conn.close()