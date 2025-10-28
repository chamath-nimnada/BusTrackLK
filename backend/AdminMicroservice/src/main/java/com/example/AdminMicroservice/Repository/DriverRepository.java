package com.example.AdminMicroservice.Repository;

import com.example.AdminMicroservice.Model.Driver;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Repository
public class DriverRepository {

    private static final String COLLECTION_NAME = "driver";

    public String saveDriver(Driver driver) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        CollectionReference collection = db.collection(COLLECTION_NAME);

        DocumentReference docRef = (driver.getUid() == null || driver.getUid().isEmpty())
                ? collection.document() // auto-generate ID
                : collection.document(driver.getUid());

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

    public List<Driver> getAllDrivers() throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore(); // ✅ initialize Firestore
        List<Driver> driverList = new ArrayList<>();

        ApiFuture<QuerySnapshot> future = db.collection(COLLECTION_NAME).get(); // ✅ use db instead of firestore
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        for (QueryDocumentSnapshot doc : documents) {
            Driver driver = doc.toObject(Driver.class);
            driverList.add(driver);
        }
        return driverList;
    }

}
