package com.example.AdminMicroservice.Controller;

import com.example.AdminMicroservice.Model.Driver;
import com.example.AdminMicroservice.Service.DriverService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/drivers")
@CrossOrigin(origins = "http://localhost:5173")
public class DriverController {

    private final DriverService driverService;

    public DriverController(DriverService driverService) {
        this.driverService = driverService;
    }

    @PostMapping("/add")
    @CrossOrigin(origins = "http://localhost:5173")
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
    @CrossOrigin(origins = "http://localhost:5173")
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

    @GetMapping("/all")
    @CrossOrigin(origins = "http://localhost:5173")
    public ResponseEntity<?> getAllDrivers() {
        try {
            List<Driver> drivers = driverService.getAllDrivers();
            return ResponseEntity.ok(drivers);
        } catch (ExecutionException | InterruptedException e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("❌ Error retrieving driver details: " + e.getMessage());
        }
    }
}
