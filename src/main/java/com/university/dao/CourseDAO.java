package com.university.dao;

import java.sql.*;
import java.util.*;
import com.university.model.Course;
import com.university.util.DBConnection;

public class CourseDAO {

    // Get all courses
    public List<Course> getAllCourses() {
        List<Course> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM courses ORDER BY course_id ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                list.add(new Course(rs.getInt("course_id"),
                                    rs.getString("course_name"),
                                    rs.getInt("dept_id")));
            }
        } catch(Exception e) { e.printStackTrace(); }
        return list;
    }

    // Add course
    public boolean addCourse(Course c) {
        try (Connection conn = DBConnection.getConnection()) {
            String checkSql = "SELECT * FROM courses WHERE course_name=? AND dept_id=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, c.getCourseName().trim());
            checkStmt.setInt(2, c.getDeptId());
            ResultSet rs = checkStmt.executeQuery();
            if(rs.next()) return false; // Duplicate

            String sql = "INSERT INTO courses (course_name, dept_id) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getCourseName().trim());
            ps.setInt(2, c.getDeptId());
            int row = ps.executeUpdate();
            return row > 0;
        } catch(Exception e) { e.printStackTrace(); return false; }
    }

    // Get by ID
    public Course getCourseById(int id) {
        Course c = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM courses WHERE course_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                c = new Course(rs.getInt("course_id"),
                               rs.getString("course_name"),
                               rs.getInt("dept_id"));
            }
        } catch(Exception e) { e.printStackTrace(); }
        return c;
    }

    // Update course
    public boolean updateCourse(Course c) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE courses SET course_name=?, dept_id=? WHERE course_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getCourseName().trim());
            ps.setInt(2, c.getDeptId());
            ps.setInt(3, c.getCourseId());
            int row = ps.executeUpdate();
            return row > 0;
        } catch(Exception e) { e.printStackTrace(); return false; }
    }

    // Delete course
    public boolean deleteCourse(int id) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM courses WHERE course_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int row = ps.executeUpdate();
            return row > 0;
        } catch(Exception e) { e.printStackTrace(); return false; }
    }
}
