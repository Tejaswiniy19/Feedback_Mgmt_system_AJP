package com.university.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.university.dao.DepartmentDAO;
import com.university.model.Department;

@WebServlet("/EditDepartmentServlet")
public class EditDepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("dept_id"));
        String name = request.getParameter("dept_name").trim();

        DepartmentDAO dao = new DepartmentDAO();
        Department d = new Department(id, name);

        if (dao.updateDepartment(d)) {
            request.getSession().setAttribute("successMessage", "Department updated successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Error updating department!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/add_department.jsp");
    }
}
