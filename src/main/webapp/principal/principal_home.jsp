<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, com.university.util.DBConnection" %>
<%
    if (session.getAttribute("principalUser") == null) {
        response.sendRedirect(request.getContextPath() + "/principal/principal_login.jsp");
        return;
    }
    String username = (String) session.getAttribute("principalUser");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Principal Dashboard</title>
    <style>
        body { font-family: Arial; background: #f0f2f5; text-align: center; padding: 50px; }
        .box { display: inline-block; margin: 20px; padding: 20px; background: white; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2); }
        a { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #4CAF50; color: white; border-radius: 5px; text-decoration: none; }
        a:hover { background: #45a049; }
    </style>
</head>
<body>
    <h2>Welcome, <%= username %> 👋</h2>
    <p>Principal Dashboard</p>

    <div class="box">
        <%
            try (Connection conn = DBConnection.getConnection()) {
                Statement stmt = conn.createStatement();

                // Total Departments
                ResultSet rsDept = stmt.executeQuery("SELECT COUNT(*) AS total FROM departments");
                rsDept.next();
                int totalDept = rsDept.getInt("total");

                // Total Courses
                ResultSet rsCourse = stmt.executeQuery("SELECT COUNT(*) AS total FROM courses");
                rsCourse.next();
                int totalCourse = rsCourse.getInt("total");

                // Total Feedbacks
                ResultSet rsFeed = stmt.executeQuery("SELECT COUNT(*) AS total FROM feedback_responses");
                rsFeed.next();
                int totalFeedback = rsFeed.getInt("total");
        %>
        <p>Total Departments: <%= totalDept %></p>
        <p>Total Courses: <%= totalCourse %></p>
        <p>Total Feedback Submitted: <%= totalFeedback %></p>
        <%
            } catch(Exception e) { out.println(e); }
        %>
    </div>

    <a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
</body>
</html>
