package com.example.demo.model;

import java.util.Date;

public class User {
    private String userName;
    private String email;
    private String birthday;
    private String contactNo;
    private String role = "passenger"; // Default role
    private boolean isPremium = false; // Default value
    private Date createdAt = new Date();

    // Getters and Setters
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getBirthday() { return birthday; }
    public void setBirthday(String birthday) { this.birthday = birthday; }
    public String getContactNo() { return contactNo; }
    public void setContactNo(String contactNo) { this.contactNo = contactNo; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public boolean isPremium() { return isPremium; }
    public void setPremium(boolean premium) { isPremium = premium; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
