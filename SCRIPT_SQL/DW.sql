-- Database: loadsmart_dw
-- Star Schema Model
-- DROP DATABASE IF EXISTS loadsmart_dw;

-- Creating the datawarehouse 'loadsmart_dw'

CREATE DATABASE loadsmart_dw
    WITH 
    OWNER = user
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = default
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE loadsmart_dw
    IS 'Data Model Built for the LoadSmart''s Data Challenge.';
	
	
-- Creating StagingArea For Dataset Raw Data
-- Table: public.staging_area_loadsmart

-- DROP TABLE IF EXISTS public.staging_area_loadsmart;
CREATE TABLE IF NOT EXISTS public.staging_area_loadsmart
(
    loadsmart_id integer,
    lane character varying(50) COLLATE pg_catalog."default",
    quote_date varchar(30),
    book_date varchar(30),
    source_date varchar(30),
    pickup_date varchar(30),
    delivery_date varchar(30),
    book_price float,
    source_price float,
    pnl float,
    mileage float,
    equipment_type character varying(50) COLLATE pg_catalog."default",
    carrier_rating integer,
    sourcing_channel character varying(50) COLLATE pg_catalog."default",
    vip_carrier boolean,
    carrier_dropped_us_count integer,
    carrier_name character varying(50) COLLATE pg_catalog."default",
    shipper_name character varying(50) COLLATE pg_catalog."default",
    carrier_on_time_to_pickup boolean,
    carrier_on_time_to_delivery boolean,
    carrier_on_time_overall boolean,
    pickup_appointment_time varchar(30),
    delivery_appointment_time varchar(30),
    has_mobile_app_tracking boolean,
    has_macropoint_tracking boolean,
    has_edi_tracking boolean,
    contracted_load boolean,
    load_booked_autonomously boolean,
    load_sourced_autonomously boolean,
    load_was_cancelled boolean
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.staging_area_loadsmart
    OWNER to postgres;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_database_owner;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_execute_server_program;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_monitor;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_read_all_data;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_read_all_settings;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_read_all_stats;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_read_server_files;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_signal_backend;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_stat_scan_tables;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_write_all_data;

GRANT ALL ON TABLE public.staging_area_loadsmart TO pg_write_server_files;

GRANT ALL ON TABLE public.staging_area_loadsmart TO postgres;
 

--Star Schema DW
 
--Creating Dimensions and Facts tables
--dim_carrier is a dimensional table that holds data of all carriers
DROP TABLE IF EXISTS dim_carrier;
CREATE TABLE dim_carrier
(
	carrier_sk 	 			 SERIAL 		NOT NULL,
	carrier_name 			 VARCHAR(200) 	NOT NULL,
	vip_carrier  			 BOOLEAN        NULL, 
CONSTRAINT carrier_pk PRIMARY KEY (carrier_sk)
);


--dim_shipper is a dimensional table that holds data of all shippers
DROP TABLE IF EXISTS dim_shipper;
CREATE TABLE dim_shipper
(
	shipper_sk 	 SERIAL 	  NOT NULL,
	shipper_name VARCHAR(200) NOT NULL,
CONSTRAINT shipper_pk PRIMARY KEY (shipper_sk)
);


--dim_equipment is a dimensional table that holds data of all equipments
DROP TABLE IF EXISTS dim_equipment;
CREATE TABLE dim_equipment
(
	equipment_sk   SERIAL 	  NOT NULL,
	equipment_type VARCHAR(5) NOT NULL,
CONSTRAINT equipment_pk PRIMARY KEY (equipment_sk)
);


/*fact_pickup_delivery is the fact table of the star schema model built, and it holds 
all measures and features of pickups and deliveries
*/
DROP TABLE IF EXISTS fact_pickup_delivery;
CREATE TABLE fact_pickup_delivery
(
	loadsmart_sk 					SERIAL 			NOT NULL,
	loadsmart_nk 					INT 				NOT NULL,
	carrier_sk 	 					INT 				NOT NULL,
	shipper_sk   					INT 				NOT NULL,
	equipment_sk 					INT 				NOT NULL,
	quote_date   					TIMESTAMP			NOT NULL,
	book_date	 					TIMESTAMP			NOT NULL,
	source_date	 					TIMESTAMP			NOT NULL,
	pickup_date	 					TIMESTAMP			NOT NULL,
	delivery_date					TIMESTAMP			NOT NULL,
	book_price						DECIMAL(30,2)		NOT NULL,
	source_price					DECIMAL(30,2)		NOT NULL,
	pnl								DECIMAL(30,2)		NOT NULL,
	mileage							DECIMAL(30,2)		NOT NULL,
	carrier_rating					INT		 			NULL,
	carrier_dropped_us_count 		INT		            NULL, 
	sourcing_channel				VARCHAR(10)			NULL,
	carrier_on_time_to_pickup		BOOLEAN				NOT NULL,
	carrier_on_time_to_delivery		BOOLEAN				NOT NULL,
	carrier_on_time_overall			BOOLEAN				NOT NULL,
	pickup_appointment_time			BOOLEAN				NOT NULL,
	delivery_appointment_time		BOOLEAN				NOT NULL,
	has_mobile_app_tracking			BOOLEAN				NOT NULL,
	has_macropoint_tracking			BOOLEAN				NOT NULL,
	has_edi_tracking				BOOLEAN				NOT NULL,
	contracted_load					BOOLEAN				NOT NULL,
	load_booked_autonomously		BOOLEAN				NOT NULL,
	load_sourced_autonomously		BOOLEAN				NOT NULL,
	load_was_cancelled				BOOLEAN				NOT NULL,
CONSTRAINT loadsmart_pk PRIMARY KEY (loadsmart_sk)
);


	