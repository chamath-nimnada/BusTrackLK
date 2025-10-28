package com.example.demo.controller;

import com.example.demo.dto.LocationUpdateRequest;
import com.example.demo.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/location")
public class LocationController {

    @Autowired
    private LocationService locationService;

    /**
     * Endpoint for the driver app to continuously send location updates.
     */
    @PostMapping("/update")
    public ResponseEntity<String> updateLocation(@RequestBody LocationUpdateRequest locationRequest) {
        try {
            if (locationRequest.getDriverUid() == null || locationRequest.getLocation() == null) {
                return ResponseEntity.badRequest().body("Driver UID and location are required.");
            }
            locationService.updateLocation(locationRequest);
            return ResponseEntity.ok("Location updated");
        } catch (Exception e) {
            System.err.println("Failed to update location: " + e.getMessage());
            return ResponseEntity.status(500).body("Error updating location: " + e.getMessage());
        }
    }

    /**
     * Endpoint for the driver app to call when the journey stops.
     * Expects a JSON body like: {"driverUid": "some_uid_123"}
     */
    @PostMapping("/stop")
    public ResponseEntity<String> stopLocationSharing(@RequestBody Map<String, String> payload) {
        try {
            String driverUid = payload.get("driverUid");
            if (driverUid == null) {
                return ResponseEntity.badRequest().body("Driver UID is required.");
            }
            locationService.stopLocationSharing(driverUid);
            return ResponseEntity.ok("Location sharing stopped");
        } catch (Exception e) {
            System.err.println("Failed to stop location sharing: " + e.getMessage());
            return ResponseEntity.status(500).body("Error stopping location sharing: " + e.getMessage());
        }
    }
}