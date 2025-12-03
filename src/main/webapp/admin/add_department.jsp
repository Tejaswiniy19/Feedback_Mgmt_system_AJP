<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.university.dao.DepartmentDAO, com.university.model.Department" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
        return;
    }
    String username = (String) session.getAttribute("adminUser");

    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");
    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");

    DepartmentDAO deptDao = new DepartmentDAO();
    List<Department> deptList = deptDao.getAllDepartments();

    String editDeptId = request.getParameter("edit_id");
    Department editDept = null;
    if (editDeptId != null) {
        editDept = deptDao.getDepartmentById(Integer.parseInt(editDeptId));
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Department Management | JNTU-GV</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
/* Same styling as course page */
body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }
.navbar { background-color: #004aad !important; }
.navbar-brand, .nav-link { color: #fff !important; font-weight: 500; }
.sidebar { position: fixed; top: 0; left: 0; height: 100vh; width: 220px; background-color: #004aad; padding-top: 60px; color: #fff; }
.sidebar a { display: block; color: #fff; padding: 12px 20px; text-decoration: none; font-weight: 500; }
.sidebar a:hover { background-color: #0552b2; }
.sidebar a.active { background-color: #003366; font-weight: bold; }
.main-content { margin-left: 220px; padding: 80px 20px 20px 20px; }
.form-box { background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 0 15px rgba(0,0,0,0.1); max-width: 600px; margin: auto; }
.form-box input, .form-box button { width: 100%; padding: 10px; margin: 10px 0; }
.form-box button { background: #4CAF50; color: #fff; border: none; border-radius: 5px; cursor: pointer; }
.form-box button:hover { background: #45a049; }
.success { color: green; }
.error { color: red; }
.glass-table { width: 100%; border-collapse: collapse; background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(10px); border-radius: 15px; overflow: hidden; box-shadow: 0 8px 32px rgba(0,0,0,0.1); margin-top: 30px; }
.glass-table th, .glass-table td { padding: 12px 15px; text-align: left; }
.glass-table thead { background: rgba(0,74,173,0.8); color: #fff; font-weight: 600; }
.glass-table tbody tr { border-bottom: 1px solid rgba(255,255,255,0.1); transition: all 0.3s ease; }
.glass-table tbody tr:hover { background: rgba(0,74,173,0.1); }
</style>
</head>
<body>

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

<div class="sidebar">
    <a href="admin_home.jsp">Dashboard</a>
    <a href="add_department.jsp" class="active">Add Department</a>
    <a href="add_course.jsp">Add Course</a>
    <a href="add_faculty.jsp">Add Faculty</a>
    <a href="view_feedback.jsp">View Feedback</a>
</div>

<div class="main-content">

    <div class="form-box">
        <h2 class="mb-3"><%= (editDept != null) ? "Edit Department" : "Add Department" %></h2>
        <form action="<%=request.getContextPath()%>/<%= (editDept != null) ? "EditDepartmentServlet" : "AddDepartmentServlet" %>" method="post">
            <% if (editDept != null) { %>
                <input type="hidden" name="dept_id" value="<%=editDept.getDeptId()%>">
            <% } %>
            <input type="text" name="dept_name" placeholder="Department Name" value="<%= (editDept != null) ? editDept.getDeptName() : "" %>" required>
            <button type="submit"><%= (editDept != null) ? "Update Department" : "Add Department" %></button>
            <% if (editDept != null) { %>
                <a href="add_department.jsp" class="btn btn-secondary">Cancel</a>
            <% } %>
        </form>
        <% if(successMessage != null) { %> <p class="success"><%=successMessage%></p> <% } %>
        <% if(errorMessage != null) { %> <p class="error"><%=errorMessage%></p> <% } %>
    </div>

    <h3 class="mt-5 mb-3 text-center">Existing Departments</h3>
    <table class="glass-table">
        <thead>
            <tr><th>#</th><th>Department Name</th><th>Actions</th></tr>
        </thead>
        <tbody>
            <%
                int i=1;
                for(Department d : deptList){
                    String deptName = (d != null) ? d.getDeptName() : "N/A";
            %>
            <tr>
                <td><%=i++ %></td>
                <td><%=deptName %></td>
                <td>
                    <a href="add_department.jsp?edit_id=<%=d.getDeptId()%>" class="btn btn-sm btn-warning">Edit</a>
                    <a href="DeleteDepartmentServlet?dept_id=<%=d.getDeptId()%>" class="btn btn-sm btn-danger"
                       onclick="return confirm('Are you sure you want to delete this department?');">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

</div>
</body>
</html>
