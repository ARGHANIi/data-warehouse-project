
# Data Warehouse Project

A complete end-to-end **Data Engineering** project that demonstrates how to design, build, automate, and deploy a SQL Server Data Warehouse using a layered Medallion Architecture and Python-based orchestration.

This project started as a traditional SQL Server Data Warehouse and gradually evolved into an automated, deployable Data Pipeline by integrating Python, Git, GitHub, GitHub Actions, and a Self-hosted Runner.

---

# Project Objectives

The primary goals of this project are:

* Design a production-style SQL Server Data Warehouse
* Implement an ETL pipeline using Stored Procedures
* Apply the Medallion Architecture (Bronze / Silver / Gold)
* Separate business logic from orchestration
* Automate ETL execution using Python
* Manage source code with Git and GitHub
* Execute the pipeline through GitHub Actions
* Deploy the workflow using a Self-hosted Runner

---

# Project Architecture

```
                 CSV Files
                     │
                     ▼
             SQL Server Database
                     │
                     ▼
                Bronze Layer
                     │
                     ▼
                Silver Layer
                     │
                     ▼
                 Gold Layer
                     │
                     ▼
            Stored Procedures
                     │
                     ▼
        Python Automation Layer
                     │
                     ▼
          GitHub Actions Workflow
                     │
                     ▼
          Self-hosted Runner
```

---

# Technology Stack

| Category           | Technology             |
| ------------------ | ---------------------- |
| Database           | SQL Server             |
| Language           | T-SQL                  |
| Automation         | Python                 |
| Database Driver    | pyodbc                 |
| Version Control    | Git                    |
| Repository Hosting | GitHub                 |
| CI/CD              | GitHub Actions         |
| Runner             | Self-hosted Runner     |
| Architecture       | Medallion Architecture |

---

# Repository Structure

```
data-warehouse-project/

│
├── datasets/
│
├── scripts/
│
├── automation/
│   ├── config.py
│   ├── run_pipeline.py
│   └── requirements.txt
│
├── .github/
│   └── workflows/
│       └── etl_pipeline.yml
│
├── docs/
│
├── README.md
│
└── .gitignore
```

---

# ETL Workflow

The ETL process follows a layered architecture:

```
Raw CSV Files

        │

        ▼

Bronze
(Raw Data)

        │

        ▼

Silver
(Cleaned & Transformed Data)

        │

        ▼

Gold
(Business-ready Data)
```

Business logic is implemented entirely inside SQL Server using Stored Procedures.

Python is responsible only for orchestration.

---

# Automation Flow

```
Read Configuration

        │

        ▼

Connect to SQL Server

        │

        ▼

Execute Bronze Procedure

        │

        ▼

Execute Silver Procedure

        │

        ▼

Commit Transaction

        │

        ▼

Generate Logs

        │

        ▼

Close Connection
```

---

# Key Design Principles

* Separation of Concerns
* Modular Architecture
* Repeatable Execution
* Version Controlled Development
* Automation without duplicating business logic
* Clean Repository Structure

---

# Features

* SQL Server Data Warehouse
* Medallion Architecture
* ETL using Stored Procedures
* Python Automation
* Git Version Control
* GitHub Repository
* GitHub Actions Workflow
* Self-hosted Runner
* Logging
* Structured Project Layout
* Professional Documentation

---

# How to Run

### 1. Clone the repository

```bash
git clone <repository-url>
```

### 2. Install Python dependencies

```bash
pip install -r automation/requirements.txt
```

### 3. Configure the database connection

Update the values inside:

```
automation/config.py
```

according to your SQL Server configuration.

### 4. Create the Data Warehouse

Execute the SQL scripts to:

* Create Database
* Create Schemas
* Create Tables
* Create Stored Procedures

### 5. Load raw datasets

Import CSV files into the Bronze layer.

### 6. Execute the pipeline

Run locally:

```bash
python automation/run_pipeline.py
```

or execute it from GitHub Actions.

---

# Future Improvements

* GitHub Secrets
* Environment Variables
* Scheduled Workflows
* REST API Integration
* Docker
* Apache Airflow
* Advanced Logging
* Error Handling
* Automated Testing
* Monitoring Dashboard
* Cloud Deployment (Azure / AWS)

---

# Learning Outcomes

This project demonstrates practical experience with:

* Data Warehouse Design
* ETL Development
* SQL Server
* Python Automation
* Software Architecture
* Git & GitHub
* CI/CD Concepts
* GitHub Actions
* Self-hosted Runner
* Deployment
* Data Engineering Best Practices

---

# Author

**Alireza**

Data Engineering Portfolio Project

---

If you find this project useful, feel free to fork it, explore the implementation, and use it as a learning resource for building production-style Data Engineering pipelines.
