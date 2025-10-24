package com.example.demo.lostitem.controller;

import com.example.demo.lostitem.dto.LostItemReportDto;
import com.example.demo.lostitem.service.LostItemService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/lost-items")
public class LostItemController {

    @Autowired
    private LostItemService lostItemService;

    @PostMapping("/report")
    public ResponseEntity<?> submitReport(@Valid @RequestBody LostItemReportDto reportDto) {
        try {
            // --- CHANGED: Call service without userId ---
            String docId = lostItemService.saveReport(reportDto);
            // --- END CHANGE ---
            return ResponseEntity.ok("Report submitted successfully with ID: " + docId);
        } catch (Exception e) {
            System.err.println("Error submitting lost item report: " + e.getMessage()); // Log error
            e.printStackTrace(); // Print stack trace for debugging
            return ResponseEntity.badRequest().body("Error submitting report: " + e.getMessage());
        }
    }
}
