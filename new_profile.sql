select
CAST(NULL AS string) as additional_properties,
cast(null as struct<architecture string>) as application,
client_id,
cast(null as string) creation_date,
cast(null as string) document_id,
(select as struct environment.* replace ((select as struct environment.profile.* replace (cast(environment.profile.creation_date as float64) as creation_date)) as profile)) as environment,
id,
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
    STRUCT( environment.build.build_id   AS app_build_id,
      environment.build.application_name   AS app_name,
      metadata.normalized_channel  AS app_update_channel,
      CAST(NULL AS STRING)  AS app_version ) AS uri,
    CAST(NULL AS STRUCT<browser string, os string, version string>) AS user_agent ) AS metadata,
environment.build.application_name  normalized_app_name,
metadata.normalized_channel  as normalized_channel,
NULLIF(metadata.geo_country, '??') normalized_country_code,
environment.system.os.name as normalized_os,
environment.system.os.version as normalized_os_version,
payload,
  udf_js.sample_id(client_id) AS sample_id,
  TIMESTAMP_MICROS(DIV(metadata.timestamp, 1000)) AS submission_timestamp  ,
CAST(NULL AS string) type,
CAST(NULL AS float64) version
from `moz-fx-data-derived-datasets.telemetry.telemetry_new_profile_parquet_v2`    
where submission < '2018-10-30'

