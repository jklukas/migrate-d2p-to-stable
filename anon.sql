select
CAST(NULL AS string) as additional_properties,
application,
creation_date,
metadata.document_id,
id,
  STRUCT( 
      STRUCT( NULLIF(metadata.geo_city, '??') AS city,
      NULLIF(metadata.geo_country, '??') AS country,
      CAST(NULL AS string) AS db_version,
      CAST(NULL AS string) AS subdivision1,
      CAST(NULL AS string) AS subdivision2 ) AS geo,
    STRUCT(
      metadata.date AS date,
      CAST(NULL AS STRING) AS dnt,
      CAST(NULL AS STRING) AS x_debug_id,
      CAST(NULL AS STRING) AS x_pingsender_version
    ) AS header,
    STRUCT( metadata.app_build_id AS app_build_id,
      metadata.app_name AS app_name,
      metadata.app_update_channel AS app_update_channel,
      application.version  AS app_version ) AS uri,
    CAST(NULL AS STRUCT<browser string, os string, version string>) AS user_agent ) AS metadata,
metadata.app_name  normalized_app_name,
metadata.normalized_channel  normalized_channel,
metadata.geo_country normalized_country_code,
CAST(NULL AS string) as normalized_os,
CAST(NULL AS string) as normalized_os_version,
payload,
null as sample_id,
  TIMESTAMP_MICROS(DIV(metadata.timestamp, 1000)) AS submission_timestamp  ,
type,
version
from `moz-fx-data-derived-datasets.telemetry_derived.telemetry_anonymous_parquet_v1`
where submission_date_s3 < '2018-10-30'

