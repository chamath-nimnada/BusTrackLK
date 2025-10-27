package com.example.AdminMicroservice.Repository;

import com.example.AdminMicroservice.Model.Driver;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.CollectionReference;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Repository
public class DriverRepository {

    private static final String COLLECTION_NAME = "drivers";

    public String saveDriver(Driver driver) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        CollectionReference collection = db.collection(COLLECTION_NAME);

        DocumentReference docRef = (driver.getId() == null || driver.getId().isEmpty())
                ? collection.document() // auto-generate ID
                : collection.document(driver.getId());

        ApiFuture<WriteResult> future = docRef.set(driver);
        future.get(); // Wait for write
        return docRef.getId();
    }

    private static final String COLLECTION_NAME2 = "driver"; // Firestore collection name

    public String updateDriverStatus(String driverId, String newStatus) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference docRef = db.collection(COLLECTION_NAME2).document(driverId);

        Map<String, Object> updates = new HashMap<>();
        updates.put("status", newStatus);

        ApiFuture<WriteResult> writeResult = docRef.update(updates);
        return "✅ Driver status updated at: " + writeResult.get().getUpdateTime();
    }
}
