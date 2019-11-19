select
CAST(NULL AS string) as additional_properties,
arch,
client_id,
created,
CAST(NULL AS string) created_date,
null created_timestamp,
device,
metadata.document_id,
experiments,
locale,
struct(
  STRUCT( 
      NULLIF(metadata.geo_city, '??') AS city,
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
    STRUCT( metadata.app_build_id  AS app_build_id,
      metadata.app_name  AS app_name,
      metadata.app_update_channel  AS app_update_channel,
      CAST(NULL AS STRING)  AS app_version ) AS uri,
    CAST(NULL AS STRUCT<browser string, os string, version string>) AS user_agent ) AS metadata,
metadata.app_name  normalized_app_name,
metadata.app_update_channel  as normalized_channel,
NULLIF(metadata.geo_country, '??') normalized_country_code,
os normalized_os,
osversion normalized_os_version,
os,
osversion,
process_start_timestamp,
null profile_date,
  udf_js.sample_id(client_id) AS sample_id,
seq,
settings,
  TIMESTAMP_MICROS(DIV(metadata.timestamp, 1000)) AS submission_timestamp  ,
tz,
v,
ARRAY(SELECT as struct timestamp as f0_, category as f1_, method as f2_, object as f3_, value as f4_, extra as f5_ FROM unnest(events)) AS events
from `moz-fx-data-derived-datasets.telemetry.telemetry_mobile_event_parquet_v2`   
where submission_date_s3 < '2018-10-30'

