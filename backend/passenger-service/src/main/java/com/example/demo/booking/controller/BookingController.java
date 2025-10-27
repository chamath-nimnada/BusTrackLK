package com.example.demo.booking.controller;

import com.example.demo.booking.dto.BookingResponseDto;
import com.example.demo.booking.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api/booking") // New base path
public class BookingController {

    @Autowired
    private BookingService bookingService;

    // Endpoint for searching bookable trips
    @GetMapping("/search")
    public ResponseEntity<?> searchBookableTrips(
            @RequestParam String startLocation,
            @RequestParam String endLocation,
            @RequestParam String date) {
        try {
            List<BookingResponseDto> trips = bookingService.searchBookableTrips(startLocation, endLocation, date);
            // Return empty list if no trips found, not an error
            return ResponseEntity.ok(trips == null ? Collections.emptyList() : trips);
        } catch (Exception e) {
            System.err.println("Error searching bookable trips: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body("Error searching for bookable trips: " + e.getMessage());
        }
    }

    // We can reuse the locations endpoint from ScheduleController if needed,
    // or add a GET /api/booking/locations endpoint here that calls scheduleService.getAllLocations()
}