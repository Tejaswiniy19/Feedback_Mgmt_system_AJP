package com.university.servlet;

import com.university.dao.FacultyDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteFacultyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int facultyId = Integer.parseInt(request.getParameter("faculty_id"));
        FacultyDAO dao = new FacultyDAO();
        dao.deleteFaculty(facultyId);
        response.sendRedirect("add_faculty.jsp");
    }
}
