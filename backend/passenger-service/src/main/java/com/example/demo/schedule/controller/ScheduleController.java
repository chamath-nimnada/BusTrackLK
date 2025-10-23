package com.example.demo.schedule.controller;

import com.example.demo.schedule.dto.ScheduleResponseDto;
import com.example.demo.schedule.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api/schedule")
public class ScheduleController {

    @Autowired
    private ScheduleService scheduleService;

    @GetMapping("/locations")
    public ResponseEntity<?> getAllLocations() {
        try {
            List<String> locations = scheduleService.getAllLocations();
            return ResponseEntity.ok(locations);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error fetching locations: " + e.getMessage());
        }
    }

    @GetMapping("/search")
    public ResponseEntity<?> searchSchedules(
            @RequestParam String startLocation,
            @RequestParam String endLocation,
            @RequestParam String date) {
        try {
            List<ScheduleResponseDto> schedules = scheduleService.searchSchedules(startLocation, endLocation, date);
            if (schedules.isEmpty()) {
                return ResponseEntity.ok(Collections.emptyList()); // Send empty list, not an error
            }
            return ResponseEntity.ok(schedules);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error searching schedules: " + e.getMessage());
        }
    }
}
