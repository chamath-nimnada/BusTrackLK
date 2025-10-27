package com.example.AdminMicroservice.Repository;

import com.example.AdminMicroservice.Model.Admin;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.CollectionReference;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Repository;

import java.util.concurrent.ExecutionException;

@Repository
public class AdminRepository {

    private static final String COLLECTION_NAME = "admins";

    public String saveAdmin(Admin admin) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> result = db.collection(COLLECTION_NAME)
                .document(admin.getId())
                .set(admin);
        return result.get().getUpdateTime().toString();
    }

    public String saveOrUpdate(Admin admin) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        CollectionReference collection = db.collection(COLLECTION_NAME);

        DocumentReference docRef = (admin.getId() == null || admin.getId().isEmpty())
                ? collection.document() // auto-generate ID if not present
                : collection.document(admin.getId());

        ApiFuture<WriteResult> future = docRef.set(admin);
        future.get(); // Wait until write completes
        return docRef.getId();
    }
}
