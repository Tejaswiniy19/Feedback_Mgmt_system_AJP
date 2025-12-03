package com.university.servlet;

import com.university.dao.FacultyDAO;
import com.university.model.Faculty;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class EditFacultyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int facultyId = Integer.parseInt(request.getParameter("faculty_id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int deptId = Integer.parseInt(request.getParameter("dept_id"));

        Faculty f = new Faculty(facultyId, name, email, deptId);

        FacultyDAO dao = new FacultyDAO();
        boolean updated = dao.updateFaculty(f);

        if(updated){
            request.getSession().setAttribute("successMessage", "Faculty updated successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Error updating faculty!");
        }

        response.sendRedirect("add_faculty.jsp");
    }
}
