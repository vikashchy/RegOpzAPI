rename table business_rules to business_rules_0526;

create table business_rules (
    id                       bigint not null primary key auto_increment,
    rule_execution_order     VARCHAR(15) NOT NULL,
    business_rule            varchar(15) NOT NULL,
    source_id                SMALLINT NOT NULL,
    rule_description         VARCHAR(300),
    logical_condition        VARCHAR(300),
    data_fields_list         VARCHAR(600),
    python_implementation    VARCHAR(2000),
    business_or_validation   VARCHAR(10),
    rule_type                VARCHAR(15),
    valid_from               datetime,
    valid_to                 datetime,
    last_updated_by          VARCHAR(20),
    country                  VARCHAR(2)
);

insert into business_rules select id,rule_execution_order,business_rule,source_id, rule_description,logical_condition, data_fields_list, python_implementation,business_or_validation, rule_type, null, null, null,'SG' from business_rules_0526;  id bigint not null primary key auto_increment

rename table report_def to report_def_0526;

create table report_def (
    id              bigint not null primary key auto_increment
	report_id       VARCHAR(32) NOT NULL,
    sheet_id        VARCHAR(32) NOT NULL,
    cell_id         VARCHAR(10) NOT NULL,
    cell_render_def VARCHAR(32) NOT NULL,
    cell_calc_ref   VARCHAR(1000) NOT NULL,
    valid_from      datetime,
    valid_to        datetime,
    last_updated_by VARCHAR(100),
    country         VARCHAR(2),
    
);

insert into report_def select report_id,sheet_id,cell_id,cell_render_def,cell_calc_ref,null,null,null,'SG' from report_def_0526;

rename table report_calc_def to report_calc_def_0526;

create table report_calc_def (
    source_id           SMALLINT NOT NULL,
    report_id       VARCHAR(32) NOT NULL,
    sheet_id        VARCHAR(32) NOT NULL,
    cell_id         VARCHAR(10) NOT NULL,
    cell_calc_ref    VARCHAR(30) NOT NULL,
    cell_business_rules VARCHAR(2000) NOT NULL,
    aggregation_ref  VARCHAR(1000) NOT NULL,
    aggregation_func VARCHAR(1000) NOT NULL,
    valid_from          datetime,
    valid_to            datetime,
    last_updated_by     VARCHAR(100),
    country         VARCHAR(2),
    id               bigint not null primary key auto_increment
);

insert into report_calc_def select source_id,report_id,sheet_id,cell_id,cell_calc_ref,cell_business_rules,aggregation_ref,
aggregation_func,null,null,null,'SG' 
from report_calc_def_0526;

rename table report_comp_agg_def to report_comp_agg_def_0526;

create table report_comp_agg_def(
    report_id       VARCHAR(32) NOT NULL,
    sheet_id        VARCHAR(32) NOT NULL,
    cell_id         VARCHAR(10) NOT NULL,
    comp_agg_ref     VARCHAR(2000) NOT NULL,
    reporting_scale  FLOAT NOT NULL,
    rounding_option  VARCHAR(50),
    valid_from       datetime,
    valid_to         datetime,
    last_updated_by  VARCHAR(100),
    country         VARCHAR(2),
    id               bigint not null primary key auto_increment
);

insert into report_comp_agg_def select report_id,sheet_id,cell_id,comp_agg_ref,reporting_scale,rounding_option,
null,null,null,'SG' 
from report_comp_agg_def_0526;

rename table calendar to calendar_0526;

CREATE TABLE calendar (
    business_date   VARCHAR(8) NOT NULL,
    holiday_working VARCHAR(2) NOT NULL,
    country         VARCHAR(2) NOT NULL,
    last_updated_by  VARCHAR(100),
    id      DECIMAL(8) not null primary key
);

insert into calendar
select business_date, holiday_working,country,null,business_date
from calendar_0526;

rename table exchange_rate to exchange_rate_0526;

CREATE TABLE exchange_rate (
    from_currency VARCHAR(3) NOT NULL,
    to_currency   VARCHAR(3) NOT NULL,
    rate          FLOAT NOT NULL,
    business_date DECIMAL(8) NOT NULL,    
    rate_type     VARCHAR(20) NOT NULL,
    country         VARCHAR(2) NOT NULL,
    last_updated_by  VARCHAR(100),
    id    bigint not null primary key auto_increment 
);

insert into exchange_rate
select from_currency, to_currency,rate,business_date,rate_type,'SG',null,null
from exchange_rate_0526 where length(from_currency)=3;

rename table manual_adjustment to manual_adjustment_0526;

CREATE TABLE manual_adjustment (
    report_id       VARCHAR(32) NOT NULL,
    sheet_id        VARCHAR(32) NOT NULL,
    cell_id         VARCHAR(10) NOT NULL,
    adjustment_value VARCHAR(1000),
    currency         VARCHAR(3),
    comment          VARCHAR(1000),
    business_date    DECIMAL(8) NOT NULL,
    id               bigint not null primary key auto_increment 
);

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


create table data_source_col_name(
	id						bigint not null primary key auto_increment, 
	source_id				SMALLINT NOT NULL,
	business_date			int(8),
	source_table_name 		VARCHAR(32) NOT NULL,
	column_name				varchar(100),
	column_datatype			varchar(100),
	column_default_value	varchar(100),
	column_is_nullable		varchar(100),
	column_max_length		int(11),
	column_key				varchar(255),
	column_display_name		varchar(255),
	column_comment			varchar(1000)		 
);


create table data_source_information (
id	bigint not null primary key auto_increment,
source_id   SMALLINT NOT NULL,
source_table_name VARCHAR(32) NOT NULL,
source_description VARCHAR(1000),
source_file_name VARCHAR(200) NOT NULL,
source_file_delimiter VARCHAR(1) NOT NULL,
last_updated_by VARCHAR(255),
country VARCHAR(2)
);

rename table qualified_data to qualified_data_20170619;

CREATE TABLE qualified_data (
source_id SMALLINT NOT NULL,
qualifying_key BIGINT NOT NULL,
business_rules varchar(3000) NOT NULL,  
buy_currency VARCHAR(3),
sell_currency VARCHAR(3),
mtm_currency VARCHAR(3),
business_date int(8)
);

CREATE TABLE qualified_data (
    //id				bigint not null primary key auto_increment,
    source_id      			SMALLINT NOT NULL,
    qualifying_key 			BIGINT NOT NULL,
    business_rules 			varchar(3000) NOT NULL,  
    buy_currency   			VARCHAR(3),
    sell_currency  			VARCHAR(3),
    mtm_currency   			VARCHAR(3),
    business_date  			int(8),
    data_ver 	VARCHAR(200),
    data_ver_timestamp DATETIME
);

rename table invalid_data to invalid_data_20170619;

create table invalid_data (
source_id      SMALLINT NOT NULL,
qualifying_key BIGINT NOT NULL,
business_rules varchar(3000) NOT NULL,
business_date  int(8)
);



create table invalid_data (
source_id      SMALLINT NOT NULL,
qualifying_key BIGINT NOT NULL,
business_rules varchar(3000) NOT NULL,
business_date  int(8),
data_ver TEXT,
data_ver_timestamp DATETIME
);


rename table report_qualified_data_link to report_qualified_data_link_20170619;


CREATE TABLE report_qualified_data_link (
source_id           SMALLINT NOT NULL,
report_id       	VARCHAR(32) NOT NULL,
sheet_id        	VARCHAR(32) NOT NULL,
cell_id        	VARCHAR(10) NOT NULL,
cell_calc_ref     	VARCHAR(100) NOT NULL,
buy_currency        VARCHAR(3),
sell_currency       VARCHAR(3),
mtm_currency        VARCHAR(3),
qualifying_key 	BIGINT NOT NULL,
business_date       int(8) NOT NULL,
reporting_date      BIGINT NOT NULL,
buy_reporting_rate  float,
sell_reporting_rate float,
mtm_reporting_rate  float,
buy_usd_rate        float,
sell_usd_rate       float,
mtm_usd_rate        float
);


CREATE TABLE report_qualified_data_link (
	//id					bigint not null primary key auto_increment
    source_id           SMALLINT NOT NULL,
    report_id       	VARCHAR(32) NOT NULL,
    sheet_id        	VARCHAR(32) NOT NULL,
    cell_id        	VARCHAR(10) NOT NULL,
    cell_calc_ref     	VARCHAR(100) NOT NULL,
    buy_currency        VARCHAR(3),
    sell_currency       VARCHAR(3),
    mtm_currency        VARCHAR(3),
    qualifying_key 	BIGINT NOT NULL,
    business_date       int(8) NOT NULL,
    reporting_date      BIGINT NOT NULL,
    buy_reporting_rate  float,
    sell_reporting_rate float,
    mtm_reporting_rate  float,
    buy_usd_rate        float,
    sell_usd_rate       float,
    mtm_usd_rate        float,
    data_ver		int(8),
    data_ver_timestamp DATETIME
);

rename table report_summary_by_source to report_summary_by_source_20170619;

CREATE TABLE report_summary_by_source (
source_id      SMALLINT NOT NULL,
report_id      VARCHAR (32) NOT NULL,
sheet_id       VARCHAR (32) NOT NULL,
cell_id        VARCHAR (10) NOT NULL,
cell_calc_ref  VARCHAR(100) NOT NULL,
cell_summary   float,
reporting_date BIGINT NOT NULL
);

CREATE TABLE report_summary_by_source (
    source_id      SMALLINT NOT NULL,
    report_id      VARCHAR (32) NOT NULL,
    sheet_id       VARCHAR (32) NOT NULL,
    cell_id        VARCHAR (10) NOT NULL,
    cell_calc_ref  VARCHAR(100) NOT NULL,
    cell_summary   float,
    reporting_date BIGINT NOT NULL
);


rename table report_summary to report_summary_20170619;

CREATE TABLE report_summary (
report_id      VARCHAR (32) NOT NULL,
sheet_id       VARCHAR (32) NOT NULL,
cell_id        VARCHAR (10) NOT NULL,
cell_summary   float,
reporting_date BIGINT NOT NULL
);


CREATE TABLE report_summary (
    report_id      VARCHAR (32) NOT NULL,
    sheet_id       VARCHAR (32) NOT NULL,
    cell_id        VARCHAR (10) NOT NULL,
    cell_summary   float,
    reporting_date BIGINT NOT NULL
);

create table report_catalog(
	id						
    report_id           	bigint,
    reporting_date      	int(8),
    as_of_reporting_date    int(16),
    report_create_date  	int(8),
    report_create_timestamp int(25),
    report_parameters   	text,
    report_create_status 	varchar(255),
	//report_version TEXT,
	//report_version_timestamp DATETIME,
);

create table data_loading_catalog(
    id					BIGINT
	source_id           SMALLINT NOT NULL
    business_date       text,
    data_file_name      text,
    number_of_rows      text,
    file_load_status    text,
    header_row          text,
);


********************************************
LOG TABLE
********************************************

Here list partioning can be done over 'change_category_id' and 'operation_category_id' column if the int value is stored. 
Categories for data change are : business_rule_change, report_calc_def_change, etc.
Categories for operation change are : data_loading, business_rules_apply, report_calc_def_apply, running_report_aggregation

create table data_change_log (
	id					BIGINT,
	source_id			SMALLINT NOT NULL
	business_date		int(8),
	change_category_id	int(25), 
	field_name			varchar(255),
	old_val				varchar(1000),
	new_val				varchar(1000),
	change_type			varchar(255),
	date_of_change		int(8),
	maker				varchar(255), // user_id
	checker				varchar(255), // user_id
	checker_status		varchar(20),
	date_of_checking	int(8)
	
);

create table operational_log (
	id					BIGINT,
	source_id			SMALLINT NOT NULL,
	business_date		int(8),
	operation_category_id	int(25), 
	operation_type		varchar(255),
	date_of_operation	int(8),
	operation_status	varchar(25),
	operation_naration	varchar(2000)
	maker				varchar(255), // user_id foreign_Key
	checker				varchar(255), // user_id foreign_key
	checker_status		varchar(20),
	date_of_checking	int(8)	
	
);
***********LOG TABLE END****************


>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
USER ACCESS CONTROL TABLES
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
create table users(
	uid		BIGINT NOT NULL
	name	text
	
);

create table roles(
	id			bigint,
	role_name	text,
	
);

create table role_permission(
	id				bigint,
	role_id			bigint,
	permission		text,
		
);

create table users_roles(
	uid				BIGINT NOT NULL,
	rid				bigint,
	
);

9674759106 tk basu
ttirthabasu@gmail.com

