package com.example.demo.tracking.service;

import com.example.demo.tracking.dto.LiveBusLocationDto;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.GeoPoint;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class TrackingService {

    private static final String COLLECTION_NAME = "live_bus_locations";

    /**
     * Finds live buses based on a route number.
     * In a real app, you would convert start/end locations to a route number.
     * For simplicity, we'll just query by the route number string.
     */
    public List<LiveBusLocationDto> findLiveBuses(String routeNo)
            throws ExecutionException, InterruptedException {

        Firestore db = FirestoreClient.getFirestore();
        List<LiveBusLocationDto> liveBuses = new ArrayList<>();

        // Create a query against the 'live_bus_locations' collection
        ApiFuture<QuerySnapshot> future = db.collection(COLLECTION_NAME)
                .whereEqualTo("routeNo", routeNo)
                .get();

        // future.get() blocks until the documents are retrieved
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        for (QueryDocumentSnapshot document : documents) {
            liveBuses.add(new LiveBusLocationDto(
                    document.getString("driverUid"),
                    document.getString("driverName"),
                    document.getString("busNo"),
                    document.getString("routeNo"),
                    document.getGeoPoint("location"),
                    document.getDate("lastUpdated")
            ));
        }

        return liveBuses;
    }

    /**
     * Finds ALL live buses. Useful for the "Map View" to show all nearby buses
     * (filtering by "nearby" should ideally be done in the query, but
     * for simplicity we return all and let the app filter).
     */
    public List<LiveBusLocationDto> findAllLiveBuses()
            throws ExecutionException, InterruptedException {

        Firestore db = FirestoreClient.getFirestore();
        List<LiveBusLocationDto> liveBuses = new ArrayList<>();

        ApiFuture<QuerySnapshot> future = db.collection(COLLECTION_NAME).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        for (QueryDocumentSnapshot document : documents) {
            liveBuses.add(new LiveBusLocationDto(
                    document.getString("driverUid"),
                    document.getString("driverName"),
                    document.getString("busNo"),
                    document.getString("routeNo"),
                    document.getGeoPoint("location"),
                    document.getDate("lastUpdated")
            ));
        }

        return liveBuses;
    }
}