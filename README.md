# 🏥 Doctor Appointment System — Student Setup Guide

> **Project**: Doctor Appointment System  
> **Language**: Java (Jakarta EE / Servlet)  
> **Database**: MySQL 8  
> **Server**: Apache Tomcat 10.1  
> **GitHub**: https://github.com/Devopsplan/doctor.git  

---

## 📋 Table of Contents

1. [Project Overview](#1-project-overview)
2. [System Architecture](#2-system-architecture)
3. [Prerequisites](#3-prerequisites)
4. [Step 1 — Clone the Project](#step-1--clone-the-project)
5. [Step 2 — Set Up the Database](#step-2--set-up-the-database)
6. [Step 3 — Install Apache Tomcat](#step-3--install-apache-tomcat)
7. [Step 4 — Compile the Java Code](#step-4--compile-the-java-code)
8. [Step 5 — Deploy & Run](#step-5--deploy--run)
9. [Accessing the Application](#accessing-the-application)
10. [Project Structure Explained](#project-structure-explained)
11. [Database Schema](#database-schema)
12. [Common Errors & Fixes](#common-errors--fixes)
13. [Stopping the Server](#stopping-the-server)

---

## 1. Project Overview

The **Doctor Appointment System** is a web-based application that allows:
- 🔑 **Admin** — to manage doctors and view all appointments
- 👨‍⚕️ **Doctors** — to view and update appointment statuses
- 🧑 **Patients** — to register, login, search for doctors, and book appointments

The project uses:
- **Java Servlets** for backend logic
- **JSP (JavaServer Pages)** for UI rendering
- **MySQL** as the database
- **Apache Tomcat** as the web server

---

## 2. System Architecture

```
[ Browser ]
     |
     ▼
[ Apache Tomcat 10.1 ] ← Serves JSP pages & handles Servlet requests
     |
     ├── /admin/      → Admin JSP pages
     ├── /doctor/     → Doctor JSP pages
     ├── /patient/    → Patient JSP pages
     |
     ▼
[ Java Servlets ] ← Business logic (Login, Register, Book Appointment, etc.)
     |
     ▼
[ MySQL Database: doctor_appointment ]
     |
     ├── admin        → Admin credentials
     ├── doctor       → Doctor records
     ├── patient      → Patient records
     └── appointment  → Booking records
```

---

## 3. Prerequisites

Before starting, make sure the following software is installed:

| Software | Version | Check Command |
|----------|---------|---------------|
| **Java JDK** | 17 or above | `java -version` |
| **MySQL** | 8.0 or above | `mysql --version` |
| **Git** | Any | `git --version` |

> [!IMPORTANT]
> This project uses the `jakarta.*` namespace (Jakarta EE 9+), so you **must** use **Apache Tomcat 10** or above. Tomcat 9 and below will NOT work.

### Install Java (if not installed)
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-21-jdk -y

# Verify
java -version
```

### Install MySQL (if not installed)
```bash
# Ubuntu/Debian
sudo apt install mysql-server -y

# Start MySQL service
sudo systemctl start mysql

# Verify
mysql --version
```

---

## Step 1 — Clone the Project

Open a terminal and run:

```bash
# Clone the repository
git clone https://github.com/Devopsplan/doctor.git

# Navigate into the project directory
cd doctor
```

Your folder structure should look like this:
```
doctor/
├── src/
│   └── main/
│       ├── java/
│       │   ├── db/
│       │   │   └── DBConnection.java       ← Database connection
│       │   └── servlet/
│       │       ├── AdminLoginServlet.java
│       │       ├── AddDoctorServlet.java
│       │       ├── DoctorLoginServlet.java
│       │       ├── PatientLoginServlet.java
│       │       ├── PatientRegistrerServlet.java
│       │       ├── BookAppointmentServlet.java
│       │       ├── DeleteDoctorServlet.java
│       │       ├── UpdateAppointmentStatusServlet.java
│       │       └── LogoutServlet.java
│       └── webapp/
│           ├── index.jsp                   ← Home page
│           ├── error.jsp
│           ├── admin/                      ← Admin pages
│           ├── doctor/                     ← Doctor pages
│           ├── patient/                    ← Patient pages
│           ├── css/                        ← Stylesheets
│           └── WEB-INF/
│               ├── web.xml                 ← App configuration
│               └── lib/
│                   └── mysql-connector-j-9.5.0.jar  ← JDBC Driver
```

---

## Step 2 — Set Up the Database

### 2.1 — Log in to MySQL

```bash
mysql -u root -p
```
Enter your MySQL root password when prompted.

### 2.2 — Create the Database and Tables

Copy and paste the following SQL commands:

```sql
-- Create the database
CREATE DATABASE IF NOT EXISTS doctor_appointment;
USE doctor_appointment;

-- Admin table (stores admin login credentials)
CREATE TABLE IF NOT EXISTS admin (
    id       INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    password VARCHAR(50)
);

-- Doctor table
CREATE TABLE IF NOT EXISTS doctor (
    id             INT PRIMARY KEY AUTO_INCREMENT,
    name           VARCHAR(100),
    specialization VARCHAR(100),
    email          VARCHAR(100),
    password       VARCHAR(100)
);

-- Patient table
CREATE TABLE IF NOT EXISTS patient (
    id       INT PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(100),
    email    VARCHAR(100),
    password VARCHAR(50),
    phone    VARCHAR(15)
);

-- Appointment table (links patients to doctors)
CREATE TABLE IF NOT EXISTS appointment (
    id               INT PRIMARY KEY AUTO_INCREMENT,
    patient_id       INT,
    doctor_id        INT,
    appointment_date DATE,
    status           VARCHAR(20) DEFAULT 'pending',
    FOREIGN KEY (patient_id) REFERENCES patient(id),
    FOREIGN KEY (doctor_id)  REFERENCES doctor(id)
);

-- Insert a default admin account to log in
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');

-- Verify tables were created
SHOW TABLES;
```

### 2.3 — Verify

You should see:
```
+------------------------------+
| Tables_in_doctor_appointment |
+------------------------------+
| admin                        |
| appointment                  |
| doctor                       |
| patient                      |
+------------------------------+
```

Then exit MySQL:
```sql
EXIT;
```

### 2.4 — Check Your Database Credentials

Open the file `src/main/java/db/DBConnection.java`:

```java
con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/doctor_appointment",
    "root",      // ← MySQL username
    "root123"    // ← MySQL password
);
```

> [!WARNING]
> If your MySQL password is different from `root123`, update this file to match your actual password before compiling.

---

## Step 3 — Install Apache Tomcat

Download and set up Apache Tomcat 10.1 **inside your project folder**:

```bash
# Make sure you are inside the project folder
cd doctor

# Download Tomcat 10.1
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.54/bin/apache-tomcat-10.1.54.tar.gz

# Extract it
tar -xzf apache-tomcat-10.1.54.tar.gz

# Rename for convenience
mv apache-tomcat-10.1.54 tomcat

# Make scripts executable
chmod +x tomcat/bin/*.sh
```

> [!TIP]
> You can also download Tomcat 10.1 from the official site: https://tomcat.apache.org/download-10.cgi

---

## Step 4 — Compile the Java Code

Now we'll compile all Java source files using `javac`. Tomcat's `lib/` folder provides the Jakarta Servlet API, and `WEB-INF/lib/` has the MySQL driver.

```bash
# Create the output directory for compiled classes
mkdir -p src/main/webapp/WEB-INF/classes

# Compile all Java files
javac \
  -cp "tomcat/lib/*:src/main/webapp/WEB-INF/lib/*" \
  -d src/main/webapp/WEB-INF/classes \
  src/main/java/db/DBConnection.java \
  src/main/java/servlet/*.java

echo "Compilation successful!"
```

**What does this command do?**
- `-cp` → tells Java **where to find** libraries (Tomcat + MySQL driver)
- `-d` → tells Java **where to put** the compiled `.class` files
- `src/main/java/**/*.java` → specifies the Java files to compile

You should see: `Compilation successful!`

---

## Step 5 — Deploy & Run

### 5.1 — Deploy to Tomcat

Copy the web application into Tomcat's `webapps/ROOT` directory:

```bash
# Remove the default Tomcat ROOT app
rm -rf tomcat/webapps/ROOT

# Copy our project into ROOT
cp -r src/main/webapp tomcat/webapps/ROOT
```

### 5.2 — Start Tomcat

```bash
tomcat/bin/startup.sh
```

You should see:
```
Tomcat started.
```

### 5.3 — Verify It's Running

```bash
curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" http://localhost:9090/
```

Expected output: `HTTP Status: 200`

Or simply open your browser and go to: **http://localhost:9090**

---

## Accessing the Application

| Role | URL | Default Credentials |
|------|-----|---------------------|
| 🏠 **Home** | http://localhost:9090 | — |
| 🔑 **Admin Login** | http://localhost:9090/admin/login.jsp | `admin` / `admin123` |
| 👨‍⚕️ **Doctor Login** | http://localhost:9090/doctor/login.jsp | (Add via Admin) |
| 🧑 **Patient Register** | http://localhost:9090/patient/register.jsp | (Self-register) |
| 🧑 **Patient Login** | http://localhost:9090/patient/login.jsp | (After registering) |

### Typical User Flow:
```
1. Admin logs in
   └── Adds doctors to the system

2. Patient registers → Patient logs in
   └── Searches for a doctor by specialization
   └── Books an appointment (status: "pending")

3. Doctor logs in
   └── Views pending appointments
   └── Updates status (approved / rejected)

4. Patient logs in
   └── Checks status of their appointments
```

---

## Project Structure Explained

### Java Backend (`src/main/java/`)

| File | Purpose |
|------|---------|
| `db/DBConnection.java` | Creates and returns a MySQL database connection |
| `servlet/AdminLoginServlet.java` | Handles admin login, creates session |
| `servlet/AddDoctorServlet.java` | Adds a new doctor to the `doctor` table |
| `servlet/DeleteDoctorServlet.java` | Removes a doctor record |
| `servlet/DoctorLoginServlet.java` | Handles doctor login |
| `servlet/PatientRegistrerServlet.java` | Registers a new patient |
| `servlet/PatientLoginServlet.java` | Handles patient login |
| `servlet/BookAppointmentServlet.java` | Creates an appointment record |
| `servlet/UpdateAppointmentStatusServlet.java` | Updates appointment status |
| `servlet/LogoutServlet.java` | Invalidates the session and logs out |

### Frontend (`src/main/webapp/`)

| File/Folder | Purpose |
|-------------|---------|
| `index.jsp` | Landing/home page |
| `admin/login.jsp` | Admin login form |
| `admin/dashboard.jsp` | Admin control panel |
| `doctor/login.jsp` | Doctor login form |
| `doctor/dashboard.jsp` | Doctor dashboard |
| `patient/register.jsp` | Patient registration form |
| `patient/login.jsp` | Patient login form |
| `patient/dashboard.jsp` | Patient dashboard |
| `patient/search.jsp` | Search for doctors |
| `patient/myappointments.jsp` | View booked appointments |
| `WEB-INF/web.xml` | App configuration (context path, welcome file) |
| `WEB-INF/lib/` | External JAR libraries (MySQL JDBC driver) |

---

## Database Schema

```
┌─────────────────────────┐      ┌──────────────────────────────┐
│          admin          │      │           doctor             │
├─────────────────────────┤      ├──────────────────────────────┤
│ id       INT (PK, AI)   │      │ id             INT (PK, AI)  │
│ username VARCHAR(50)    │      │ name           VARCHAR(100)  │
│ password VARCHAR(50)    │      │ specialization VARCHAR(100)  │
└─────────────────────────┘      │ email          VARCHAR(100)  │
                                 │ password       VARCHAR(100)  │
                                 └────────────────┬─────────────┘
                                                  │ doctor_id (FK)
┌─────────────────────────┐      ┌────────────────▼─────────────┐
│         patient         │      │         appointment          │
├─────────────────────────┤      ├──────────────────────────────┤
│ id       INT (PK, AI)   │      │ id               INT (PK,AI) │
│ name     VARCHAR(100)   ◄──────┤ patient_id       INT (FK)    │
│ email    VARCHAR(100)   │      │ doctor_id        INT (FK)    │
│ password VARCHAR(50)    │      │ appointment_date DATE         │
│ phone    VARCHAR(15)    │      │ status           VARCHAR(20)  │
└─────────────────────────┘      └──────────────────────────────┘
```

---

## Common Errors & Fixes

### ❌ Error: `ClassNotFoundException: com.mysql.cj.jdbc.Driver`
**Cause**: MySQL JDBC driver JAR is missing from `WEB-INF/lib/`.  
**Fix**: Make sure `mysql-connector-j-9.5.0.jar` exists in `src/main/webapp/WEB-INF/lib/`.

---

### ❌ Error: `Communications link failure` (Database connection refused)
**Cause**: MySQL is not running or wrong credentials.  
**Fix**:
```bash
# Start MySQL
sudo systemctl start mysql

# Verify credentials in DBConnection.java match your MySQL password
```

---

### ❌ Error: `Address already in use` on port 8005 or 9090
**Cause**: Another Tomcat instance is already running.  
**Fix**:
```bash
# Kill all existing Tomcat processes
pkill -f catalina

# Then restart
tomcat/bin/startup.sh
```

---

### ❌ Error: `javac: command not found`
**Cause**: JDK (not just JRE) is not installed.  
**Fix**:
```bash
sudo apt install openjdk-21-jdk -y
```

---

### ❌ Blank page or 404 after login
**Cause**: The servlets were not compiled or the classes are in the wrong folder.  
**Fix**: Re-run the `javac` command, then re-deploy:
```bash
rm -rf tomcat/webapps/ROOT
cp -r src/main/webapp tomcat/webapps/ROOT
```
Then check Tomcat logs:
```bash
cat tomcat/logs/catalina.out | tail -50
```

---

## Stopping the Server

```bash
tomcat/bin/shutdown.sh
```

---

## Quick Reference (All Commands in One Place)

```bash
# 1. Clone
git clone https://github.com/Devopsplan/doctor.git && cd doctor

# 2. Set up database (run this SQL in MySQL)
mysql -u root -p < setup.sql    # Or paste the SQL manually

# 3. Download Tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.54/bin/apache-tomcat-10.1.54.tar.gz
tar -xzf apache-tomcat-10.1.54.tar.gz && mv apache-tomcat-10.1.54 tomcat
chmod +x tomcat/bin/*.sh

# 4. Compile
mkdir -p src/main/webapp/WEB-INF/classes
javac -cp "tomcat/lib/*:src/main/webapp/WEB-INF/lib/*" \
      -d src/main/webapp/WEB-INF/classes \
      src/main/java/db/DBConnection.java \
      src/main/java/servlet/*.java

# 5. Deploy
rm -rf tomcat/webapps/ROOT && cp -r src/main/webapp tomcat/webapps/ROOT

# 6. Start
tomcat/bin/startup.sh

# 7. Open browser
# http://localhost:9090
```

---

*Documentation prepared for educational purposes. Project source: https://github.com/Devopsplan/doctor*
