package com.example.AdminMicroservice.Controller;

import com.example.AdminMicroservice.Model.Admin;
import com.example.AdminMicroservice.Service.AdminService;
import com.google.firebase.auth.FirebaseAuthException;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/admins")
@CrossOrigin(origins = "http://localhost:5173")
public class AdminController {

    private final AdminService adminService;

    // ✅ Constructor-based injection (better than @Autowired)
    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }


    @PostMapping("/add")
    @CrossOrigin(origins = "http://localhost:5173")
    public ResponseEntity<String> createAdmin(@RequestBody Admin admin) {
        try {
            String updateTime = adminService.createAdmin(admin);
            return ResponseEntity.ok("Admin created successfully at: " + updateTime);
        } catch (FirebaseAuthException e) {
            return ResponseEntity.status(500).body("Firebase Authentication error: " + e.getMessage());
        } catch (ExecutionException | InterruptedException e) {
            return ResponseEntity.status(500).body("Firestore error: " + e.getMessage());
        }
    }

    @PutMapping("/update/{id}")
    @CrossOrigin(origins = "http://localhost:5173")
    public ResponseEntity<String> updateAdmin(@PathVariable String id, @RequestBody Admin admin) {
        try {
            admin.setId(id); // ensure we update the correct document
            String updatedId = adminService.updateAdmin(admin);
            return ResponseEntity.ok("Admin updated successfully with ID: " + updatedId);
        } catch (ExecutionException | InterruptedException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error updating admin: " + e.getMessage());
        }
    }
}
