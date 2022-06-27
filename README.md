# LoadSmart_DataChallenge
Load Smart ETL and Data Analysis solution

Tutorial to reproduce solution:

1 -  Create a PostgreSQL OR Any other Database by using DW.sql script located inside the SCRIPT_SQL folder

2 - Install Talend Open Source located inside the SCRIPT_ETL folder

3 - Unzip ETL_LOADSMART_DW inside Talend Open Source Workspace (path:
C:\Program Files (x86)\TOS_DI-8.0.1\studio\workspace)

4 - Open ETL_LOADSMART_DW in Talend
 4.1 - Open Talend
 4.2 - Select an existing Project OR Import an existing project -ETL_LOADSMART_DW
 4.3 Click Finish

5 - Change Database Credentials 
 5.1 - Click on Metadata
 5.2 - Db Connections
 5.3 - Right click on postgresConnection
 5.4 - Edit connection to retrive the loadsmart_DW and save

6 - Run the 3 jobs in Talend 
 6.1 Job 1  - insert_Raw_Dataset_To_Staging_01
 6.2 Job 2  - insert_Update_Dimensions_Task_02
 6.3 Job 3  - isnert_update_fact_table_03

7 - Open dashboard.pbix and configure your database credentials in order
to load the fact and dimensions tables, and the visualizations and KPIs correctly.
