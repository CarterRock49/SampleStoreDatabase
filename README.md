# StoreDatabase

A retail clothing store database system built with Microsoft SQL Server.

## Overview

This database manages a clothing retail store's operations including inventory, customers, sales, and employees.

## SQL Server Details

- Built for Microsoft SQL Server
- Uses T-SQL syntax
- Includes `GO` statements for batch separation
- Uses SQL Server-specific data types

## Database Tables

| Table Name | Description |
|------------|-------------|
| Person | Contact information |
| Employee | Staff records |
| Customer | Customer information |
| Department | Main store sections |
| Sub_department | Product categories |
| Product | Inventory items |
| Promotion | Discount events |
| Order2 | Sales transactions |
| Employee_Order | Order processing assignments |
| Order_Detail | Items in each order |

## Setup

1. Open SQL Server Management Studio
2. Connect to your server
3. Execute the script to create database and tables
4. Sample data will be automatically loaded

## Sample Data

The script includes sample data for:
- **Customers**: 5 sample customer records
- **Employees**: 6 sample employee records
- **Products**: 336 clothing items with various sizes/colors
- **Departments**: Men's and Women's apparel sections
- **Orders**: 8 sample transactions with order details

## Example Query

```sql
-- Find all products in the Men's department
SELECT p.*
FROM Product p
JOIN Sub_department s ON p.SubDepartmentID = s.SubdepartmentID
JOIN Department d ON s.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'MENS'
