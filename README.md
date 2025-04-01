Store Database Management System
A SQL database for managing a retail clothing store's operations, including inventory, employees, customers, and sales.
Description
This SQL script creates and populates a relational database for a retail clothing store management system. It provides a complete data model for tracking products, inventory, departments, employees, customers, orders, and promotions.
Database Schema
The database consists of the following tables:

Person: Core table containing personal information (used for both employees and customers)
Employee: Employee-specific information linked to Person table
Customer: Customer-specific information linked to Person table
Department: Main product departments (Men's, Women's)
Sub_department: Specific product categories within departments
Product: Detailed product information including pricing and inventory
Promotion: Sales promotions with percentage discounts
Order2: Customer order information
Employee_Order: Tracking employee involvement with orders
Order_Detail: Line items for each order

Features

Complete relational database model with foreign key constraints
Sample data for all tables
Support for inventory management by product size, color, and department
Customer order tracking
Employee management
Promotion tracking with date ranges

Installation

Execute this script on a Microsoft SQL Server instance
The script will:

Create a new database called "Store" (can be renamed if needed)
Create all necessary tables
Populate tables with sample data



Sample Data
The database comes pre-populated with:

Sample employees and customers
Complete product catalog with men's and women's clothing
Department structure
Sample orders and promotions

Usage
This database can be used for:

Retail inventory management
Sales analysis
Customer relationship management
Employee scheduling and management
Promotional campaign tracking

Technologies

Microsoft SQL Server
T-SQL

Notes
The database includes basic validation through constraints:

Primary and foreign key relationships
Unique constraints for employee SSNs
Check constraints for product sizes and date validations
