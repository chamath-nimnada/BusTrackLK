package com.example.AdminMicroservice.Repository;

import com.example.AdminMicroservice.Model.LostItemReport;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Repository
public class LostItemReportRepository {

    private static final String COLLECTION_NAME = "lostItemReports";

    // Fetch all lost item reports
    public List<LostItemReport> getAllLostItemReports() throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();

        ApiFuture<QuerySnapshot> future = db.collection(COLLECTION_NAME).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<LostItemReport> reports = new ArrayList<>();
        for (QueryDocumentSnapshot doc : documents) {
            LostItemReport report = doc.toObject(LostItemReport.class);
            report.setId(doc.getId()); // include document ID
            reports.add(report);
        }

        return reports;
    }
}
