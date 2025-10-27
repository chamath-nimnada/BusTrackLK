package com.example.AdminMicroservice.Model;

public class User {
    private String uid;
    private String email;
    private String displayName;
    private String token; // optional - for session/JWT

    public User() {}

    public User(String uid, String email, String displayName, String token) {
        this.uid = uid;
        this.email = email;
        this.displayName = displayName;
        this.token = token;
    }

    // Getters and setters
    public String getUid() { return uid; }
    public void setUid(String uid) { this.uid = uid; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDisplayName() { return displayName; }
    public void setDisplayName(String displayName) { this.displayName = displayName; }

    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }
}
