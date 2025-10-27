package com.example.AdminMicroservice.Controller;

import com.example.AdminMicroservice.Model.Admin;
import com.example.AdminMicroservice.Service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/admins")
@CrossOrigin(origins = "*")
public class AdminController {

    private final AdminService adminService;

    // ✅ Constructor-based injection (better than @Autowired)
    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }


    @PostMapping("/add")
    public Admin addAdmin(@RequestBody Admin admin) {
        try {
            return adminService.addAdmin(admin);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error adding admin: " + e.getMessage());
        }
    }

    @PutMapping("/update/{id}")
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
