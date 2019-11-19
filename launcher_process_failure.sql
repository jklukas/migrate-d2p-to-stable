select
CAST(NULL AS string) as additional_properties,
build_id,
build_version,
cpu_arch,
creation_date,
id as document_id,
id,
launcher_error,
memory,
struct(
  STRUCT( 
      CAST(NULL AS string) AS city,
      CAST(NULL AS string) AS country,
      CAST(NULL AS string) AS db_version,
      CAST(NULL AS string) AS subdivision1,
      CAST(NULL AS string) AS subdivision2 ) AS geo,
    STRUCT(
      CAST(NULL AS string) AS date,
      CAST(NULL AS STRING) AS dnt,
      CAST(NULL AS STRING) AS x_debug_id,
      CAST(NULL AS STRING) AS x_pingsender_version
    ) AS header,
    CAST(NULL AS STRUCT<browser string, os string, version string>) AS user_agent ) AS metadata,
CAST(NULL AS string) normalized_app_name,
update_channel  normalized_channel,
CAST(NULL AS string) normalized_country_code,
CAST(NULL AS string) normalized_os,
os_version  normalized_os_version,
num_logical_cpus,
os_locale,
os_version,
CAST(NULL AS int64) sample_id,
security,
server_os,
signatures,
timestamp(creation_date ) submission_timestamp,
type,
update_channel,
version,
xpcom_abi,
CAST(NULL AS boolean) is_admin_without_uac,
modules
from `moz-fx-data-derived-datasets.backfill.firefox_launcher_process_launcher_process_failure_parquet_v1`        
where submission_date_s3 < '2019-08-22'

