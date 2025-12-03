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

@WebServlet("/FacultyLoginServlet")
public class FacultyLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            // SQL query to authenticate faculty
            String sql = "SELECT * FROM users WHERE username=? AND password=? AND role='FACULTY'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Login successful
                HttpSession session = request.getSession();
                session.setAttribute("facultyUser", username);
                session.setAttribute("facultyId", rs.getInt("user_id"));
                session.setAttribute("facultyName", rs.getString("name"));

                // Redirect to faculty dashboard
                response.sendRedirect(request.getContextPath() + "/faculty/dashboard.jsp");
            } else {
                // Login failed
                request.setAttribute("errorMessage", "Invalid username or password!");
                request.getRequestDispatcher("/faculty/faculty_login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/faculty/faculty_login.jsp").forward(request, response);
        }
    }
}
