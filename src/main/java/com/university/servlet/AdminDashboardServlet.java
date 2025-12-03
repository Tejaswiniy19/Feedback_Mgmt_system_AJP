package com.university.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.university.util.DBConnection;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin_login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Total Students
            PreparedStatement ps1 = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE role='STUDENT'");
            ResultSet rs1 = ps1.executeQuery();
            if(rs1.next()) request.setAttribute("totalStudents", rs1.getInt(1));

            // Total Faculty
            PreparedStatement ps2 = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE role='FACULTY'");
            ResultSet rs2 = ps2.executeQuery();
            if(rs2.next()) request.setAttribute("totalFaculty", rs2.getInt(1));

            // Total Departments
            PreparedStatement ps3 = conn.prepareStatement("SELECT COUNT(*) FROM departments");
            ResultSet rs3 = ps3.executeQuery();
            if(rs3.next()) request.setAttribute("totalDepartments", rs3.getInt(1));

            // Total Feedbacks
            PreparedStatement ps4 = conn.prepareStatement("SELECT COUNT(*) FROM feedbacks");
            ResultSet rs4 = ps4.executeQuery();
            if(rs4.next()) request.setAttribute("totalFeedbacks", rs4.getInt(1));

            // Faculty List
            PreparedStatement ps5 = conn.prepareStatement(
                "SELECT u.user_id, u.full_name, u.username, d.dept_name " +
                "FROM users u LEFT JOIN departments d ON u.department_id=d.dept_id WHERE u.role='FACULTY'"
            );
            ResultSet rs5 = ps5.executeQuery();
            request.setAttribute("facultyList", rs5);

            request.getRequestDispatcher("/admin/admin_dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
