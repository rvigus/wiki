-- setup an external table that reads basic csvs from S3
create or replace stage stage_basic_csv
URL='s3://sandbox-snowflake-datateam/engineering_sandbox/app/basic_csv/'
storage_integration = sandbox_snowflake_datateam_bucket
file_format = (TYPE = CSV, skip_header = 1);

select $1, $2, $3, $4, $5 from @stage_basic_csv;

create or replace external table external_table_basic_csv (
    event_date date as (value:c1::date),
    user_id int as (value:c2::int),
    action varchar(255) as (value:c3::varchar),
    duration int as (value:c4::int),
    location varchar(255) as (value:c5::varchar)
)
location=@stage_basic_csv
auto_refresh=false
file_format = (type = CSV, skip_header=1);

select * from external_table_basic_csv;


-- with partitions
CREATE OR REPLACE EXTERNAL TABLE external_table_with_partitions (
    -- bucket_name/prefix/prefix_2/filename.csv
    event_date date as to_date(split_part(metadata$filename, '/', 3), 'YYYY-MM-DD')
)
 PARTITION BY (event_date)
 LOCATION=@stage_basic_csv
 AUTO_REFRESH = false
 FILE_FORMAT = (TYPE = CSV, skip_header=1);

alter external table external_table_with_partitions refresh;