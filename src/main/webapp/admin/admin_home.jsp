<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    // Session check
    if(session.getAttribute("adminUser") == null){
        response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
        return;
    }
    String username = (String) session.getAttribute("adminUser");

    // Database connection
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    int totalStudents = 0, totalFaculty = 0, totalDepartments = 0, totalFeedbacks = 0;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/university_feedback", "root", "Jvinay@2370");
        stmt = conn.createStatement();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE role='STUDENT'");
        if(rs.next()) totalStudents = rs.getInt(1);

        rs = stmt.executeQuery("SELECT COUNT(*) FROM users WHERE role='FACULTY'");
        if(rs.next()) totalFaculty = rs.getInt(1);

        rs = stmt.executeQuery("SELECT COUNT(*) FROM departments");
        if(rs.next()) totalDepartments = rs.getInt(1);

        rs = stmt.executeQuery("SELECT COUNT(*) FROM feedback_responses");
        if(rs.next()) totalFeedbacks = rs.getInt(1);
    } catch(Exception e){ e.printStackTrace(); }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | JNTU-GV</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }

        /* Top Navbar */
        .navbar { background-color: #004aad !important; }
        .navbar-brand, .nav-link { color: #fff !important; font-weight: 500; }
        .nav-link:hover { color: #cce6ff !important; }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 220px;
            background-color: #004aad;
            padding-top: 60px; /* space for navbar */
            color: #fff;
        }
        .sidebar a {
            display: block;
            color: #fff;
            padding: 12px 20px;
            text-decoration: none;
            font-weight: 500;
            margin: 4px 0;
        }
        .sidebar a:hover { background-color: #0552b2; }
        .sidebar .active { background-color: #003366; font-weight: bold; }

        /* Main Content */
        .main-content {
            margin-left: 220px;
            padding: 100px 20px 20px 20px; /* top padding clears fixed navbar */
        }

        /* Analytics Cards */
        .card-analytics { border-left: 5px solid #004aad; border-radius: 8px; }

        /* Table Wrapper */
        .table-wrapper {
            background: rgba(255,255,255,0.9);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        table.table thead { background-color: #004aad; color: #fff; }
    </style>
</head>
<body>

<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Admin Panel | JNTU-GV</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item"><span class="nav-link">Hello, <strong><%=username %></strong></span></li>
                <li class="nav-item"><a class="nav-link btn btn-outline-light ms-2" href="<%=request.getContextPath()%>/LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Sidebar -->
<div class="sidebar">
    <a href="admin_home.jsp" class="active">Dashboard</a>
    <a href="add_department.jsp">Add Department</a>
    <a href="add_course.jsp">Add Course</a>
    <a href="add_faculty.jsp">Add Faculty</a>
    <a href="view_feedback.jsp">View Feedback</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <h2>Welcome, <%= username %> 👋</h2>
    <p class="text-muted">Admin Dashboard</p>

    <!-- Analytics Cards -->
    <div class="row text-center mb-4">
        <div class="col-md-3 mb-3">
            <div class="card card-analytics shadow-sm p-3">
                <h5>Total Students</h5>
                <h2><%= totalStudents %></h2>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card card-analytics shadow-sm p-3">
                <h5>Total Faculty</h5>
                <h2><%= totalFaculty %></h2>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card card-analytics shadow-sm p-3">
                <h5>Total Departments</h5>
                <h2><%= totalDepartments %></h2>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card card-analytics shadow-sm p-3">
                <h5>Total Feedbacks</h5>
                <h2><%= totalFeedbacks %></h2>
            </div>
        </div>
    </div>

    <!-- Faculty Table -->
    <div class="row">
        <div class="col-12 table-wrapper">
            <h4 class="mb-3">Faculty List</h4>
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Full Name</th>
                        <th>Username</th>
                        <th>Department</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try{
                        rs = stmt.executeQuery("SELECT u.full_name, u.username, d.dept_name " +
                                               "FROM users u " +
                                               "JOIN faculty f ON u.user_id=f.user_id " +
                                               "JOIN departments d ON f.dept_id=d.dept_id " +
                                               "WHERE u.role='FACULTY'");
                        int i=1;
                        while(rs.next()){
                %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><%= rs.getString("full_name") %></td>
                        <td><%= rs.getString("username") %></td>
                        <td><%= rs.getString("dept_name") %></td>
                    </tr>
                <%
                        }
                    } catch(Exception e){ e.printStackTrace(); }
                %>
                </tbody>
            </table>
        </div>
    </div>

</div>
</body>
</html>
