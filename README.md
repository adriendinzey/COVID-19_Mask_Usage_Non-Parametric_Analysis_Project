# COVID-19 Mask Usage Non-Parametric Analysis Project

[View Final Report](https://github.com/adriendinzey/COVID-19_Mask_Usage_Non-Parametric_Analysis_Project/blob/main/Documents/Final%20Report.pdf)

## About
A project uses Non-Parametric Statistical methods to determine what relationship, if any, mask usage has on COVID-19 Infection.

Data is loaded and cleaned, the data then undergoes a Mann-Whitney-Wilcoxon test and a Cox-Stuart test to determine if there exists a decreasing trend as mask usage increases on COVID-19 related infections and deaths. The data also undergoes Point-Biserial Correlation Analysis to determine the strength of this trend (if it exists). Data visualization techniques such as boxplots and scatterplots are generated using base-R and ggplot2 to further grasp the story of the data.

Uses an r script to process the data and an r markdown file to generate the results.

This project was created for the course STAT 3380 at the University of Manitoba.

## How to run
1. Clone the repository 
2. Run "Working Data/ETL Pipeline.r" to generate the cleaned and ready data
3. Open "Statistical Testing.rmd" in RStudio or similar
4. Knit to PDF to examine the results

An in-depth exploration of the project and results is located in "Documents/Final Report.pdf"


## Datasets Used:
- County Population Totals: 2010-2019
    - Published by the United States Census Bureau
    - (Link to data) https://www.census.gov/data/datasets/time-series/demo/popest/2010s-counties-total.html
- Covid-19 Data
    - Published and maintained by New York Times
    - (Link to data) https://github.com/nytimes/covid-19-data
