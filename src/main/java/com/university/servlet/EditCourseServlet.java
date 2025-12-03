package com.university.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.university.dao.CourseDAO;
import com.university.model.Course;

@WebServlet("/EditCourseServlet")
public class EditCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("course_id"));
        String name = request.getParameter("course_name").trim();
        int deptId = Integer.parseInt(request.getParameter("dept_id"));

        CourseDAO dao = new CourseDAO();
        Course c = new Course(id, name, deptId);

        if(dao.updateCourse(c)) {
            request.getSession().setAttribute("successMessage", "Course updated successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Error updating course!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/add_course.jsp");
    }
}
