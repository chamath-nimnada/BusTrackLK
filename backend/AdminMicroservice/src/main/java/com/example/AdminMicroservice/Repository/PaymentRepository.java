package com.example.AdminMicroservice.Repository;

import com.example.AdminMicroservice.Model.Payment;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Repository
public class PaymentRepository {

    private static final String COLLECTION_NAME = "payments";

    // Fetch all payments
    public List<Payment> getAllPayments() throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = db.collection(COLLECTION_NAME).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Payment> payments = new ArrayList<>();
        for (QueryDocumentSnapshot doc : documents) {
            Payment payment = doc.toObject(Payment.class);
            payments.add(payment);
        }
        return payments;
    }

    // Fetch payment by ID
    public Payment getPaymentById(String paymentID) throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference docRef = db.collection(COLLECTION_NAME).document(paymentID);
        DocumentSnapshot document = docRef.get().get();
        if (document.exists()) {
            return document.toObject(Payment.class);
        } else {
            return null;
        }
    }
}
