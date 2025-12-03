<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, com.university.util.DBConnection" %>
<%
    if (session.getAttribute("hodUser") == null) {
        response.sendRedirect(request.getContextPath() + "/hod/hod_login.jsp");
        return;
    }
    String username = (String) session.getAttribute("hodUser");
    int hodDeptId = (int) session.getAttribute("deptId");

    String deptName = "";
    try (Connection conn = DBConnection.getConnection()) {
        String sqlDept = "SELECT dept_name FROM departments WHERE dept_id = ?";
        PreparedStatement psDept = conn.prepareStatement(sqlDept);
        psDept.setInt(1, hodDeptId);
        ResultSet rsDept = psDept.executeQuery();
        if(rsDept.next()) {
            deptName = rsDept.getString("dept_name");
        }
    } catch(Exception e) {
        out.println(e);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HOD Dashboard</title>
    <style>
        body { font-family: Arial; background: #f0f2f5; text-align: center; padding: 50px; }
        table { margin: auto; border-collapse: collapse; width: 70%; }
        th, td { border: 1px solid #ccc; padding: 10px; }
        th { background: #4CAF50; color: white; }
        a { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #4CAF50; color: white; border-radius: 5px; text-decoration: none; }
        a:hover { background: #45a049; }
    </style>
</head>
<body>
    <h2>Welcome, <%= username %> 👋</h2>
    <h3>Department: <%= deptName %></h3>
    <p>HOD Dashboard</p>

    <h3>Department Feedback Summary</h3>
    <table>
        <tr>
            <th>Course</th>
            <th>Average Rating</th>
            <th>Total Feedback</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT c.course_name, AVG(fr.rating) as avg_rating, COUNT(fr.response_id) as total_feedback " +
                             "FROM courses c " +
                             "LEFT JOIN feedback_forms ff ON c.course_id = ff.form_id " +
                             "LEFT JOIN feedback_responses fr ON ff.form_id = fr.form_id " +
                             "WHERE c.dept_id = ? " +
                             "GROUP BY c.course_name";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, hodDeptId);
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("course_name") %></td>
            <td><%= rs.getDouble("avg_rating") %></td>
            <td><%= rs.getInt("total_feedback") %></td>
        </tr>
        <%
                }
            } catch(Exception e) { out.println(e); }
        %>
    </table>

    <a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
</body>
</html>
