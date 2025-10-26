package com.example.demo.controller;

import com.example.demo.dto.LoginRequest; // <-- 1. ADD IMPORT
import com.example.demo.dto.LoginResponse; // <-- 1. ADD IMPORT
import com.example.demo.dto.RegisterRequest;
import com.example.demo.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class AuthController {

    @Autowired
    private AuthService authService;

    // --- YOUR EXISTING registerUser ENDPOINT ---
    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody RegisterRequest registerRequest) {
        try {
            String uid = authService.registerUser(registerRequest);
            return ResponseEntity.ok("User registered successfully with UID: " + uid);
        } catch (Exception e) {
            // It's better to log the error on the server
            System.err.println("Registration failed: " + e.getMessage());
            // Return a more generic error message to the client
            return ResponseEntity.badRequest().body("Registration failed: " + e.getMessage());
        }
    }


    // --- 2. ADD THIS NEW loginUser ENDPOINT ---
    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody LoginRequest loginRequest) {
        try {
            // Call the loginUser method in the service
            LoginResponse loginResponse = authService.loginUser(loginRequest);

            // If successful, send a 200 OK response with the LoginResponse data
            return ResponseEntity.ok(loginResponse);

        } catch (Exception e) {
            // If verification fails or driver data is not found
            System.err.println("Login failed: " + e.getMessage());
            // Send a 401 Unauthorized or 400 Bad Request status
            // (You might want more specific error handling later)
            return ResponseEntity.status(401).body("Login failed: " + e.getMessage());
        }
    }
    // --- END OF NEW ENDPOINT ---

}

