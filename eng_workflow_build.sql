select
CAST(NULL AS string) as additional_properties,
argv,
(select as struct build_attrs.* replace (cast(build_attrs.cpu_percent as float64) as cpu_percent)) as build_attrs,
build_opts,
client_id,
command,
metadata.document_id,
cast(duration_ms as float64) as duration_ms,
exception,
array(select as struct u.* replace (cast(count as float64) as count) from unnest(file_types_changed) as u) as file_types_changed,
struct(
STRUCT( 
CAST(NULL AS string)AS city,
CAST(NULL AS string) AS country,
CAST(NULL AS string) AS db_version,
CAST(NULL AS string) AS subdivision1,
CAST(NULL AS string) AS subdivision2 ) AS geo,
STRUCT(
metadata.date AS date,
CAST(NULL AS STRING) AS dnt,
CAST(NULL AS STRING) AS x_debug_id,
CAST(NULL AS STRING) AS x_pingsender_version
) AS header,
CAST(NULL AS STRUCT<browser string, os string, version string>) AS user_agent ) AS metadata,
CAST(NULL AS string) normalized_app_name,
CAST(NULL AS string) normalized_channel,
CAST(NULL AS string) normalized_country_code,
CAST(NULL AS string) normalized_os,
CAST(NULL AS string) normalized_os_version,
CAST(NULL AS int64) sample_id,
TIMESTAMP_MICROS(DIV(metadata.timestamp, 1000)) AS submission_timestamp  ,
success,
(select as struct system.* replace (cast(system.logical_cores as float64) as logical_cores, cast(system.memory_gb as float64) as memory_gb, cast(system.physical_cores as float64) as physical_cores)) as system,
timestamp(time) as time
from `moz-fx-data-derived-datasets.telemetry.eng_workflow_build_parquet_v1`      
where submission_date_s3 < '2019-08-22'

