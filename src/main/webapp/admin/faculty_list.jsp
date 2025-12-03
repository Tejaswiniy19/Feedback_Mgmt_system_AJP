<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Faculty Management</title>
    <style>
        body { font-family: Arial; margin: 30px; background: #f9f9f9; }
        h2 { color: #333; margin-bottom: 20px; }
        table { width: 90%; border-collapse: collapse; background: #fff; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background: #007bff; color: white; }
        tr:nth-child(even) { background: #f2f2f2; }
        .actions a {
            text-decoration: none; padding: 6px 10px; border-radius: 4px; color: white;
        }
        .edit { background: #28a745; }
        .delete { background: #dc3545; }
        .add-btn {
            background: #007bff; color: white; padding: 8px 12px;
            border-radius: 4px; text-decoration: none; margin-bottom: 15px; display: inline-block;
        }
    </style>
</head>
<body>
<h2>Faculty Management</h2>
<a href="add_faculty.jsp" class="add-btn">+ Add Faculty</a>

<%
    List<Map<String, Object>> facultyList = (List<Map<String, Object>>) request.getAttribute("facultyList");
    if (facultyList == null || facultyList.isEmpty()) {
%>
        <p><b>No faculty records found.</b></p>
<%
    } else {
%>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Username</th>
                <th>Department</th>
                <th>Actions</th>
            </tr>
<%
        for (Map<String, Object> row : facultyList) {
%>
            <tr>
                <td><%= row.get("facultyId") %></td>
                <td><%= row.get("facultyName") %></td>
                <td><%= row.get("username") %></td>
                <td><%= row.get("deptName") %></td>
                <td>
                    <a href="edit_faculty.jsp?id=<%= row.get("facultyId") %>" class="edit">Edit</a>
                    <a href="DeleteFacultyServlet?id=<%= row.get("facultyId") %>" class="delete"
                       onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
<%
        }
%>
        </table>
<%
    }
%>

</body>
</html>
