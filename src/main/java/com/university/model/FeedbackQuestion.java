package com.university.model;

public class FeedbackQuestion {
    private int questionId;
    private int formId; // FK to FeedbackForm
    private String questionText;

    public FeedbackQuestion() {}
    public FeedbackQuestion(int questionId, int formId, String questionText) {
        this.questionId = questionId;
        this.formId = formId;
        this.questionText = questionText;
    }

    public int getQuestionId() { return questionId; }
    public void setQuestionId(int questionId) { this.questionId = questionId; }

    public int getFormId() { return formId; }
    public void setFormId(int formId) { this.formId = formId; }

    public String getQuestionText() { return questionText; }
    public void setQuestionText(String questionText) { this.questionText = questionText; }
}
