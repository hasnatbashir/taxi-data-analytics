# TLC Trip Record Data Analytics

A complete end to end data analysis pipeline for TLC Trip Record Data on aws cloud.

This is a demo project to explore aws and spark.

## How to Import Data to S3

To create ec2 instance and bucket on aws for data extraction and execute download data script

```
cd infra-code
bash ../Scripts/copy-and-execute-script.sh <ssh-key-pem-file-path> <download-data-script-path>
```

## Example Chart on Apache Superset using Athena
![smooth-line-revenue-2023-10-14T20-49-41 364Z](https://github.com/hasnatbashir/taxi-data-analytics/assets/12150628/b45b9fd2-2ba7-439c-9e07-cb09876ae335)

