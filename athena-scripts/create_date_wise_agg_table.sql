CREATE EXTERNAL TABLE IF NOT EXISTS `green_taxi_data_aggregations`.`date_wise_aggregation` (
  `date` date,
  `number_of_trips` bigint,
  `average_trip_duration` double,
  `average_tip_amount` double,
  `total_revenue` double
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION 's3://taxi-data-bucket/processed_data/date-wise-aggregation/'
TBLPROPERTIES ('classification' = 'parquet');