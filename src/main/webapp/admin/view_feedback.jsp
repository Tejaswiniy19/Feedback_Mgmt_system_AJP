<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.university.util.DBConnection" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
        return;
    }
    String username = (String) session.getAttribute("adminUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Feedback | JNTU-GV</title>
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
            padding-top: 60px; /* for navbar */
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
            padding: 100px 20px 20px 20px; /* top padding clears navbar */
        }

        /* Glassmorphism Table */
        .glass-table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        .glass-table th, .glass-table td {
            padding: 12px 15px;
            text-align: left;
        }
        .glass-table thead {
            background: rgba(0, 74, 173, 0.8);
            color: #fff;
            font-weight: 600;
        }
        .glass-table tbody tr {
            border-bottom: 1px solid rgba(255,255,255,0.1);
            transition: all 0.3s ease;
        }
        .glass-table tbody tr:hover {
            background: rgba(0, 74, 173, 0.1);
        }

        /* Back button */
        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 8px 12px;
            background: #4CAF50;
            color: #fff;
            border-radius: 5px;
            text-decoration: none;
        }
        .back-btn:hover { background: #45a049; }
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
    <a href="admin_home.jsp">Dashboard</a>
    <a href="add_department.jsp">Add Department</a>
    <a href="add_course.jsp">Add Course</a>
    <a href="add_faculty.jsp">Add Faculty</a>
    <a href="view_feedback.jsp" class="active">View Feedback</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <a class="back-btn" href="admin_home.jsp">Back to Dashboard</a>
    <h2 class="mb-4">All Feedback</h2>

    <table class="glass-table">
        <thead>
            <tr>
                <th>#</th>
                <th>Student</th>
                <th>Form</th>
                <th>Question</th>
                <th>Rating</th>
                <th>Comment</th>
                <th>Submitted At</th>
            </tr>
        </thead>
        <tbody>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT u.full_name AS student, f.title AS form_title, q.question_text, r.rating, r.comment, r.created_at "
                           + "FROM feedback_responses r "
                           + "JOIN users u ON r.user_id = u.user_id "
                           + "JOIN feedback_forms f ON r.form_id = f.form_id "
                           + "JOIN feedback_questions q ON r.question_id = q.question_id "
                           + "ORDER BY r.created_at DESC";
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                int i = 1;
                while (rs.next()) {
        %>
            <tr>
                <td><%= i++ %></td>
                <td><%= rs.getString("student") %></td>
                <td><%= rs.getString("form_title") %></td>
                <td><%= rs.getString("question_text") %></td>
                <td><%= rs.getObject("rating") != null ? rs.getInt("rating") : "-" %></td>
                <td><%= rs.getString("comment") != null ? rs.getString("comment") : "-" %></td>
                <td><%= rs.getTimestamp("created_at") %></td>
            </tr>
        <%
                }
            } catch(Exception e) { out.println(e); }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
