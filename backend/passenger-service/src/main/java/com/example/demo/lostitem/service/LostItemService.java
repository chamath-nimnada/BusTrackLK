package com.example.demo.lostitem.service;

import com.example.demo.lostitem.dto.LostItemReportDto;
import com.example.demo.model.LostItemReport; // Make sure model path is correct
import com.google.cloud.firestore.Firestore;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;

@Service
public class LostItemService {

    private final Firestore dbFirestore = FirestoreClient.getFirestore();

    // --- CHANGED: Removed userId parameter, uses DTO name ---
    public String saveReport(LostItemReportDto reportDto) throws ExecutionException, InterruptedException {
        LostItemReport report = new LostItemReport();
        report.setReporterName(reportDto.getReporterName()); // Use name from DTO
        // --- END CHANGE ---
        report.setContactNo(reportDto.getContactNo());
        report.setItemName(reportDto.getItemName());
        report.setBusRouteInfo(reportDto.getBusRouteInfo());
        report.setDateTimeLost(reportDto.getDateTimeLost());
        report.setAdditionalInfo(reportDto.getAdditionalInfo());
        // Status and createdAt are handled by the model/Firestore

        // Save to Firestore
        String docId = dbFirestore.collection("lostItemReports").add(report).get().getId();
        System.out.println("Saved lost item report with ID: " + docId); // Add log
        return docId;
    }
}
