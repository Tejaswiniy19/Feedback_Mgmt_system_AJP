package com.university.model;

public class Course {
    private int courseId;
    private String courseName;
    private int deptId;

    // Constructors
    public Course() {}

    public Course(int courseId, String courseName, int deptId) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.deptId = deptId;
    }

    // Getters and Setters
    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }

    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }

    public int getDeptId() { return deptId; }
    public void setDeptId(int deptId) { this.deptId = deptId; }
}
