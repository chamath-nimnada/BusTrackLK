package com.example.AdminMicroservice.Controller;

import com.example.AdminMicroservice.Model.Bus;
import com.example.AdminMicroservice.Service.BusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/buses")
@CrossOrigin(origins = "http://localhost:5173")
public class BusController {

    @Autowired
    private BusService busService;

    @PostMapping("/add")
    @CrossOrigin(origins = "http://localhost:5173")
    public ResponseEntity<String> addBus(@RequestBody Bus bus) {
        try {
            String id = busService.addBus(bus);
            return ResponseEntity.ok("✅ Bus added successfully with ID: " + id);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("❌ Failed to add bus: " + e.getMessage());
        }
    }
}
