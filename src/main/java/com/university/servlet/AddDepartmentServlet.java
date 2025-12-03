package com.university.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.university.dao.DepartmentDAO;
import com.university.model.Department;

@WebServlet("/AddDepartmentServlet")
public class AddDepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("dept_name").trim();

        DepartmentDAO dao = new DepartmentDAO();
        Department d = new Department();
        d.setDeptName(name);

        if (dao.addDepartment(d)) {
            request.getSession().setAttribute("successMessage", "Department added successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Department already exists or error occurred!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/add_department.jsp");
    }
}
