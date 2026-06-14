# Airline Passenger Traffic Analysis (SQL)

## Overview

This project analyzes airline traffic data using SQL.

The dataset was transformed from a single metadata table into a normalized relational database consisting of airline, airport, flight, flight metrics, and city tables.

The analysis focuses on:

* Passenger traffic trends
* High-volume routes
* Airport performance
* Flight frequency analysis
* Population vs Air Traffic analysis

## Database Schema

Tables:

* Airline
* Airport
* Flight
* FlightMetrics
* City

## Business Questions & Insights

### 1. Which flight routes carry the highest passenger volume?

#### SQL Approach

Aggregated passenger counts by origin and destination airports using joins between Flight, FlightMetrics, and Airport tables.

#### Key Finding

The top 10 routes were identified based on total passenger volume.

Example:

* Route A → Route B: 2.4 million passengers
* Route C → Route D: 2.1 million passengers

#### Business Impact

Understanding the busiest routes helps airlines:

* Allocate aircraft capacity effectively
* Increase flight frequency on high-demand routes
* Prioritize operational resources
* Improve revenue planning

---

### 2. Which airports handle the highest passenger traffic?

#### SQL Approach

Calculated total passengers and total flights for each origin airport.

#### Key Finding

Major hub airports consistently generated the highest passenger volumes.

#### Business Impact

This analysis helps:

* Identify strategic hub airports
* Support infrastructure planning
* Optimize staffing and ground operations

---

### 3. What are the busiest flight corridors?

#### SQL Approach

Grouped flights by origin and destination airport pairs and counted total flights.

#### Key Finding

Certain airport pairs accounted for a disproportionately large number of flights.

#### Business Impact

Helps airlines:

* Evaluate route profitability
* Optimize scheduling
* Identify opportunities for additional service

---

### 4. How does passenger traffic vary over time?

#### SQL Approach

Aggregated passenger volume by year and month.

#### Key Finding

Passenger traffic showed seasonal fluctuations with identifiable peak and low-demand periods.

#### Business Impact

Supports:

* Demand forecasting
* Workforce planning
* Capacity management

---

### 5. Is there a relationship between city population and air traffic?

#### SQL Approach

Joined city population data with passenger traffic data and calculated passenger-to-population ratios.

#### Key Finding

Larger cities generally generated more passenger traffic, though some cities exhibited disproportionately high air travel activity relative to population.

#### Business Impact

Supports:

* Market expansion decisions
* Route planning
* Demand forecasting


## Skills Demonstrated

* SQL
* Joins
* Aggregations
* Business Analysis

## Author

Sanskar Prasad
Aspiring Data Analyst
