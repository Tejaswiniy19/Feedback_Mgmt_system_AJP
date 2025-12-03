package com.university.model;

import java.sql.Timestamp;

public class FeedbackResponse {
    private int responseId;
    private int userId;
    private int formId;
    private int questionId;
    private Integer rating; // optional
    private String comment; // optional
    private Timestamp createdAt;

    public FeedbackResponse() {}
    public FeedbackResponse(int responseId, int userId, int formId, int questionId, Integer rating, String comment, Timestamp createdAt) {
        this.responseId = responseId;
        this.userId = userId;
        this.formId = formId;
        this.questionId = questionId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    public int getResponseId() { return responseId; }
    public void setResponseId(int responseId) { this.responseId = responseId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getFormId() { return formId; }
    public void setFormId(int formId) { this.formId = formId; }

    public int getQuestionId() { return questionId; }
    public void setQuestionId(int questionId) { this.questionId = questionId; }

    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
