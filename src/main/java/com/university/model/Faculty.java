package com.university.model;

public class Faculty {
    private int facultyId;
    private int userId;
    private String username;
    private String fullName;
    private String role;
    private String department;

    // Getters and setters
    public int getFacultyId() { return facultyId; }
    public void setFacultyId(int facultyId) { this.facultyId = facultyId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
}
