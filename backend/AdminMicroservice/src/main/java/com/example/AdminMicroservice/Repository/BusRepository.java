package com.example.AdminMicroservice.Repository;

import com.example.AdminMicroservice.Model.Bus;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Repository;

import java.util.concurrent.ExecutionException;

@Repository
public class BusRepository {
    private static final String COLLECTION_NAME = "buses";

    public String addBus(Bus bus) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();

        // Create new document reference (auto ID)
        DocumentReference docRef = db.collection(COLLECTION_NAME).document();
        bus.setId(docRef.getId());

        ApiFuture<WriteResult> result = docRef.set(bus);
        result.get(); // Wait for completion

        return bus.getId();
    }
}
