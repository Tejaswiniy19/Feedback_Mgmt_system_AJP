package com.university.servlet;

import com.university.util.DBConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/hod/dashboard")
public class HodDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("hodUser") == null) {
            response.sendRedirect(request.getContextPath() + "/hod/hod_login.jsp");
            return;
        }

        int deptId = (int) session.getAttribute("deptId"); // HOD's department
        String username = (String) session.getAttribute("hodUser");

        Map<String, Object> dashboardData = new HashMap<>();

        try (Connection conn = DBConnection.getConnection()) {

            // 1️⃣ Department Feedback Summary (Course-wise avg & count)
            String sqlSummary = "SELECT c.course_name, AVG(fr.rating) AS avg_rating, COUNT(fr.response_id) AS total_feedback " +
                                "FROM courses c " +
                                "LEFT JOIN feedback_forms ff ON c.course_id = ff.course_id " +
                                "LEFT JOIN feedback_responses fr ON ff.form_id = fr.form_id " +
                                "WHERE c.dept_id = ? " +
                                "GROUP BY c.course_name";
            PreparedStatement psSummary = conn.prepareStatement(sqlSummary);
            psSummary.setInt(1, deptId);
            ResultSet rsSummary = psSummary.executeQuery();
            List<Map<String, Object>> courseSummary = new ArrayList<>();
            while (rsSummary.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("course_name", rsSummary.getString("course_name"));
                row.put("avg_rating", rsSummary.getDouble("avg_rating"));
                row.put("total_feedback", rsSummary.getInt("total_feedback"));
                courseSummary.add(row);
            }
            dashboardData.put("courseSummary", courseSummary);

            // 2️⃣ Individual Student Feedback
            String sqlStudent = "SELECT u.full_name AS student_name, c.course_name, fr.rating, fr.comment " +
                                "FROM feedback_responses fr " +
                                "JOIN users u ON fr.user_id = u.user_id " +
                                "JOIN feedback_forms ff ON fr.form_id = ff.form_id " +
                                "JOIN courses c ON ff.course_id = c.course_id " +
                                "WHERE c.dept_id = ?";
            PreparedStatement psStudent = conn.prepareStatement(sqlStudent);
            psStudent.setInt(1, deptId);
            ResultSet rsStudent = psStudent.executeQuery();
            List<Map<String, Object>> studentFeedback = new ArrayList<>();
            while (rsStudent.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("student_name", rsStudent.getString("student_name"));
                row.put("course_name", rsStudent.getString("course_name"));
                row.put("rating", rsStudent.getInt("rating"));
                row.put("comment", rsStudent.getString("comment"));
                studentFeedback.add(row);
            }
            dashboardData.put("studentFeedback", studentFeedback);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading dashboard: " + e.getMessage());
        }

        request.setAttribute("username", username);
        request.setAttribute("dashboardData", dashboardData);
        RequestDispatcher rd = request.getRequestDispatcher("/hod/hod_dashboard.jsp");
        rd.forward(request, response);
    }
}
