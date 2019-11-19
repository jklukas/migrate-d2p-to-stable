select
CAST(NULL AS string) as additional_properties,
application,
client_id,
creation_date,
id as document_id,
id,
struct(
  STRUCT( 
      CAST(NULL AS string) AS city,
      CAST(NULL AS string) AS country,
      CAST(NULL AS string) AS db_version,
      CAST(NULL AS string) AS subdivision1,
      CAST(NULL AS string) AS subdivision2 ) AS geo,
    STRUCT(
      CAST(NULL AS STRING) AS date,
      CAST(NULL AS STRING) AS dnt,
      CAST(NULL AS STRING) AS x_debug_id,
      CAST(NULL AS STRING) AS x_pingsender_version
    ) AS header,
    STRUCT( CAST(NULL AS STRING) AS app_build_id,
      CAST(NULL AS STRING) AS app_name,
      CAST(NULL AS STRING) AS app_update_channel,
      application.version  AS app_version ) AS uri,
    CAST(NULL AS STRUCT<browser string, os string, version string>) AS user_agent ) AS metadata,
application.name as normalized_app_name,
application.channel  normalized_channel,
CAST(NULL AS STRING) as normalized_country_code,
CAST(NULL AS STRING) normalized_os,
CAST(NULL AS STRING) normalized_os_version,
struct(payload.last_version, payload.last_build_id, payload.has_sync, cast(payload.button as FLOAT64) AS button ) as payload,
  udf_js.sample_id(client_id) AS sample_id,
cast(submission_date_s3 as timestamp)  submission_timestamp,
CAST(NULL AS STRING) type,
CAST(NULL AS FLOAT64) version
from `moz-fx-data-derived-datasets.telemetry_derived.telemetry_downgrade_parquet_v1`
where submission_date_s3 < '2018-10-30'

