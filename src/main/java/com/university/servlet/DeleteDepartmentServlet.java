package com.university.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.university.dao.DepartmentDAO;

@WebServlet("/DeleteDepartmentServlet")
public class DeleteDepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("dept_id"));
        DepartmentDAO dao = new DepartmentDAO();

        if (dao.deleteDepartment(id)) {
            request.getSession().setAttribute("successMessage", "Department deleted successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Error deleting department!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/add_department.jsp");
    }
}
