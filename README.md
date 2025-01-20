# DBT (Data Build Tool) with PostgreSQL Project

This project demonstrates the use of DBT (Data Build Tool) with PostgreSQL to transform and model data. Below, you'll find a step-by-step guide to set up the project, install DBT, configure it to work with PostgreSQL, and run your models.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Install DBT](#install-dbt)
3. [Set Up PostgreSQL](#set-up-postgresql)
4. [Initialize a DBT Project](#initialize-a-dbt-project)
5. [Configure DBT for PostgreSQL](#configure-dbt-for-postgresql)
6. [Create and Run Models](#create-and-run-models)
7. [Run Tests](#run-tests)
8. [Generate Documentation](#generate-documentation)
9. [Additional Resources](#additional-resources)

---

## Prerequisites

Before you begin, ensure you have the following installed:

- Python 3.7 or higher
- PostgreSQL installed and running
- A PostgreSQL database with the necessary permissions
- `pip` (Python package manager)

---

## Install DBT

1. Install DBT Core using `pip`:

   ```bash
   pip install dbt-core
   ```

2. Install the PostgreSQL adapter for DBT:

   ```bash
   pip install dbt-postgres
   ```

3. Verify the installation:
   ```bash
   dbt --version
   ```
   This should display the installed version of DBT and the PostgreSQL adapter.

---

## Set Up PostgreSQL

1. Ensure PostgreSQL is running and accessible.
2. Create a database for your DBT project:
   ```sql
   CREATE DATABASE dbt_project;
   ```
3. Create a user with the necessary permissions:
   ```sql
   CREATE USER dbt_user WITH PASSWORD 'your_password';
   GRANT ALL PRIVILEGES ON DATABASE dbt_project TO dbt_user;
   ```

---

## Initialize a DBT Project

1. Navigate to the directory where you want to create your DBT project.
2. Initialize a new DBT project:

   ```bash
   dbt init dbt_postgres_project
   ```

   Replace `dbt_postgres_project` with your desired project name.

3. Follow the prompts to set up your project.

---

## Configure DBT for PostgreSQL

1. Navigate to your project directory:

   ```bash
   cd dbt_postgres
   ```

2. Open the `profiles.yml` file, located at `/profiles/mart/profiles.yml`.

3. Add a new profile for your PostgreSQL connection:

   ```yaml
   my_dbt_project:
     target: dev
     outputs:
       dev:
         type: postgres
         host: localhost
         port: 5432
         user: dbt_user
         password: your_password
         dbname: dbt_project
         schema: public
         threads: 4
   ```

4. Test the connection:
   ```bash
   dbt debug
   ```
   Ensure all checks pass.

---

## Create and Run Models

1. First run below to seed the data inside postgres:

   ```bash
   dbt seed --profiles-dir profiles/mart
   ```

2. Run the model:

   ```bash
   dbt run
   ```

   This will execute all models in the `models` directory.

3. To run a specific model:
   ```bash
   dbt run --select netflix.mart --profiles-dir profiles/mart
   ```
   

---

## Generate Documentation

1. Generate documentation for your project:

   ```bash
   dbt docs generate
   ```

2. Serve the documentation locally:
   ```bash
   dbt docs serve
   ```
   Open your browser and navigate to `http://localhost:8080` to view the documentation.

---

Happy modeling with DBT and PostgreSQL! 🚀
