package com.example.demo.auth.controller;

import com.example.demo.auth.dto.LoginRequestDto;
import com.example.demo.auth.dto.LoginResponseDto;
import com.example.demo.auth.dto.RegisterRequestDto;
import com.example.demo.auth.service.AuthService;
import com.google.firebase.auth.FirebaseAuthException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/register")
    // 2. Add the @Valid annotation before the @RequestBody
    public ResponseEntity<?> register(@Valid @RequestBody RegisterRequestDto registerRequest) {
        try {
            String userId = authService.registerUser(registerRequest);
            return ResponseEntity.ok("User registered successfully with ID: " + userId);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error registering user: " + e.getMessage());
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequestDto loginRequest) {
        try {
            // We are assuming the client (Flutter app) will handle the password validation
            // Our backend's job is to create a token if the user exists.
            LoginResponseDto response = authService.loginUser(loginRequest);
            return ResponseEntity.ok(response);
        } catch (FirebaseAuthException e) {
            // This often means the user was not found
            return ResponseEntity.status(401).body("Login failed: Invalid credentials.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error logging in: " + e.getMessage());
        }
    }
}