SELECT date,county_fips_code,county,confirmed_cases,deaths 
FROM `bigquery-public-data.covid19_nyt.us_counties` 
WHERE  county_fips_code is not null and date="2021-12-19" 
ORDER BY county_fips_code
--- Queried from this public Google BigQuery Dataset published by New York Times
--- https://github.com/nytimes/covid-19-data
--- Link to Google BigQuery market listing:
--- https://console.cloud.google.com/marketplace/product/the-new-york-times/covid19_us_cases
--- This query was performed on the Google Cloud Platform and exported to my local repository as a .csv file.