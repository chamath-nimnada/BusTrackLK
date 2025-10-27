package com.example.demo.controller;

import com.example.demo.dto.LoginRequest;
import com.example.demo.dto.LoginResponse;
import com.example.demo.dto.RegisterRequest;
import com.example.demo.service.AuthService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException; // <-- Import

import com.google.firebase.auth.FirebaseAuthException; // <-- Import

@RestController
@RequestMapping("/api")
public class AuthController {

    @Autowired
    private AuthService authService;

    // --- registerUser endpoint (no changes needed here) ---
    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody RegisterRequest registerRequest) {
        try {
            String uid = authService.registerUser(registerRequest);
            return ResponseEntity.ok("User registered successfully with UID: " + uid);
        } catch (Exception e) {
            System.err.println("Registration failed: " + e.getMessage());
            // Check if it's a Firebase exception (e.g., email already exists)
            if (e instanceof FirebaseAuthException) {
                return ResponseEntity.badRequest().body("Registration failed: " + e.getMessage());
            }
            // Generic error for other issues
            return ResponseEntity.status(500).body("Registration failed due to an internal error.");
        }
    }


    // --- loginUser endpoint ---
    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody LoginRequest loginRequest) {
        try {
            LoginResponse loginResponse = authService.loginUser(loginRequest);
            return ResponseEntity.ok(loginResponse);

        } catch (ResponseStatusException e) {
            // Handle specific status exceptions from the service (like 403 Forbidden)
            System.err.println("Login failed: " + e.getReason() + " (Status: " + e.getStatusCode() + ")");
            // Return the status code and reason provided by the exception
            return ResponseEntity.status(e.getStatusCode()).body(e.getReason());

        } catch (FirebaseAuthException e) {
            // Handle Firebase Auth specific errors (e.g., invalid token)
            System.err.println("Login failed (Firebase Auth): " + e.getMessage());
            return ResponseEntity.status(401).body("Authentication failed: " + e.getMessage());

        } catch (Exception e) {
            // Handle other unexpected errors during login
            System.err.println("Login failed (General Exception): " + e.getMessage());
            e.printStackTrace(); // Log stack trace for unexpected errors
            // Return a generic 500 Internal Server Error
            return ResponseEntity.status(500).body("Login failed due to an unexpected server error.");
        }
    }
}