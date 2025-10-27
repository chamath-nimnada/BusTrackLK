package com.example.AdminMicroservice.Controller;

import com.example.AdminMicroservice.Model.Driver;
import com.example.AdminMicroservice.Service.DriverService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/drivers")
public class DriverController {

    private final DriverService driverService;

    public DriverController(DriverService driverService) {
        this.driverService = driverService;
    }

    @PostMapping("/add")
    public ResponseEntity<String> addDriver(@RequestBody Driver driver) {
        try {
            String driverId = driverService.addDriver(driver);
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body("Driver added successfully with ID: " + driverId);
        } catch (ExecutionException | InterruptedException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error adding driver: " + e.getMessage());
        }
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<String> updateDriverStatus(
            @PathVariable String id,
            @RequestParam("status") String newStatus) {

        try {
            String message = driverService.updateDriverStatus(id, newStatus);
            return ResponseEntity.ok(message);
        } catch (ExecutionException | InterruptedException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("❌ Failed to update driver status: " + e.getMessage());
        }
    }
}
