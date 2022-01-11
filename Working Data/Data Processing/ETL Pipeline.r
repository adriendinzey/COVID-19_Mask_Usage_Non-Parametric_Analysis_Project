#### Written by Adrien Dinzey
#### Extracts data from four .csv files stored in the working directory
#### Transforms and normalizes the data, then combines them into one table
#### Exports that data as "Project Data.csv" for further analysis
library(data.table)
library(tidyverse)

# Extract data

CENSUS_DATA <- fread("Working Data/Data Processing/co-est2019-alldata.csv",select=c(6,7,19))
COVID_DATA <- fread("Working Data/Data Processing/covidCasesByCounty.csv")
MASK_USAGE <- fread("Working Data/Data Processing/maskUsageByCounty.csv")
FIPS_CODES <- fread("Working Data/Data Processing/FIPS Codes.csv")


# Rename columns, clean/normalize data, then merge into one data frame using an inner join

names(FIPS_CODES)[2] <- "County"

names(CENSUS_DATA)[1] <- "State"
names(CENSUS_DATA)[2] <- "County"
names(CENSUS_DATA)[3] <- "Population"
# keep only the columns we are interested in
CENSUS_DATA <- CENSUS_DATA[ !(CENSUS_DATA$State==CENSUS_DATA$County) ]
# Remove extra rows when county name is the state name (these extra rows are just totals for all counties in that state)
for(i in CENSUS_DATA$State){
  CENSUS_DATA$State[which(CENSUS_DATA$State==i)]<-state.abb[match(i,state.name)]
}
# Replace the State name with State code for normalization

CENSUS_DATA[,2]<-str_replace_all(CENSUS_DATA$County, ' County', '')
# Removes the "Count" suffix from the county name to normalize the data between tables

MASK_USAGE$"Mask Usage" <- (MASK_USAGE$Never*0+MASK_USAGE$Rarely*1+MASK_USAGE$Sometimes*2+MASK_USAGE$Frequently*3+MASK_USAGE$Always*4)/4
# take weighted average so we get an accurate Mask Usage where 0 means no one ever uses masks and 1 means everyone always uses masks
MASK_USAGE <- subset(MASK_USAGE,select = c(1,7))
# chop up the data
MASK_USAGE[,1] <- sapply(MASK_USAGE[,1], as.numeric)

COVID_DATA <- subset(COVID_DATA, select= -c(1))


TRANSFORMED_DATA1 <- merge(FIPS_CODES,CENSUS_DATA,by=c("County","State"))
# We keep only rows that have a valid FIPS Code and have mask usage data, observations without both of these are useless to our analysis
TRANSFORMED_DATA2 <- merge(TRANSFORMED_DATA1,MASK_USAGE,by="FIPS Code")
TRANSFORMED_DATA3 <- merge(TRANSFORMED_DATA2,COVID_DATA,by=c("FIPS Code","County"))

# Finally we want to calculate proportion of infection and deaths per county, then we can drop the population column
# This normalizes the infections and deaths across the rows to account for difference in population between counties
TRANSFORMED_DATA3$'Confirmed Cases' <- TRANSFORMED_DATA3$'Confirmed Cases'/TRANSFORMED_DATA3$Population
TRANSFORMED_DATA3$Deaths <- TRANSFORMED_DATA3$Deaths / TRANSFORMED_DATA3$Population

TRANSFORMED_DATA3<- subset(TRANSFORMED_DATA3,select=c(-4))

# Rename the columns to appropraite names

names(TRANSFORMED_DATA3)[5] <- "Infection Proportion"
names(TRANSFORMED_DATA3)[6] <- "Death Proportion"
# Export the data to CSV

write.csv(TRANSFORMED_DATA3,"Working Data/Transformed Data.csv",row.names = FALSE)
quit()