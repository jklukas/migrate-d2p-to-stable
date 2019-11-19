select
CAST(NULL AS string) as additional_properties,
created,
device,
metadata.document_id,
locale,
struct(
  STRUCT( 
      NULLIF(metadata.geo_city, '??') AS city,
      NULLIF(metadata.geo_country, '??') AS country,
      CAST(NULL AS string) AS db_version,
      CAST(NULL AS string) AS subdivision1,
      CAST(NULL AS string) AS subdivision2 ) AS geo,
    STRUCT(
      CAST(NULL AS STRING)  AS date,
      CAST(NULL AS STRING) AS dnt,
      CAST(NULL AS STRING) AS x_debug_id,
      CAST(NULL AS STRING) AS x_pingsender_version
    ) AS header,
    CAST(NULL AS STRUCT<browser string, os string, version string>) AS user_agent ) AS metadata,
CAST(NULL AS STRING)   normalized_app_name,
metadata.normalized_channel  as normalized_channel,
NULLIF(metadata.geo_country, '??') normalized_country_code,
CAST(NULL AS STRING)  normalized_os,
osversion normalized_os_version,
CAST(NULL AS STRING) os,
osversion,
pocket_id,
process_start_timestamp,
null sample_id,
seq,
  TIMESTAMP_MICROS(DIV(metadata.timestamp, 1000)) AS submission_timestamp  ,
v,
ARRAY(SELECT as struct element.timestamp as f0_, element.category as f1_, element.method as f2_, element.object as f3_, element.value as f4_, element.extra.key_value as f5_ FROM unnest(events.list)) AS events
from `moz-fx-data-derived-datasets.backfill.pocket_fire_tv_events_parquet_v1`         
where submission_date_s3 < '2019-08-22'

