package com.example.AdminMicroservice.Controller;

import com.example.AdminMicroservice.Model.LostItemReport;
import com.example.AdminMicroservice.Service.LostItemReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/lostItemReports")
@CrossOrigin(origins = "*") // allow frontend access
public class LostItemReportController {

    @Autowired
    private LostItemReportService lostItemReportService;

    @GetMapping("/all")
    public ResponseEntity<List<LostItemReport>> getAllLostItemReports() {
        try {
            List<LostItemReport> reports = lostItemReportService.getAllLostItemReports();
            return ResponseEntity.ok(reports);
        } catch (ExecutionException | InterruptedException e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }
}
