#!/bin/bash

BASE_URL="https://d37ci6vzurychx.cloudfront.net/trip-data"
TYPES=("yellow" "green" "fhv" "fhvhv")

# Create the data directory if it doesn't exist
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
            # Construct the URL and download the file to the data folder
            FILE_URL="${BASE_URL}/${type}_tripdata_${year}-${month}.parquet"
            echo "Downloading $FILE_URL"
            wget -P data/ "$FILE_URL"
        done
    done

    # For the start year 2009, break after January
    if [ $year -eq 2009 ]; then
        break
    fi

done

echo "All downloads complete."
