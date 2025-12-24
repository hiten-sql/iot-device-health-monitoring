# SQL Industrial IoT Device Monitoring

## Overview
This project demonstrates the use of SQL to monitor industrial IoT device health,
identify non-pinging devices, and track subscription status for operational monitoring.

## Objectives
- Monitor last device communication time
- Identify inactive or non-pinging devices
- Track subscription status for active devices
- Support operational dashboards and reporting

## Data Scope
The queries work on relational datasets containing:
- Device master data
- Latest telemetry timestamps
- Subscription-related information

## SQL Techniques Used
- Common Table Expressions (CTEs)
- LEFT JOINs across multiple tables
- Conditional logic using CASE statements
- Time-based filtering and aggregations

## Use Cases
- Day-wise device health monitoring
- Exception detection for inactive devices
- Operational decision support

## Tools
- SQL
- PostgreSQL
- Metabase

## Note
This project is a generalized and anonymized representation of real-world
industrial IoT monitoring use cases. No proprietary or sensitive data is included.
