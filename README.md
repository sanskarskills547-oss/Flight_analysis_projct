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

The top 2 routes were identified based on total passenger volume.

Example:

* Route Atlanta → Route Orlando: 364 thousand passengers
* Route Newark → Route San Fransico: 363 thousand passengers

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
Data Analyst
## output
<img width="567" height="220" alt="Screenshot 2026-06-14 190343" src="https://github.com/user-attachments/assets/7d1777e0-e5cd-41a5-9c97-7ee342a5106f" />
<img width="222" height="63" alt="Screenshot 2026-06-14 192307" src="https://github.com/user-attachments/assets/40bf2d32-52a8-4931-9e68-077e19b4a0cd" />
<img width="537" height="216" alt="Screenshot 2026-06-14 192628" src="https://github.com/user-attachments/assets/7745a9ca-28d2-4bd6-9b51-0228f114b341" />
<img width="541" height="197" alt="image" src="https://github.com/user-attachments/assets/417b7031-7243-44b3-9251-2a26a7e1742b" />
<img width="555" height="261" alt="image" src="https://github.com/user-attachments/assets/44edac80-e5b4-46bf-a08d-88a12180ba55" />
<img width="301" height="195" alt="image" src="https://github.com/user-attachments/assets/7032474e-46d2-4db7-b8fa-87e334693401" />
<img width="301" height="230" alt="image" src="https://github.com/user-attachments/assets/50ee3393-c517-4503-8b3f-6a400fef4c4b" />
<img width="393" height="316" alt="image" src="https://github.com/user-attachments/assets/4447c732-b478-4d1a-ad20-00a05394cf8e" />



