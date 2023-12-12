[//]: # (generate TOC for the title with # and ##)


# Business Intelligence
### Definition
Is a set of techniques and tools for the acquisition and transformation of raw data into meaningful and useful information for business analysis purposes.<br>
The BI provides:
- historical
- current
- predictive

views of business operations, most often using data that has been gathered into a data warehouse or a data mart and occasionally working from operational data.<br>
![image](DDS_image/BI_lifecycle.png)
# Decision Supporting Systems
### Definition
Is a subset of BI that provides information aimed at assisting organizations in making decision based on data analysis.<br>
**DDS** are a part of the BI with **data warehouse** and **data mining**.<br>
DDS categories:
- **Model-driven DSS** - use data and parameters provided by users to assist decision makers in analyzing a situation, but they are not necessarily data-intensive.
- **Data-driven DSS** - use data and specialized analytical models and techniques to assist decision makers in analyzing a situation.
- **Knowledge-driven DSS** - use data and knowledge stored in a knowledge base to assist decision makers in analyzing a situation.
- **Document-driven DSS** - use textual, graphical, audio, and video documents to assist decision makers in analyzing a situation.
- **Communication-driven DSS** - use network, email, groupware, and other communication technologies to facilitate collaborative decision making.

DDS components:
- **Database** - a collection of data organized in a manner that allows access, retrieval, and use of that data.
- **Software system** - a set of programs that manages and controls the data and the interfaces between the data and the users.
- **User interface** - a mechanism through which users see the result.
---
# Data Warehouse
### Definition
- Is a relational database that is designed for query and analysis rather than for transaction processing.<br>
- It usually contains historical data from different source include those derived from the transactions.<br>
- The data warehouse is the core of the BI system which is built for data analysis and reporting.<br>
- Support few clients with complex queries.<br>

### Type of Components
- **ETL** - Extract, Transform, Load, is the process of copying data from one or more sources into a destination system which represents the data differently from the source(s) or in a different context than the source(s).
- **OLAP** - Online Analytical Processing, a category of software tools that provides analysis of data stored in a database.

### Characteristics
- **Subject Oriented** - data in the database is organized so that all the data elements relating to the same real-world event or object are linked together.
- **Integrated** - data warehouse is usually constructed by integrating multiple heterogeneous sources.
- **Time Variant** - all data in the data warehouse is identified with a particular time period.
- **Nonvolatile** - data in the data warehouse is never over-written or deleted, once committed, the data is static, read-only, but retained for future reporting.

### Purpose
- **Archival** - data warehouses are frequently used to archive older data that are not used in day-to-day operations.
- **Decision Support** - data warehouses contain large amount of historical data that is used for analysis and decision support purposes.
- **Data Consolidation and data quality** - data warehouses can be used to combine and filter data from multiple sources into a single database so that a single query engine can be used to present data.
- **High Performance** - data warehouses are designed to perform well for large number of simultaneous queries.

### Benefits
- **Faster query performance** - data warehouses are designed to perform well for large number of simultaneous queries.
- **Consistency** - data warehouses help in maintaining consistency in naming conventions, encoding structures, measurement of units, and so on.
- **Historical data** - data warehouses enable historical analysis in a way that operational systems cannot.
- **Completeness and Accuracy** - data warehouses can improve the accuracy of data.
- **Trends** - data warehouses can be used to study trends and patterns.
- **Easy querying and data access** - is more efficient and easier to access data from a single data warehouse than to access data from multiple operational systems.

### Data Warehouse vs Database

|                                         | Database                                                                                | Data Warehouse                                                                                                                                         |
|-----------------------------------------|-----------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| Utilizzo                                | Elaborazione transazionale online (OLTP)                                                | Elaborazione analitica in linea (OLAP)                                                                                                                 |
| Dati gestiti                            | Dati correnti                                                                           | Anche i dati storici                                                                                                                                   |
| Utenti                                  | Impiegati e clienti                                                                     | Manager e analisti                                                                                                                                     |
| Numero di utenti supportati             | Miglia/milioni di utenti contemporaneamente                                             | Pochi clienti contemporaneamente                                                                                                                       |
| Aggiornamento dei dati                  | Aggiornati di frequente                                                                 | Non volatili. Una volta inseriti i dati cambiano raramente                                                                                             |
| Frequenza di aggiornamento              | Aggiornamenti continui                                                                  | Aggiornamenti periodici                                                                                                                                |
| Normalizzazione delle tabelle           | Tabelle normalizzate                                                                    | Tabelle solo parzialmente normalizzate                                                                                                                 |
| Orientamento                            | Orientato al processo                                                                   | Orientato agli elementi del business                                                                                                                   |
| Dimensione                              | 100 MB-1GB                                                                              | 100 GB-1 TB                                                                                                                                            |
| Join                                    | Bisogna eseguire diversi join                                                           | Non è necessario eseguire join complessi                                                                                                               |
| Modello                                 | Modello Entità / Relazioni                                                              | Modello Dimensionale                                                                                                                                   |
| Ottimizzazione                          | Ottimizzato per operazioni in scrittura                                                 | Ottimizzato per operazioni in lettura                                                                                                                  |
| Prestazioni per operazioni di analisi   | Prestazioni basse                                                                       | Alte prestazioni                                                                                                                                       |
| Tipo di operazioni ottimizzate          | Ottimizzato per semplici transazioni; spesso l’aggiunta o la ricerca una singola riga   | Ottimizzato per accedere a molti dati, eseguendo anche ricerche non previste durante la creazione                                                      |
| Previsione delle operazioni             | Le operazioni possibili sono previste in fase di progettazione                          | L’interattività è una caratteristica irrinunciabile delle sessioni di analisi e fa sì che il carico di lavoro effettivo vari continuamente nel tempo   |

### Components
- **Data Sources** - data sources are the source systems where the data to be loaded into the data warehouse is stored.
- **Staging Area** - staging area is used to store the data extracted from the source systems before it is transformed and loaded into the data warehouse.
- **Warehouse** - data warehouse is the central repository of data which is built for data analysis and reporting.
- **Data Marts** - data marts are the smaller versions of data warehouses which are designed for a particular business line or functional area within an organization.
- **Users** - users are the people who use the data warehouse to analyze the data stored in it and make decisions based on the analysis.<br>
![image](DDS_image/DW_Components.png)

### Data Sources
- **Production data** - data from production systems such as ERP, CRM, SCM, and so on.
- **External data** - data from external sources such as market data, industry data, and so on.
- **Internal data** - data from internal sources such as sales data, marketing data, and so on.
- **Legacy data** - data from legacy systems such as mainframes, flat files, and so on.<br>
![image](DDS_image/DW_DataSources.png)

### Staging Area
- **Extract** - data is extracted from the source systems and copied to the staging area.
- **Transform** - data is transformed to match the data warehouse schema.
- **Load** - data is loaded into the data warehouse.<br>
![image](DDS_image/DW_StagingArea.png)

### Data Warehouse and Data Marts
- **Read-only** - data warehouse is read-only and does not support any online transaction processing.
- **Single or sectoral Archive** - data warehouse is a single or sectoral archive of the organization's data.
- **Metadata** - data warehouse contains metadata in addition to raw data.<br>
![image](DDS_image/DW_WarehouseDataMarts.png)

### Users
- **Analyses** - data warehouse is used by analysts to analyze the data stored in it.
- **Reports** - data warehouse is used by managers to generate reports based on the data stored in it.
- **Data Mining** - data warehouse is used by data mining experts to build data mining models based on the data stored in it.<br>
![image](DDS_image/DW_Users.png)
---

---

---
# Data Warehouse Architecture
![image](DDS_image/DW_Architecture.png)

### Architecture Properties
- **Separation** - between analytical processing and transaction processing to avoid interference and slowdowns.
- **Scalability** - to be able to handle the increase in data volume and user requirements updating hardware and software.
- **Extensibility** - to be able to integrate new operations and technologies without having to redesign the entire system.
- **Security** - to protect strategic data from possible unauthorized or malicious access.
- **Manageability** - to facilitate the management of the data warehouse

## Types of architecture

- ### Single-tier architecture
There are no intermediate levels, data is transferred directly from the sources to the data warehouse, which is virtual and not physical.<br>
This architecture reduces the amount of data stored, but does not separate analytical processing from transactional processing, and makes queries slower and heavier for operating systems.
#### **Charateristics**
- Reduce the amount of data stored
- Virtual Data Warehouse
- No separation between analytical processing and transaction processing
- Queries are slower and heavier for operating systems

![image](DDS_image/DW_SingleTier.png)

- ### Two-tier architecture
There are two intermediate levels, the data warehouse and the data marts.<br>
The data warehouse is a physical repository that contains all the data integrated from the sources, while the data marts are subsets of data specific to certain users or domains.<br>
This architecture separates analytical processing from transactional processing, but requires more storage space and can create consistency problems between data marts.

![image](DDS_image/DW_TwoTier.png)

- ### Three-tier architecture
There are three intermediate levels, the staging area, the data warehouse, and the data marts.<br>
The staging area is a temporary zone where data is cleaned, transformed, and integrated before being loaded into the data warehouse.<br>
The data warehouse and data marts are as in the 2-level architecture. This architecture improves the quality and reliability of data, but requires even more storage space and complexity.<br>

![image](DDS_image/DW_ThreeTier.png)

---

---

---
# Multi-dimensional Data Model
### Definition
The multidimensional model is part of the **OLAP** (On-Line Analytical Processing) process,<br>
which allows data to be analyzed from different perspectives and levels of detail.<br>
Is based on 2 main concepts:
- **Measures**
- **Dimensions**
### Representation
- The axes of the cube represent the **dimensions**
- The cells of the cube represent the **measures** and correspond to a fact
![image](DDS_image/MultiDimensionalModel.png)

---

---

---

# OLAP operation (On-Line Analytical Processing)
These are operations that allow data to be analyzed from various perspectives, using data cubes organized into dimensions and hierarchies.<br>
### Characteristics
- The records are organized in a multidimensional structure
- Each dimension include several levels of abstraction (hierarchy)
- Is possible see the data from different perspectives
- Operation on OLAP cubes are interactive

**Structure**<br>
![image](DDS_image/OLAP_Standard.png)
### Types of operations
**Drill-Up/Roll-Up**
- is the process of navigating from a lower level of data granularity to a higher level of data granularity. (Upscale hierarchy)<br>
![image](DDS_image/OLAP_DrillUp.png)

**Drill-Down/Roll-Down**
- is the process of navigating from a higher level of data granularity to a lower level of data granularity. (Downscale hierarchy)<br>
- Is a navigation from an aggregated record to a decomposed one.<br>
![image](DDS_image/OLAP_DrillDown.png)

**Slice**
- Is a subset of a cube, obtained by fixing the value of one or more dimensions.<br>
- Is a selection of a single value for one or more dimensions.<br>
![image](DDS_image/OLAP_Slice.png)

**Dice**
- Is the operation of selecting a sub-cube of a cube on one or more dimensions.<br>
![image](DDS_image/OLAP_Dice.png)

**Pivot**
- Is the operation of rotating the cube to view it from different perspectives.<br>
![image](DDS_image/OLAP_Pivot.png)

---

---

---

# Logic Modeling
### MOLAP (Multidimensional OLAP)
- The data are stored in a multidimensional structure, usually a cube, and are pre-aggregated.
### ROLAP (Relational OLAP)
- The data are stored in a relational database and are not pre-aggregated.
### HOLAP (Hybrid OLAP)
- The data are stored in a multidimensional structure, usually a cube, and are not pre-aggregated.

### Star Schema
A logical model that represents data in a fact table and in multiple dimension tables, connected via foreign keys.<br>
The fact table contains the measures of interest for the analysis, while the dimension tables contain the descriptive attributes of the analysis dimensions.<br>
The star schema is simple, intuitive, and fast in queries, but it may require a lot of redundancy and storage space.
![image](DDS_image/StarSchema.png)

### Snowflake Schema
A logical model that normalizes the dimension tables of the star schema, dividing them into multiple related tables.<br>
The snowflake schema reduces redundancy and storage space, but increases complexity and query time.
![image](DDS_image/SnowflakeSchema.png)

---

---

---

# CRISP-DM
### Definition
CRISP-DM stands for Cross Industry Standard Process for Data Mining.<br>
A process model with six phases that describes the data science life cycle.<br>
It is the most common methodology for data mining, analytics, and data science projects.

### Phases of CRISP-DM
- Business Understanding -> Understanding the business objectives and requirements.
- Data Understanding -> Collecting and exploring the data.
- Data Preparation -> Preparing the data for modeling.
- Modeling -> Selecting and applying the modeling techniques.
- Evaluation -> Evaluating the model.
- Deployment -> Deploying the model.

Each phase has several tasks and outputs that guide the project from start to finish.

### Agile vs Waterfall
- **Waterfall**

![image](DDS_image/CRISP_DM_Waterfall.gif)

- **Agile**

![image](DDS_image/CRISP_DM_Agile.gif)

---

---

---

# Kimball
### Definition
Is a methodological approach to the design and development of data warehouse and business intelligence (DW/BI) systems.<br>
The Kimball Lifecycle consists of 11 main activities that follow a sequential and iterative logic, involving both the technical and business aspects of the project.<br>

### Lifecycle Map
![image](DDS_image/Kimball_Lifecycle.png)

1. **Project Planning** The organization’s readiness is assessed, objectives are defined, economic return is justified, and personnel are acquired.
2. **Business Requirements Definition** Information on the activities, metrics, and data needed by system users is collected through facilitated sessions, questionnaires, interviews, and documentation.
3. **Technical Architecture Design** Technical requirements are defined, the architectural model is created, and the stages for implementing the architecture are determined based on business requirements and current standards.
4. **Product Selection and Installation** A matrix is created for evaluating products available on the market, suitable options are evaluated, a prototype is created if necessary, and the chosen product is selected and purchased.
5. **Dimensional Modeling** The dimensional model of the database is created, based on star or snowflake schemas, with dimensions around one or more fact tables. The business process is selected, granularity is defined, dimensions and facts are identified.
6. **Physical Design** Naming standards are defined, the physical model of the database, table indexes, and aggregations are determined.
7. **ETL System Design and Development** The systems that populate the DW data are defined, through extraction, transformation, and loading (ETL) processes.
8. **BI Applications Specification** Business intelligence (BI) applications are defined that allow users to access and analyze the DW data, through reports, dashboards, OLAP, data mining, etc. GUI standards are also defined.
9. **BI Applications Implementation** The specified BI applications are developed and tested, following naming conventions, GUI standards, and the database structure. System performance is also checked, and any ETL issues are resolved.
10. **Deployment** The system is released when the three main lines (technology, data, and BI applications) are completed. System users are also trained, and their feedback is monitored.
11. **Maintenance and Growth** Support, training, and technical support are provided to system users. Development requests are also managed, and necessary changes to the system are made.

---

---

---

# ETL subset
### Chapter 19: ETL Subsystem and Techniques (not required)

### Introduction

ETL (Extract, Transform, Load) is a fundamental process for building and maintaining a data warehouse. ETL is responsible for collecting data from operational sources, transforming it into a format suitable for the data warehouse, and loading it into the data warehouse.

### The ETL System

The ETL system is composed of three main components:

* **The ETL engine** is responsible for executing the extraction, transformation, and loading tasks.
* **The metadata repository** contains information about the data, sources, and destinations.
* **The ETL tool suite** provides a set of tools to automate ETL tasks.

### ETL Activities

ETL activities can be divided into three phases:

* **Extraction** involves retrieving data from operational sources.
* **Transformation** involves modifying data into a format suitable for the data warehouse.
* **Loading** involves transferring data into the data warehouse.

### ETL Techniques

There are a variety of ETL techniques that can be used to perform the extraction, transformation, and loading tasks.

#### Extraction

Extraction techniques can be divided into two categories:

* **Direct extraction** involves retrieving data directly from the operational sources.
* **Indirect extraction** involves retrieving data from another source, such as a data mart or an analytics system.

#### Transformation

Transformation techniques can be divided into two categories:

* **Logical transformation** involves modifying the data structure, such as changing data types or removing unnecessary columns.
* **Physical transformation** involves modifying the data content, such as replacing values or reconciling duplicate data.

#### Loading

Loading techniques can be divided into two categories:

* **Batch loading** involves loading data in a single batch.
* **Incremental loading** involves loading only the data that has changed since the last load.

---

---

---

# ETL Design
## ETL System Design and Development Process and Tasks

The ETL (Extract, Transform, Load) process is the core of any data warehouse implementation. It is responsible for extracting data from disparate source systems, transforming it into a format compatible with the data warehouse, and loading it into the data warehouse.

### ETL System Design and Development Process

The ETL system design and development process is a complex task that requires careful planning and execution. The process can be broken down into the following phases:

1. **Requirements gathering and analysis:**
    - Understand the business requirements for the ETL system.
    - Identify the source systems, data formats, and transformation rules.

2. **ETL system design:**
    - Design the architecture of the ETL system.
    - Determine the data flow, transformation logic, and load processes.

3. **ETL system development:**
    - Develop the ETL system code using appropriate tools and technologies.

4. **ETL system testing:**
    - Test the ETL system to ensure it meets the business requirements and data quality standards.

5. **ETL system deployment:**
    - Deploy the ETL system into production and integrate it with the data warehouse.

6. **ETL system monitoring and maintenance:**
    - Monitor the ETL system performance and data quality.
    - Implement error handling and logging mechanisms.
    - Continuously improve the ETL system based on feedback.

### Key Tasks in ETL System Design and Development

1. **Define the ETL process flow:**
    - Identify the source systems and data flow between them.
    - Define the transformation rules for data cleansing and formatting.

2. **Choose the appropriate ETL tools:**
    - Evaluate different ETL tools based on their features, ease of use, and cost.
    - Select the tool that aligns with the project's requirements and budget.

3. **Develop the ETL code:**
    - Write code to extract, transform, and load data from source systems to the data warehouse.
    - Ensure code modularity and reusability for maintainability and future enhancements.

4. **Design the data staging area:**
    - Create a temporary holding area for data before loading into the data warehouse.
    - Ensure adequate capacity to handle the volume of processed data.
    - Implement data consistency checks before loading.

5. **Implement error handling and logging:**
    - Implement robust error detection and handling mechanisms.
    - Capture detailed logs for troubleshooting and performance analysis.

6. **Design data quality checks:**
    - Integrate data quality checks into the ETL process to ensure data integrity.
    - Address discrepancies, missing values, and data inconsistencies.

7. **Develop the data dictionary:**
    - Create a comprehensive document describing the data elements in the data warehouse.
    - Define data relationships, attributes, and their meaning.

8. **Document the ETL process:**
    - Document the ETL process in detail, including process diagrams, code comments, and data dictionaries.
    - Facilitate understanding and maintenance of the ETL system for future users.

### ETL System Design and Development Best Practices

1. **Follow a structured methodology:**
    - Adhere to a defined methodology to ensure consistency and organization throughout the process.
    - Employ a standardized approach for project management, documentation, and testing.

2. **Use standardized tools and technologies:**
    - Standardize on common tools and technologies to simplify development, deployment, and maintenance.
    - Leverage open-source or industry-standard tools for compatibility and support.

3. **Automate the ETL process as much as possible:**
    - Automate repetitive tasks to reduce manual intervention and minimize errors.
    - Employ scripting and scheduling mechanisms for efficient data processing.

4. **Monitor the ETL system performance:**
    - Regularly monitor ETL system performance to identify and address bottlenecks.
    - Analyze metrics such as processing time, data volume, and error rates.

5. **Continuously improve the ETL system:**
    - Gather feedback from users and data analysts to refine the ETL system.
    - Implement improvements based on performance data and feedback.

By following these best practices, organizations can develop and maintain ETL systems that meet their business needs, ensure data quality, and support data-driven decision-making.

---

---

---


# Dimensional Modeling

## DM 1
## Chapter 1: Data Warehousing, Business Intelligence, and Dimensional Model Primer

## Overview of Data Warehousing

Data warehousing is a centralized repository of historical and current data that is integrated for analysis. It serves as a single source of truth for business intelligence (BI) purposes.

## Key Components of a Data Warehouse

1. **Data Mart:** A smaller, focused data warehouse that addresses a specific business unit or functional area.

2. **Data Warehouse Bus:** A logical structure that organizes data in a consistent and predictable way, ensuring data integrity and consistency across the organization.

3. **Dimensional Model:** A data modeling technique that organizes data into fact tables and dimension tables, enabling efficient data analysis and reporting.

## Kimball Method for Dimensional Modeling

A popular approach to developing data warehouses, emphasizing a star schema as the core data model and utilizing several techniques to efficiently manage and analyze data.

## Chapter 2: Kimball Dimensional Modelling Techniques Overview

## Core Techniques of Dimensional Modeling

1. **Star Schema:** A common dimensional modeling pattern that employs a central fact table surrounded by dimension tables, simplifying data access and analysis.

2. **Snowflake Schema:** A variation of the star schema that denormalizes dimension tables to improve performance, particularly for frequently queried data.

3. **Slowly Changing Dimensions:** A technique for tracking changes to dimension attributes over time, maintaining historical data integrity.

## Advanced Techniques for Dimensional Modeling

1. **Bridge Tables:** Used to connect related dimensions, facilitating data integrity and consistency.

2. **Degenerate Dimensions:** Employed for attributes that are part of the fact table, simplifying data organization.

3. **Virtual Dimensions:** Create views of dimension data, enabling flexible and dynamic analysis based on specific user needs.

By understanding the concepts and techniques presented in these two chapters, you will gain a solid foundation for learning more about data warehousing and dimensional modeling.

---

---

---
# DM 2
## Chapter 3: Retail Sales

## The Retail Sales Dimensional Model

This chapter introduces the retail sales dimensional model, a sample model used in many organizations. The model is designed to support a variety of analyses, including sales, customer analysis, product analysis, and sales channel analysis.

### The Retail Sales Dimensional Model

The retail sales dimensional model consists of two types of tables:

1. **Fact Tables:** Contain measurable data, such as sales, costs, and profits.

2. **Dimension Tables:** Contain contextual information, such as products, customers, and sales channels.

### Sales Fact Table

The sales fact table contains measurable data about retail sales. Its fields include:

1. **Date:** The date of the sale.

2. **Product:** The product sold.

3. **Quantity:** The quantity of product sold.

4. **Unit Price:** The unit price of the product sold.

5. **Total:** The total value of the sale.

### Dimension Tables

The retail sales dimensional model uses the following dimension tables:

1. **Product Dimension:** Contains information about products sold. Its fields include:
    * **Product ID:** The product identifier.

    * **Description:** The product description.

    * **Category:** The product category.

    * **Brand:** The product brand.

2. **Customer Dimension:** Contains information about customers who have made purchases. Its fields include:
    * **Customer ID:** The customer identifier.

    * **Customer Name:** The customer's name.

    * **Address:** The customer's address.

    * **Postal Code:** The customer's postal code.

3. **Sales Channel Dimension:** Contains information about sales channels used. Its fields include:
    * **Channel ID:** The channel identifier.

    * **Channel Description:** The channel description.

    * **Channel Type:** The type of channel (e.g., physical store, online store, etc.).

### Examples of Analysis

The retail sales dimensional model can be used to support a variety of analyses, including:

1. **Sales Analysis:** The model can be used to analyze sales for product, customer, sales channel, or other criteria.

2. **Customer Analysis:** The model can be used to analyze customer data, such as purchase history and demographic information.

3. **Product Analysis:** The model can be used to analyze product data, such as sales, profits, and customer reviews.

4. **Sales Channel Analysis:** The model can be used to analyze sales channel data, such as sales, costs, and customer engagement.

---

---

---

# DM 3
## Chapter 4: Inventory

## The Inventory Dimensional Model

This chapter introduces the inventory dimensional model, a sample model used in many organizations. The model is designed to support a variety of analyses, including inventory management, sales planning, and purchasing planning.

### The Inventory Dimensional Model

The inventory dimensional model consists of two types of tables:

1. **Fact Tables:** Contain measurable data, such as inventory quantities, inventory costs, and expiration dates.

2. **Dimension Tables:** Contain contextual information, such as products, warehouses, and suppliers.

### Inventory Fact Table

The inventory fact table contains measurable data about inventory. Its fields include:

1. **Date:** The date of the inventory.
2. **Product:** The product in inventory.
3. **Warehouse:** The warehouse where the inventory is located.
4. **Quantity:** The available quantity of inventory.
5. **Cost:** The unit cost of the inventory.
6. **Expiration Date:** The expiration date of the inventory.

### Dimension Tables

The inventory dimensional model uses the following dimension tables:

1. **Product Dimension:** Contains information about products in inventory. Its fields include:
    * **Product ID:** The product identifier.
    * **Description:** The product description.
    * **Category:** The product category.
    * **Brand:** The product brand.

2. **Warehouse Dimension:** Contains information about warehouses where the inventory is located. Its fields include:
    * **Warehouse ID:** The warehouse identifier.
    * **Warehouse Description:** The warehouse description.
    * **City:** The city where the warehouse is located.
    * **State:** The state where the warehouse is located.

3. **Supplier Dimension:** Contains information about suppliers from which inventory is purchased. Its fields include:
    * **Supplier ID:** The supplier identifier.
    * **Supplier Name:** The supplier name.
    * **Address:** The supplier address.
    * **Phone:** The supplier phone number.

### Examples of Analysis

The inventory dimensional model can be used to support a variety of analyses, including:

1. **Inventory Management:** The model can be used to track available inventory quantities, inventory costs, and expiration dates.
2. **Sales Planning:** The model can be used to plan sales based on available inventory quantities.
3. **Purchasing Planning:** The model can be used to plan purchases based on sales forecasts and available inventory quantities.

---

---

---

# DM 4
## Chapter 5: Procurement

## The Procurement Dimensional Model

This chapter introduces the procurement dimensional model, a sample model used in many organizations. The model is designed to support a variety of analyses, including procurement management, procurement planning, and supplier relationship management.

### The Procurement Dimensional Model

The procurement dimensional model consists of two types of tables:

1. **Fact Tables:** Contain measurable data, such as procurement costs, payment terms, and delivery dates.

2. **Dimension Tables:** Contain contextual information, such as products, suppliers, and contracts.

### Procurement Fact Table

The procurement fact table contains measurable data about procurements. Its fields include:

1. **Date:** The date of the procurement.
2. **Product:** The product procured.
3. **Supplier:** The supplier from whom the product was procured.
4. **Quantity:** The quantity of product procured.
5. **Cost:** The unit cost of the product procured.
6. **Payment Terms:** The payment terms agreed with the supplier.
7. **Delivery Date:** The delivery date agreed with the supplier.

### Dimension Tables

The procurement dimensional model uses the following dimension tables:

1. **Product Dimension:** Contains information about products procured. Its fields include:
    * **Product ID:** The product identifier.
    * **Description:** The product description.
    * **Category:** The product category.
    * **Brand:** The product brand.

2. **Supplier Dimension:** Contains information about suppliers from whom products are procured. Its fields include:
    * **Supplier ID:** The supplier identifier.
    * **Supplier Name:** The supplier name.
    * **Address:** The supplier address.
    * **Phone:** The supplier phone number.

3. **Contract Dimension:** Contains information about procurement contracts with suppliers. Its fields include:
    * **Contract ID:** The contract identifier.
    * **Start Date:** The start date of the contract.
    * **End Date:** The end date of the contract.
    * **Conditions:** The contract terms and conditions.

### Examples of Analysis

The procurement dimensional model can be used to support a variety of analyses, including:

1. **Procurement Management:** The model can be used to track procurement costs, payment terms, and delivery dates.
2. **Procurement Planning:** The model can be used to plan procurements based on sales forecasts and inventory levels.
3. **Supplier Relationship Management:** The model can be used to monitor supplier performance and identify opportunities for improvement.

---

---

---

# DM 5
## Chapter 6: Order Management

## The Order Management Dimensional Model

This chapter introduces the order management dimensional model, a sample model used in many organizations. The model is designed to support a variety of analyses, including sales analysis, customer relationship management, and sales forecasting.

### The Order Management Dimensional Model

The order management dimensional model consists of two types of tables:

1. **Fact Tables:** Contain measurable data, such as sales, shipping costs, and delivery dates.
2. **Dimension Tables:** Contain contextual information, such as products, customers, and sales channels.

### Order Fact Table

The order fact table contains measurable data about orders. Its fields include:

1. **Date:** The date of the order.
2. **Customer:** The customer who placed the order.
3. **Sales Channel:** The sales channel used to place the order.
4. **Product:** The product or products ordered.
5. **Quantity:** The quantity of product or products ordered.
6. **Unit Price:** The unit price of the product or products ordered.
7. **Total:** The total value of the order.
8. **Shipping Cost:** The shipping cost of the order.
9. **Delivery Date:** The expected delivery date of the order.

### Dimension Tables

The order management dimensional model uses the following dimension tables:

1. **Product Dimension:** Contains information about products ordered. Its fields include:
    * **Product ID:** The product identifier.
    * **Description:** The product description.
    * **Category:** The product category.
    * **Brand:** The product brand.

2. **Customer Dimension:** Contains information about customers who placed orders. Its fields include:
    * **ID Customer:** The customer identifier.
    * **Name Customer:** The customer name.
    * **Address:** The customer address.
    * **Postal Code:** The customer postal code.

3. **Sales Channel Dimension:** Contains information about sales channels used to place orders. Its fields include:
    * **ID Channel:** The sales channel identifier.
    * **Description Channel:** The sales channel description.
    * **Type Channel:** The type of channel (e.g., physical store, online store, etc.).

### Examples of Analysis

The order management dimensional model can be used to support a variety of analyses, including:

1. **Sales Analysis:** The model can be used to analyze sales by product, customer, sales channel, or other criteria.
2. **Customer Relationship Management:** The model can be used to monitor customer interactions with the company, such as orders, product reviews, and customer service interactions.
3. **Sales Forecasting:** The model can be used to forecast sales based on sales forecasts and market trends.

---

---

---

# Data Visualization
The website [https://datavizcatalogue.com/](https://datavizcatalogue.com/) presents a wide range of charts, divided into categories based on the type of data they represent and the type of analysis they support.

**Charts for quantitative data**

* **Line charts:** Line charts are used to represent the change in data over time or based on another factor.
* **Bar charts:** Bar charts are used to represent the distribution of data in categories.
* **Stacked bar charts:** Stacked bar charts are similar to bar charts, but they show the distribution of data in categories and their change over time or based on another factor.
* **Pie charts:** Pie charts are used to represent the distribution of data in percentages.
* **Area charts:** Area charts are similar to line charts, but they show the area under the curve.
* **Scatter plot:** Scatter charts are used to represent the relationship between two or more variables.
* **Box plot:** Box plots are used to represent the distribution of data based on a median value, two quartiles, and two extremes.
* **Heat map:** Heat maps are used to represent the distribution of data in a matrix.

**Charts for qualitative data**

* **Maps:** Maps are used to represent the distribution of data based on geographic location.
* **Pie chart:** Pie charts are similar to bar charts, but they are used to represent qualitative data.
* **Spider diagram:** Spider diagrams are used to represent the distribution of multiple variables based on a central value.
* **Flow diagrams:** Flow diagrams are used to represent the sequence of events or steps.
* **Gantt charts:** Gantt charts are used to represent the planning of activities or projects.

**Charts for combined data**

* **Line chart with bar:** Line charts with bar combine line and bar charts to represent the change in data over time and their distribution in categories.
* **Bar chart with percentage:** Bar charts with percentage combine bar and pie charts to represent the distribution of data in categories and their change in percentage.
* **Scatter plot with lines:** Scatter plots with lines combine scatter plots and line charts to represent the relationship between two or more variables and their change over time.

**Other chart types**

In addition to the charts listed above, there are also other types of charts, such as:

* **3D charts:** 3D charts are used to represent data in three dimensions.
* **Interactive charts:** Interactive charts allow users to interact with the data to view it differently.
* **Animated charts:** Animated charts allow users to view the change in data over time.

The choice of the type of chart to use depends on the type of data you want to represent and the analysis you want to perform. It is important to use the most appropriate chart to ensure that the data is displayed clearly and comprehensibly.

Here are some tips for choosing the right chart type:

* **Consider the type of data:** Charts for quantitative data are used to represent numerical data, while charts for qualitative data are used to represent non-numerical data.
* **Consider the analysis to perform:** Some charts are better suited for certain analyses, such as line charts for representing the change in data over time or scatter plots for representing the relationship between two or more variables.
* **Consider the audience:** The type of chart to use also depends on the audience to which the chart is intended. Some charts are easier to understand than others.


























