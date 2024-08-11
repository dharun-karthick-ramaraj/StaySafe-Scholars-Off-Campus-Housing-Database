# StaySafe Scholars: Off-Campus Housing Database

## Project Overview

StaySafe Scholars is a database and visualization project designed to assist students in finding safe, affordable, and convenient off-campus housing. The system integrates housing data with critical factors like proximity to campus, safety ratings, and affordability, presented through a user-friendly interface. This project leverages MS SQL for backend database management and Power BI for data visualization, with a focus on ensuring data integrity and reliability.

## Background

Students face numerous challenges when searching for off-campus accommodations, including:
- **Affordability:** Finding rental properties that fit within a student budget.
- **Proximity:** Ensuring housing options are close to campus for easy accessibility.
- **Safety:** Identifying safer areas to live.
- **Lease Regulations:** Navigating complex lease agreements and rental insurance.
- **Feedback and Reviews:** Gathering insights from other students on housing quality.

## Objectives

The primary objective of the StaySafe Scholars project is to develop a reliable and secure platform that provides detailed information about off-campus housing options. The platform facilitates communication between students and property owners or brokers and includes the following goals:

- **Comprehensive Housing Listings:** Offer a database of verified housing listings, including various types of accommodations contributed by trustworthy homeowners and brokers.
- **Accurate Information on Nearby Amenities:** Utilize mapping services to provide information on the proximity of housing options to universities, essential services, and other necessities.
- **Verification and Trustworthiness:** Implement a robust verification process for real estate agents and property owners to ensure the authenticity of listings.
- **Customized Recommendations:** Provide personalized housing recommendations based on student preferences, budget, and academic institution.
- **Feedback System:** Enable a review and rating system for students to share their experiences, fostering transparency and accountability.

## Technologies Used

- **MS SQL:** Used for designing and managing the database, incorporating advanced SQL features like triggers, stored procedures, and functions.
- **Power BI:** Utilized for creating interactive dashboards that allow users to visualize and analyze housing options effectively.

## Key Features

- **Efficient SQL-based Housing Search:**
  - Developed a SQL database that stores comprehensive information on housing options, including rent, safety ratings, and distance from campus.
  - Improved search efficiency by 40% through optimized database queries and design.

- **Advanced Data Integrity and Automation:**
  - Implemented SQL triggers, procedures, and functions to automate data integrity checks and updates, ensuring the database remains up-to-date and accurate.

- **Power BI Visualizations:**
  - Created dynamic dashboards in Power BI to allow users to filter housing options by key criteria such as rent, safety, and proximity to campus, enabling informed decision-making.

## Project Structure

### Database Design
- **Tables:** 
  - **Housing Options Table:** Stores detailed information on available housing, including rent, address, safety ratings, and distance from campus.
  - **User Profiles Table:** Manages user preferences and search history for a personalized housing search experience.
  - **Transportation Entity:** Includes details on transportation options linking housing to universities.
  - **Review and Rating Entity:** Manages student feedback on housing, contributing to a transparent and trustworthy platform.

### SQL Features
- **Triggers:** Automatically update related records and enforce business rules, such as maintaining accurate availability status.
- **Stored Procedures:** Streamline complex queries and enhance performance, particularly for user-specific searches.
- **Functions:** Calculate dynamic fields like distance from campus and monthly cost per person.

### Power BI Dashboards
- **Housing Search Dashboard:** Provides a user-friendly interface to explore housing options, filter by criteria such as rent and safety, and visualize the results.
- **Proximity Analysis Dashboard:** Visualizes the proximity of housing options to the campus, aiding users in selecting the most convenient locations.

## How to Run the Project

1. **Set Up Environment:**
   - Install MS SQL Server and Power BI on your machine.
   
2. **Database Setup:**
   - Extract the contents of the StaySafeScholars.zip file.
   - Use the provided SQL scripts to create the necessary tables and load the sample housing data into the database.

3. **Implement SQL Features:**
   - Execute the SQL scripts included in the ZIP file to add triggers, stored procedures, and functions to the database.

4. **Power BI Visualization:**
   - Open the Power BI dashboard files and connect them to the MS SQL database to begin exploring and visualizing housing options.

## ER Diagram

The final ER Diagram for this project reflects the relationships and entities designed to facilitate efficient data management and retrieval:
- Transportation, Property Owned, Review and Rating, and Messaging System entities were added to refine and optimize the database structure.

![Final ER Diagram](Final ER Diagram.pdf)

## Conclusion

StaySafe Scholars provides a robust and user-friendly system for off-campus housing searches, integrating advanced SQL techniques with Power BI to significantly enhance the search experience for students. By automating data management and providing interactive visualizations, the project delivers a comprehensive solution for students seeking safe and convenient housing options.
