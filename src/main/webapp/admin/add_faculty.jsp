<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.university.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Faculty Management | JNTU-GV</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }
.navbar { background-color: #004aad !important; }
.navbar-brand, .nav-link { color: #fff !important; font-weight: 500; }
.nav-link:hover { color: #cce6ff !important; }
.sidebar { position: fixed; top: 0; left: 0; height: 100vh; width: 220px; background-color: #004aad; padding-top: 60px; color: #fff; }
.sidebar a { display: block; color: #fff; padding: 12px 20px; text-decoration: none; font-weight: 500; }
.sidebar a:hover { background-color: #0552b2; }
.sidebar a.active { background-color: #003366; font-weight: bold; }
.main-content { margin-left: 220px; padding: 80px 20px 20px 20px; }
.form-box { background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 15px rgba(0,0,0,0.1); max-width: 600px; margin: auto 0 30px 0; }
.form-box input, .form-box select, .form-box button { width: 100%; padding: 10px; margin: 8px 0; }
.form-box button { background: #4CAF50; color: #fff; border: none; border-radius: 5px; cursor: pointer; }
.form-box button:hover { background: #45a049; }
.glass-table { width: 100%; border-collapse: collapse; background: rgba(255,255,255,0.2); backdrop-filter: blur(10px); border-radius: 15px; overflow: hidden; box-shadow: 0 8px 32px rgba(0,0,0,0.1); margin-top: 30px; }
.glass-table th, .glass-table td { padding: 12px 15px; text-align: left; }
.glass-table thead { background: rgba(0,74,173,0.8); color: #fff; font-weight: 600; }
.glass-table tbody tr { border-bottom: 1px solid rgba(255,255,255,0.1); transition: all 0.3s ease; }
.glass-table tbody tr:hover { background: rgba(0,74,173,0.1); }
.btn { padding: 5px 10px; border: none; border-radius: 5px; cursor: pointer; margin: 0 2px; }
.btn-edit { background-color: #ffc107; color: #fff; }
.btn-edit:hover { background-color: #e0a800; }
.btn-delete { background-color: #dc3545; color: #fff; }
.btn-delete:hover { background-color: #c82333; }
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm fixed-top">
<div class="container-fluid">
    <a class="navbar-brand" href="#">Admin Panel | JNTU-GV</a>
    <div class="collapse navbar-collapse justify-content-end">
        <ul class="navbar-nav">
            <li class="nav-item"><span class="nav-link">Hello, <strong>Admin</strong></span></li>
            <li class="nav-item"><a class="nav-link btn btn-outline-light ms-2" href="#">Logout</a></li>
        </ul>
    </div>
</div>
</nav>

<!-- Sidebar -->
<div class="sidebar">
    <a href="admin_home.jsp">Dashboard</a>
    <a href="add_department.jsp">Add Department</a>
    <a href="add_course.jsp">Add Course</a>
    <a href="manage_faculty.jsp" class="active">Manage Faculty</a>
    <a href="view_feedback.jsp">View Feedback</a>
</div>

<div class="main-content">

<%
Connection conn = null;
try {
    conn = DBConnection.getConnection();

    // DELETE FACULTY
    if(request.getParameter("delete_id") != null) {
        int fid = Integer.parseInt(request.getParameter("delete_id"));
        int uid = 0;
        PreparedStatement psUid = conn.prepareStatement("SELECT user_id FROM faculty WHERE faculty_id=?");
        psUid.setInt(1,fid);
        ResultSet rsUid = psUid.executeQuery();
        if(rsUid.next()) uid = rsUid.getInt("user_id");
        rsUid.close(); psUid.close();

        PreparedStatement psDelF = conn.prepareStatement("DELETE FROM faculty WHERE faculty_id=?");
        psDelF.setInt(1,fid); psDelF.executeUpdate(); psDelF.close();

        PreparedStatement psDelU = conn.prepareStatement("DELETE FROM users WHERE user_id=?");
        psDelU.setInt(1,uid); psDelU.executeUpdate(); psDelU.close();

        out.println("<p style='color:green;text-align:center;'>Faculty deleted successfully!</p>");
    }

    // ADD / UPDATE FACULTY
    if(request.getParameter("saveFaculty") != null) {
        String username = request.getParameter("username");
        String fullName = request.getParameter("full_name");
        String password = request.getParameter("password");
        int deptId = Integer.parseInt(request.getParameter("dept_id"));
        String editId = request.getParameter("edit_id");

        if(editId != null && !editId.isEmpty()) {
            int fid = Integer.parseInt(editId);
            int uid = 0;
            PreparedStatement psUid = conn.prepareStatement("SELECT user_id FROM faculty WHERE faculty_id=?");
            psUid.setInt(1,fid);
            ResultSet rsUid = psUid.executeQuery();
            if(rsUid.next()) uid = rsUid.getInt("user_id");
            rsUid.close(); psUid.close();

            PreparedStatement psUpd = conn.prepareStatement("UPDATE users SET username=?, full_name=?, password=? WHERE user_id=?");
            psUpd.setString(1,username); psUpd.setString(2,fullName); psUpd.setString(3,password); psUpd.setInt(4,uid);
            psUpd.executeUpdate(); psUpd.close();

            PreparedStatement psUpdF = conn.prepareStatement("UPDATE faculty SET dept_id=? WHERE faculty_id=?");
            psUpdF.setInt(1,deptId); psUpdF.setInt(2,fid);
            psUpdF.executeUpdate(); psUpdF.close();

            out.println("<p style='color:green;text-align:center;'>Faculty updated successfully!</p>");
        } else {
            PreparedStatement ps1 = conn.prepareStatement(
                "INSERT INTO users(username, password, full_name, role) VALUES(?,?,?,?)",
                Statement.RETURN_GENERATED_KEYS);
            ps1.setString(1, username); ps1.setString(2, password); ps1.setString(3, fullName); ps1.setString(4, "FACULTY");
            ps1.executeUpdate();
            ResultSet rs1 = ps1.getGeneratedKeys();
            int userId = 0; if(rs1.next()) userId = rs1.getInt(1);
            rs1.close(); ps1.close();

            PreparedStatement ps2 = conn.prepareStatement("INSERT INTO faculty(user_id, dept_id) VALUES(?,?)");
            ps2.setInt(1,userId); ps2.setInt(2,deptId); ps2.executeUpdate(); ps2.close();

            out.println("<p style='color:green;text-align:center;'>Faculty added successfully!</p>");
        }
    }

    // LOAD EDIT DATA IF ANY
    String editId = request.getParameter("edit_id");
    String editUsername="", editFullName="", editPassword="";
    int editDeptId=0;
    if(editId != null && !editId.isEmpty()) {
        PreparedStatement psE = conn.prepareStatement(
            "SELECT u.username, u.full_name, u.password, f.dept_id FROM users u JOIN faculty f ON u.user_id=f.user_id WHERE f.faculty_id=?");
        psE.setInt(1,Integer.parseInt(editId));
        ResultSet rsE = psE.executeQuery();
        if(rsE.next()) {
            editUsername = rsE.getString("username");
            editFullName = rsE.getString("full_name");
            editPassword = rsE.getString("password");
            editDeptId = rsE.getInt("dept_id");
        }
        rsE.close(); psE.close();
    }

%>

<div class="form-box">
    <h3 class="mb-3 text-center"><%= (editId!=null)?"Edit Faculty":"Add New Faculty" %></h3>
    <form method="post" action="manage_faculty.jsp">
        <% if(editId!=null) { %>
            <input type="hidden" name="edit_id" value="<%=editId%>">
        <% } %>
        <input type="text" name="username" placeholder="Username" value="<%=editUsername%>" required>
        <input type="text" name="full_name" placeholder="Full Name" value="<%=editFullName%>" required>
        <input type="password" name="password" placeholder="Password" value="<%=editPassword%>" required>
        <select name="dept_id" required>
            <option value="">Select Department</option>
            <%
                PreparedStatement psDept = conn.prepareStatement("SELECT dept_id, dept_name FROM departments");
                ResultSet rsDept = psDept.executeQuery();
                while(rsDept.next()) {
                    int did = rsDept.getInt("dept_id");
                    String dname = rsDept.getString("dept_name");
            %>
            <option value="<%=did%>" <%= (did==editDeptId)?"selected":"" %> ><%=dname%></option>
            <%
                }
                rsDept.close(); psDept.close();
            %>
        </select>
        <button type="submit" name="saveFaculty"><%= (editId!=null)?"Update Faculty":"Add Faculty" %></button>
        <% if(editId!=null) { %>
            <a href="manage_faculty.jsp" class="btn btn-secondary">Cancel</a>
        <% } %>
    </form>
</div>

<h2 class="mt-4 mb-3 text-center">Existing Faculty</h2>
<table class="glass-table">
    <thead>
        <tr>
            <th>#</th>
            <th>Username</th>
            <th>Full Name</th>
            <th>Role</th>
            <th>Department</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
<%
    PreparedStatement psList = conn.prepareStatement(
        "SELECT f.faculty_id, u.username, u.full_name AS faculty_name, u.role, d.dept_name AS department " +
        "FROM faculty f JOIN users u ON f.user_id=u.user_id " +
        "JOIN departments d ON f.dept_id=d.dept_id WHERE u.role='FACULTY'");
    ResultSet rsList = psList.executeQuery();
    int i=1;
    while(rsList.next()) {
%>
<tr>
    <td><%=i++ %></td>
    <td><%=rsList.getString("username")%></td>
    <td><%=rsList.getString("faculty_name")%></td>
    <td><%=rsList.getString("role")%></td>
    <td><%=rsList.getString("department")%></td>
    <td>
        <a class="btn btn-edit" href="manage_faculty.jsp?edit_id=<%=rsList.getInt("faculty_id")%>">Edit</a>
        <a class="btn btn-delete" href="manage_faculty.jsp?delete_id=<%=rsList.getInt("faculty_id")%>" onclick="return confirm('Are you sure?');">Delete</a>
    </td>
</tr>
<%
    }
    rsList.close(); psList.close();

} catch(Exception e) {
    out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
} finally {
    try { if(conn != null) conn.close(); } catch(Exception ex) {}
}
%>
    </tbody>
</table>

</div>
</body>
</html>
