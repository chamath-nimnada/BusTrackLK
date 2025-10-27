package com.example.AdminMicroservice.Controller;

import com.example.AdminMicroservice.Model.Schedule;
import com.example.AdminMicroservice.Service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/schedules")
public class ScheduleController {

    @Autowired
    private ScheduleService scheduleService;

    @PostMapping("/add")
    public ResponseEntity<String> addSchedule(@RequestBody Schedule schedule) {
        try {
            String id = scheduleService.addSchedule(schedule);
            return ResponseEntity.ok("Schedule added successfully with ID: " + id);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Failed to add schedule: " + e.getMessage());
        }
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateSchedule(@PathVariable String id, @RequestBody Schedule schedule) {
        try {
            schedule.setId(id); // set the ID from the URL
            scheduleService.updateSchedule(schedule);
            return ResponseEntity.ok("✅ Schedule updated successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("❌ Failed to update schedule: " + e.getMessage());
        }
    }
}
