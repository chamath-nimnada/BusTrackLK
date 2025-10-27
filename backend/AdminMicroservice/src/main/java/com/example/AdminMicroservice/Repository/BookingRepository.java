package com.example.AdminMicroservice.Repository;

import com.example.AdminMicroservice.Model.Booking;
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
public class BookingRepository {

    private static final String COLLECTION_NAME = "bookings";

    public List<Booking> getAllBookings() throws ExecutionException, InterruptedException {
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = db.collection(COLLECTION_NAME).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Booking> bookings = new ArrayList<>();
        for (QueryDocumentSnapshot doc : documents) {
            Booking booking = doc.toObject(Booking.class);
            bookings.add(booking);
        }

        return bookings;
    }
}
