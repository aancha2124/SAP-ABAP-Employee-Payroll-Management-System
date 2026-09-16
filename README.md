# Employee Payroll Management System

## Overview

The **Employee Payroll Management System** is a SAP ABAP-based reporting application designed to manage employee payroll information and generate a consolidated payroll report.

The project demonstrates core ABAP programming concepts such as Open SQL, internal tables, structures, selection screens, modularization, and ALV reporting. It is designed as a practical learning project for understanding how ABAP can be used to process business data within an SAP environment.

## Objectives

- Retrieve employee payroll records from an SAP database table.
- Allow users to filter employees using a selection screen.
- Calculate gross salary and net salary based on employee payroll components.
- Process retrieved data using ABAP internal tables.
- Present the final payroll information in a structured ALV report.

## Features

- Employee-wise payroll data retrieval
- Employee ID-based filtering
- Gross salary calculation
- Net salary calculation
- Structured data processing using internal tables
- ALV-based tabular reporting
- Modular program structure using `FORM` routines
- Basic handling for cases where no employee records are found

## Technology

- **Platform:** SAP
- **Programming Language:** ABAP
- **Database Access:** Open SQL
- **Reporting:** ALV Grid
- **Development Tools:** SAP GUI / ABAP Development Environment

## Data Model

The application uses a custom transparent table named `ZEMP_PAYROLL`.

| Field | Description |
|---|---|
| `EMP_ID` | Unique employee ID |
| `EMP_NAME` | Employee name |
| `DEPARTMENT` | Employee department |
| `BASIC_SALARY` | Monthly basic salary |
| `HRA` | House Rent Allowance |
| `BONUS` | Employee bonus |
| `DEDUCTION` | Payroll deductions |

### Payroll Calculation

**Gross Salary**

`Basic Salary + HRA + Bonus`

**Net Salary**

`Gross Salary - Deduction`

## Program Flow

```text
Selection Screen
       ↓
Retrieve Employee Records
       ↓
Process Internal Table
       ↓
Calculate Gross & Net Salary
       ↓
Build ALV Field Catalog
       ↓
Display Payroll Report
```

## ABAP Concepts Used

### Selection Screen
A selection screen allows the user to enter an employee ID or a range of employee IDs before executing the report.

### Structures and Work Areas
A custom ABAP structure represents the payroll record, while a work area is used to process individual records.

### Internal Tables
Retrieved employee records are stored in an internal table for further processing and calculations.

### Open SQL
Open SQL is used to retrieve employee information from the `ZEMP_PAYROLL` database table.

### Modularization
The program is divided into separate `FORM` routines for data retrieval, payroll calculation, field-catalog creation, and report display.

### ALV Reporting
The processed payroll data is displayed using an ALV Grid, providing a structured and readable report format.

## Repository Structure

```text
SAP-ABAP-Employee-Payroll-Management-System/
│
├── README.md
├── LICENSE
├── .gitignore
├── sample_data.csv
│
└── src/
    └── z_employee_payroll_report.abap
```

## Setup

The source code is intended to be executed in an SAP ABAP development environment.

Before running the program:

1. Create the transparent table `ZEMP_PAYROLL` in the ABAP Dictionary using **SE11**.
2. Create the fields described in the data model above.
3. Add sample employee records.
4. Create an executable ABAP report using **SE38** or **SE80**.
5. Copy the source code from `src/z_employee_payroll_report.abap`.
6. Activate and execute the program.
7. Enter an employee ID or range of IDs on the selection screen and execute the report.

## Sample Data

Sample employee records are provided in `sample_data.csv` for reference when preparing test data.

## Expected Result

The program generates a payroll report containing:

- Employee ID
- Employee Name
- Department
- Basic Salary
- HRA
- Bonus
- Gross Salary
- Deduction
- Net Salary

## Project Status

**Learning / Demonstration Project**

This repository contains the ABAP source code and project documentation for demonstrating core SAP ABAP concepts. It is intended to be executed and tested in an SAP ABAP development environment.

## Author

**Aanchal Bhargava**
