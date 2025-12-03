package com.university.dao;

import java.sql.*;
import java.util.*;
import com.university.model.Department;
import com.university.util.DBConnection;

public class DepartmentDAO {

    // Get all departments
    public List<Department> getAllDepartments() {
        List<Department> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM departments ORDER BY dept_id ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Department(rs.getInt("dept_id"), rs.getString("dept_name")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Add department
    public boolean addDepartment(Department d) {
        try (Connection conn = DBConnection.getConnection()) {
            // Check duplicate
            String checkSql = "SELECT * FROM departments WHERE dept_name=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, d.getDeptName().trim());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) return false;

            String sql = "INSERT INTO departments (dept_name) VALUES (?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, d.getDeptName().trim());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Get by ID
    public Department getDepartmentById(int id) {
        Department d = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM departments WHERE dept_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                d = new Department(rs.getInt("dept_id"), rs.getString("dept_name"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return d;
    }

    // Update department
    public boolean updateDepartment(Department d) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE departments SET dept_name=? WHERE dept_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, d.getDeptName().trim());
            ps.setInt(2, d.getDeptId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Delete department
    public boolean deleteDepartment(int id) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM departments WHERE dept_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}
