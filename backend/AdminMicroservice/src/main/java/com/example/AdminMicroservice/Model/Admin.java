package com.example.AdminMicroservice.Model;

public class Admin {

    private String id;           // Firestore document ID
    private String adminStatus;
    private String username;
    private int age;
    private String name;
    private String password;

    // Default constructor
    public Admin() {
    }

    // All-args constructor
    public Admin(String id, String adminStatus, String username, int age, String name, String password) {
        this.id = id;
        this.adminStatus = adminStatus;
        this.username = username;
        this.age = age;
        this.name = name;
        this.password = password;
    }

    // Getters and Setters

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAdminStatus() {
        return adminStatus;
    }

    public void setAdminStatus(String adminStatus) {
        this.adminStatus = adminStatus;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
