package com.ammar.expenseManagerDemo.model;

import java.sql.Date;

public class Expense {
    private int expenseId;
    private String description;
    private int amount;
    private Date entryDate;
    private int userId;
    private int categoryId;

    // Helper for Display (Not in Expense Table, but used in Java)
    private String categoryName;

    public Expense() {}

    public Expense(int expenseId, String description, int amount, Date entryDate, int userId, int categoryId, String categoryName) {
        this.expenseId = expenseId;
        this.description = description;
        this.amount = amount;
        this.entryDate = entryDate;
        this.userId = userId;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }

    // Getters and Setters
    public int getExpenseId() {
        return expenseId;
    }
    public void setExpenseId(int expenseId) {
        this.expenseId = expenseId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getEntryDate() {
        return entryDate;
    }
    public void setEntryDate(Date entryDate) {
        this.entryDate = entryDate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
