#!/bin/bash

# Define the base URL for the data sources
BASE_URL="https://d37ci6vzurychx.cloudfront.net/trip-data"
TYPES=("yellow" "green" "fhv" "fhvhv")

# Define the S3 bucket name where the data should be uploaded
S3_BUCKET="taxi-data-bucket"

# Create a local directory to temporarily hold the data
mkdir -p data

# Loop over years from 2023 to 2009
for year in $(seq 2023 -1 2009); do

    # If year is 2023, only go up to June
    if [ $year -eq 2023 ]; then
        END_MONTH=6
    else
        END_MONTH=12
    fi

    # Loop over months
    for month in $(seq -w 1 $END_MONTH); do
        for type in "${TYPES[@]}"; do
            # Construct the URL and download the file to the "data" folder
            FILE_URL="${BASE_URL}/${type}_tripdata_${year}-${month}.parquet"
            wget -P data/ "$FILE_URL"
            
            # Upload the file to S3
            aws s3 cp "data/${type}_tripdata_${year}-${month}.parquet" "s3://${S3_BUCKET}/${type}_tripdata_${year}-${month}.parquet"
            
            # Optionally, you can remove the file from local storage after uploading to S3
            rm "data/${type}_tripdata_${year}-${month}.parquet"
        done
    done
    
    # For the starting year 2009, break after January
    if [ $year -eq 2009 ]; then
        break
    fi

done

echo "All downloads and uploads are complete."
