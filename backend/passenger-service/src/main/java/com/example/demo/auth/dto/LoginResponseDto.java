package com.example.demo.auth.dto;

import com.example.demo.auth.model.User;

public class LoginResponseDto {
    private String customToken;
    private User userDetails;

    public LoginResponseDto(String customToken, User userDetails) {
        this.customToken = customToken;
        this.userDetails = userDetails;
    }

    // Getters and Setters
    public String getCustomToken() { return customToken; }
    public void setCustomToken(String customToken) { this.customToken = customToken; }
    public User getUserDetails() { return userDetails; }
    public void setUserDetails(User userDetails) { this.userDetails = userDetails; }
}