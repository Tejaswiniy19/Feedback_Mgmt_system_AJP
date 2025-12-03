<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, com.university.util.DBConnection" %>
<%
    if (session == null || session.getAttribute("studentUser") == null) {
        response.sendRedirect(request.getContextPath() + "/student/student_login.jsp");
        return;
    }
    int studentId = (int) session.getAttribute("studentId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Feedback</title>
    <style>
        body { font-family: Arial; background: #f0f2f5; display: flex; justify-content: center; padding: 50px; }
        .form-box { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.2); width: 600px; }
        input, select, textarea, button { width: 100%; padding: 10px; margin: 10px 0; }
        button { background: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #45a049; }
    </style>
</head>
<body>
    <div class="form-box">
        <h2>Submit Feedback</h2>
        <form action="<%=request.getContextPath()%>/SubmitFeedbackServlet" method="post">
            <select name="form_id" id="formSelect" required>
                <option value="">Select Feedback Form</option>
                <%
                    try (Connection conn = DBConnection.getConnection()) {
                        String sql = "SELECT * FROM feedback_forms";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        while(rs.next()) {
                %>
                    <option value="<%=rs.getInt("form_id")%>"><%=rs.getString("title")%></option>
                <%
                        }
                    } catch(Exception e) { out.println(e); }
                %>
            </select>

            <div id="questions">
                <%
                    // Load questions for the first form (optional)
                    try (Connection conn = DBConnection.getConnection()) {
                        String sql = "SELECT * FROM feedback_questions";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        while(rs.next()) {
                %>
                    <p><strong><%=rs.getString("question_text")%></strong></p>
                    <%
                        if("RATING".equals(rs.getString("question_type"))) {
                    %>
                        <select name="rating_<%=rs.getInt("question_id")%>" required>
                            <option value="">Select rating</option>
                            <option value="5">Excellent</option>
                            <option value="4">Good</option>
                            <option value="3">Average</option>
                            <option value="2">Poor</option>
                            <option value="1">Bad</option>
                        </select>
                    <%
                        } else { // COMMENT
                    %>
                        <textarea name="comment_<%=rs.getInt("question_id")%>" placeholder="Your feedback here..." required></textarea>
                    <%
                        }
                    %>
                <%
                        }
                    } catch(Exception e) { out.println(e); }
                %>
            </div>

            <button type="submit">Submit Feedback</button>
        </form>
        <a href="<%=request.getContextPath()%>/student/student_home.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
