package com.university.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.university.dao.FacultyDAO;
import com.university.model.Faculty;

@WebServlet("/listFaculty")
public class FacultyListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        FacultyDAO dao = new FacultyDAO();
        List<Faculty> facultyList = dao.getAllFaculty();

        request.setAttribute("facultyList", facultyList);
        request.getRequestDispatcher("/admin/add_faculty.jsp.jsp").forward(request, response);
    }
}
