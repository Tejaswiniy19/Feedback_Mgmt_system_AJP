package com.university.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.university.dao.CourseDAO;
import com.university.model.Course;

@WebServlet("/AddCourseServlet")
public class AddCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("course_name").trim();
        int deptId = Integer.parseInt(request.getParameter("dept_id"));

        CourseDAO dao = new CourseDAO();
        Course c = new Course();
        c.setCourseName(name);
        c.setDeptId(deptId);

        if(dao.addCourse(c)) {
            request.getSession().setAttribute("successMessage", "Course added successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Course already exists or error occurred!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/add_course.jsp");
    }
}
