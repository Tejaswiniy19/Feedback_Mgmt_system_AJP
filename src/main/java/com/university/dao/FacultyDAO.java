package com.university.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.university.model.Faculty;
import com.university.util.DBConnection;

public class FacultyDAO {

    public List<Faculty> getAllFaculty() {
        List<Faculty> facultyList = new ArrayList<>();
        String sql = "SELECT f.faculty_id, u.user_id, u.username, u.full_name AS faculty_name, u.role, d.dept_name AS department "
                   + "FROM faculty f "
                   + "JOIN users u ON f.user_id = u.user_id "
                   + "JOIN departments d ON f.dept_id = d.dept_id "
                   + "WHERE u.role = 'FACULTY'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Faculty f = new Faculty();
                f.setFacultyId(rs.getInt("faculty_id"));
                f.setUserId(rs.getInt("user_id"));
                f.setUsername(rs.getString("username"));
                f.setFullName(rs.getString("faculty_name"));
                f.setRole(rs.getString("role"));
                f.setDepartment(rs.getString("department"));
                facultyList.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return facultyList;
    }
}
