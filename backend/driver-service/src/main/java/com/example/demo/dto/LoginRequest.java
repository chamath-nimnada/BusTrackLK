package com.example.demo.dto;

// This class is the blueprint for the JSON data the Flutter app will send
// AFTER successfully logging in with Firebase Auth on the phone.
public class LoginRequest {

    // It only contains the ID Token provided by Firebase
    private String idToken;

    // Getters and Setters
    public String getIdToken() {
        return idToken;
    }

    public void setIdToken(String idToken) {
        this.idToken = idToken;
    }
}
