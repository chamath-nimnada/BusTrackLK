package com.example.AdminMicroservice.Controller;



import com.example.AdminMicroservice.Model.User;
import com.example.AdminMicroservice.Service.UserService;
import com.google.firebase.auth.FirebaseAuthException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "http://localhost:5173")
public class UserController {

    @Autowired
    private UserService authService;

    @PostMapping("/login")
    @CrossOrigin(origins = "http://localhost:5173")
    public User login(@RequestHeader("Authorization") String authHeader) throws FirebaseAuthException {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new RuntimeException("Missing or invalid Authorization header");
        }

        String idToken = authHeader.substring(7); // remove "Bearer "
        return authService.verifyToken(idToken);
    }
}