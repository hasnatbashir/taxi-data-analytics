import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
import pyspark.sql.functions as F
from awsglue.context import GlueContext
from awsglue.job import Job

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)

# Reading the data from S3
data = spark.read.format("parquet").load('s3://taxi-data-bucket/green_tripdata_*.parquet')
data.printSchema()

# Transformations
data = data.filter(F.year(F.col('lpep_pickup_datetime')) <= 2023)
data = data.withColumn('trip_duration', F.col('lpep_dropoff_datetime') - F.col('lpep_pickup_datetime')).withColumn('trip_duration', F.col('trip_duration').cast('long')/60)

# Aggregations
overall_data_aggregate_values = data.agg(
    F.count('*').alias('total_number_of_trips'),
    F.sum('total_amount').alias('total_revenue'),
    F.avg('trip_duration').alias('average_trip_length'),
    F.avg('tip_amount').alias('average_tip_amount')
)

# Date wise aggregation
date_wise_aggregate = data.groupby(
    F.to_date("lpep_pickup_datetime").alias('date')
).agg(
    F.count('*').alias('number_of_trips'), 
    F.avg('trip_duration').alias('average_trip_duration'), 
    F.avg('tip_amount').alias('average_tip_amount'), 
    F.sum('total_amount').alias('total_revenue')
).orderBy('date')

# Week wise aggregation
week_wise_aggregate = data.groupby(
    F.weekofyear("lpep_pickup_datetime").alias('week')
).agg(
    F.count('*').alias('number_of_trips'), 
    F.avg('trip_duration').alias('average_trip_duration'), 
    F.avg('tip_amount').alias('average_tip_amount'), 
    F.sum('total_amount').alias('total_revenue')
).orderBy('week')

# Year wise Aggregation
year_wise_aggregate = data.groupby(
    F.year("lpep_pickup_datetime").alias('year')
).agg(
    F.count('*').alias('number_of_trips'), 
    F.avg('trip_duration').alias('average_trip_duration'), 
    F.avg('tip_amount').alias('average_tip_amount'), 
    F.sum('total_amount').alias('total_revenue')
).orderBy('year')

# Day of week wise aggregation
day_of_week_wise_aggregate = data.groupby(
    F.date_format("lpep_pickup_datetime", "E").alias('day_of_week')
).agg(
    F.count('*').alias('number_of_trips'), 
    F.avg('trip_duration').alias('average_trip_duration'), 
    F.avg('tip_amount').alias('average_tip_amount'), 
    F.sum('total_amount').alias('total_revenue')
).orderBy('day_of_week')

# Write data to s3
overall_data_aggregate_values.write.mode('overwrite').parquet('s3://taxi-data-bucket/processed_data/overall-aggregation/')
date_wise_aggregate.write.mode('overwrite').parquet('s3://taxi-data-bucket/processed_data/date-wise-aggregation/')
week_wise_aggregate.write.mode('overwrite').parquet('s3://taxi-data-bucket/processed_data/week-wise-aggregation/')
year_wise_aggregate.write.mode('overwrite').parquet('s3://taxi-data-bucket/processed_data/year-wise-aggregation/')
day_of_week_wise_aggregate.write.mode('overwrite').parquet('s3://taxi-data-bucket/processed_data/day_of_week-wise-aggregation/')

job.commit()