package com.university.dao;

import java.sql.*;
import java.util.*;
import com.university.util.DBConnection;

public class UserDAO {

    // Get all users (for dropdown)
    public List<Map<String, Object>> getAllUsers() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT user_id, full_name, email FROM users ORDER BY full_name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("userId", rs.getInt("user_id"));
                map.put("fullName", rs.getString("full_name"));
                map.put("email", rs.getString("email"));
                list.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
