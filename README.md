
📘 **University Feedback Management System

The **University Feedback Management System** is a full-stack Java web application built using **JSP, Servlets, JDBC, and MySQL**, designed to streamline the process of collecting, managing, and analyzing feedback from students within a university environment.

This system supports multiple user roles such as **Admin, HOD, Faculty, Principal, and Students**, enabling each to interact with the platform according to their responsibilities.



## 🚀 **Key Features**

### **🔹 Student Module**

* Secure student login
* Submit feedback for courses, faculty, or departments
* View submission status
* Simple and responsive UI

### **🔹 Faculty Module**

* Faculty login
* View feedback submitted by students
* Analyze comments and ratings
* Access department-wise or course-wise feedback

### **🔹 Admin Module**

* Manage users: Add, update, delete faculty/student
* View all feedback reports
* Approve/verify feedback entries
* Manage courses, departments, and feedback questions

### **🔹 Principal & HOD**

* Access consolidated reports
* View faculty performance
* Monitor department-wise and semester-wise feedback results

---

## 🗂️ **Technology Stack**

### **Backend**

* Java (JDK 17+)
* Java Servlets
* JSP
* JDBC
* MySQL Database

### **Frontend**

* HTML5, CSS3
* JSP pages for dynamic views
* Basic Bootstrap for responsiveness

### **Server**

* Apache Tomcat 9.0

### **IDE**

* Eclipse IDE for Enterprise Java Developers

---

## 🏗️ **Project Architecture**

```
UniversityFeedbackSystem/
│
├── src/main/java/com.university.dao/     → DAO Classes (UserDAO, CourseDAO, DepartmentDAO…)
├── src/main/java/com.university.servlets/ → Controllers & Servlet Logic
├── src/main/webapp/
│     ├── admin/                           → Admin Dashboard, User Management
│     ├── faculty/                         → Faculty Home, View Feedback
│     ├── student/                         → Submit Feedback, Student Home
│     ├── principal/                       → Feedback Reports, Overview
│     └── WEB-INF/web.xml                  → Servlet Mappings
│
└── Database/feedback_db.sql               → Tables for Users, Courses, Feedback, Departments
```


## 📊 **Database Structure**

The system typically includes the following tables:

* `users` – login credentials & user roles
* `students` – student information
* `faculty` – faculty details
* `courses` – course info
* `departments` – department list
* `feedback` – feedback entries submitted by students
* `questions` – predefined feedback questions

---

## ⚙️ **How It Works**

1. **Student logs in** → selects course/faculty → submits feedback
2. **Feedback stored** in MySQL via JDBC DAO classes
3. **Faculty/Admin views reports** via Servlets
4. **Principal views consolidated performance reports**

DAO classes like `UserDAO`, `CourseDAO`, and `DepartmentDAO` fetch data using SQL queries such as:

```java
String sql = "SELECT user_id, full_name, email FROM users ORDER BY full_name ASC";
```


## 📌 **Use Case**

This project can be used for:

* Academic submissions
* University internal feedback systems
* Servlet/JSP learning projects
* Full-stack Java web development practice

---

## 📥 **How to Run**

1. Import the project into **Eclipse IDE**
2. Configure **Apache Tomcat 9**
3. Create MySQL database using the provided SQL file
4. Update DB credentials in `DBConnection.java`
5. Run the server and open in browser:

   ```
   http://localhost:8080/UniversityFeedbackSystem
   ```


Just tell me!
