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

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect(request.getContextPath() + "/student/student_login.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("studentId");
        int formId = Integer.parseInt(request.getParameter("form_id"));

        try (Connection conn = DBConnection.getConnection()) {

            // Get all questions for this form
            String sqlQ = "SELECT * FROM feedback_questions WHERE form_id=?";
            PreparedStatement psQ = conn.prepareStatement(sqlQ);
            psQ.setInt(1, formId);
            ResultSet rsQ = psQ.executeQuery();

            while(rsQ.next()) {
                int questionId = rsQ.getInt("question_id");
                String type = rsQ.getString("question_type");

                if("RATING".equals(type)) {
                    String ratingStr = request.getParameter("rating_" + questionId);
                    if(ratingStr != null && !ratingStr.isEmpty()) {
                        int rating = Integer.parseInt(ratingStr);
                        PreparedStatement ps = conn.prepareStatement(
                            "INSERT INTO feedback_responses (user_id, form_id, question_id, rating) VALUES (?, ?, ?, ?)"
                        );
                        ps.setInt(1, studentId);
                        ps.setInt(2, formId);
                        ps.setInt(3, questionId);
                        ps.setInt(4, rating);
                        ps.executeUpdate();
                    }
                } else { // COMMENT
                    String comment = request.getParameter("comment_" + questionId);
                    if(comment != null && !comment.isEmpty()) {
                        PreparedStatement ps = conn.prepareStatement(
                            "INSERT INTO feedback_responses (user_id, form_id, question_id, comment) VALUES (?, ?, ?, ?)"
                        );
                        ps.setInt(1, studentId);
                        ps.setInt(2, formId);
                        ps.setInt(3, questionId);
                        ps.setString(4, comment);
                        ps.executeUpdate();
                    }
                }
            }

            // Redirect back to student dashboard with success message
            response.sendRedirect(request.getContextPath() + "/student/student_home.jsp?msg=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
