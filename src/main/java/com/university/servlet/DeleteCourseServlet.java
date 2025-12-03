package com.university.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.university.dao.CourseDAO;

@WebServlet("/DeleteCourseServlet")
public class DeleteCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("course_id"));
        CourseDAO dao = new CourseDAO();

        if(dao.deleteCourse(id)) {
            request.getSession().setAttribute("successMessage", "Course deleted successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Error deleting course!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/add_course.jsp");
    }
}
