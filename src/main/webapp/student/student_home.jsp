<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    // Use the implicit 'session' object, no need to declare it
    if (session == null || session.getAttribute("studentUser") == null) {
        response.sendRedirect(request.getContextPath() + "/student/student_login.jsp");
        return;
    }
    String username = (String) session.getAttribute("studentUser");

    String msg = request.getParameter("msg");
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <style>
        body { font-family: Arial; background: #f0f2f5; text-align: center; padding: 50px; }
        a { display: inline-block; margin: 10px; padding: 10px 20px; background: #4CAF50; color: white; border-radius: 5px; text-decoration: none; }
        a:hover { background: #45a049; }
        .msg { color: green; font-weight: bold; margin-bottom: 20px; }
    </style>
</head>
<body>
    <h2>Welcome, <%= username %> 👋</h2>
    <p>Student Dashboard</p>

    <% if ("success".equals(msg)) { %>
        <p class="msg">Feedback submitted successfully! ✅</p>
    <% } %>

    <a href="<%=request.getContextPath()%>/student/submit_feedback.jsp">Submit Feedback</a>
    <a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
</body>
</html>
