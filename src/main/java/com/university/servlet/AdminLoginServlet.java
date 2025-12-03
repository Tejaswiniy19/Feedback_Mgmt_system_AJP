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

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM users WHERE username=? AND password=? AND role='ADMIN'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ Use session to store logged-in user
                HttpSession session = request.getSession();
                session.setAttribute("adminUser", username);

                // ✅ Correct redirect to admin folder
                response.sendRedirect(request.getContextPath() + "/admin/admin_home.jsp");

            } else {
                // Forward back to login page with error message
                request.setAttribute("errorMessage", "Invalid username or password!");
                request.getRequestDispatcher("/admin/admin_login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
