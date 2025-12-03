<%@ page import="java.sql.*" %>
<%@ page import="com.university.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Database Connection Test</title>
    <style>
        body { font-family: Arial; margin: 50px; background-color: #f5f5f5; text-align: center; }
        h2 { color: #333; }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
        pre { background: #eee; padding: 10px; border-radius: 5px; width: 60%; margin: auto; text-align: left; }
    </style>
</head>
<body>

<%
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
        if (conn != null) {
%>
        <h2 class="success">✅ Database Connection Successful!</h2>
<%
        } else {
%>
        <h2 class="error">❌ Database Connection Failed!</h2>
<%
        }
    } catch (Exception e) {
%>
        <h2 class="error">❌ Error Occurred!</h2>
        <pre><%= e.getMessage() %></pre>
<%
        e.printStackTrace();
    } finally {
        if (conn != null) conn.close();
    }
%>

</body>
</html>
