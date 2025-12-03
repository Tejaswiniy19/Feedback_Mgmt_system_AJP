package com.university.model;

public class FeedbackForm {
    private int formId;
    private String title;

    public FeedbackForm() {}
    public FeedbackForm(int formId, String title) {
        this.formId = formId;
        this.title = title;
    }

    public int getFormId() { return formId; }
    public void setFormId(int formId) { this.formId = formId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
}
