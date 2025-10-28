package com.example.demo.tracking.controller;

import com.example.demo.tracking.dto.LiveBusLocationDto;
import com.example.demo.tracking.service.TrackingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api/tracking")
public class TrackingController {

    @Autowired
    private TrackingService trackingService;

    /**
     * Searches for live buses.
     * We'll use the 'startLocation' parameter as the Route Number for simplicity.
     * A real app would have a service to map (start, end) -> routeNo.
     */
    @GetMapping("/search")
    public ResponseEntity<?> searchLiveBuses(
            @RequestParam String startLocation,
            @RequestParam String endLocation,
            @RequestParam String date) { // Date might not be needed, but good to match
        try {
            // For simplicity, we assume startLocation IS the route number.
            // In a real app: String routeNo = scheduleService.getRouteNo(startLocation, endLocation);
            String routeNo = startLocation;

            List<LiveBusLocationDto> buses = trackingService.findLiveBuses(routeNo);
            if (buses.isEmpty()) {
                return ResponseEntity.ok(Collections.emptyList());
            }
            return ResponseEntity.ok(buses);
        } catch (Exception e) {
            System.err.println("Error searching live buses: " + e.getMessage());
            return ResponseEntity.status(500).body("Error searching live buses.");
        }
    }

    /**
     * Gets all currently active buses, for the map view.
     */
    @GetMapping("/all")
    public ResponseEntity<?> getAllLiveBuses() {
        try {
            List<LiveBusLocationDto> buses = trackingService.findAllLiveBuses();
            return ResponseEntity.ok(buses);
        } catch (Exception e) {
            System.err.println("Error getting all live buses: " + e.getMessage());
            return ResponseEntity.status(500).body("Error getting live buses.");
        }
    }
}