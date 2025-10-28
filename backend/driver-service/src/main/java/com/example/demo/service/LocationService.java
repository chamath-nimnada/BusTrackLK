package com.example.demo.service;

import com.example.demo.dto.LocationUpdateRequest;
import com.example.demo.model.LiveBusLocation;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;

@Service
public class LocationService {

    private static final String COLLECTION_NAME = "live_bus_locations";

    /**
     * Creates or updates the driver's live location in Firestore.
     * The document ID is the driver's UID for easy overwriting.
     */
    public void updateLocation(LocationUpdateRequest request)
            throws ExecutionException, InterruptedException {

        Firestore db = FirestoreClient.getFirestore();

        LiveBusLocation liveLocation = new LiveBusLocation();
        liveLocation.setDriverUid(request.getDriverUid());
        liveLocation.setDriverName(request.getDriverName());
        liveLocation.setBusNo(request.getBusNo());
        liveLocation.setRouteNo(request.getRouteNo());
        liveLocation.setLocation(request.getLocation());
        // lastUpdated will be set by @ServerTimestamp

        // Use the driver's UID as the document ID.
        // This makes it easy to 'set' (create or overwrite) the location.
        ApiFuture<WriteResult> future = db.collection(COLLECTION_NAME)
                .document(request.getDriverUid())
                .set(liveLocation);

        future.get(); // Wait for the write to complete
        System.out.println("Updated location for driver: " + request.getDriverUid());
    }

    /**
     * Deletes the driver's live location from Firestore when a journey ends.
     */
    public void stopLocationSharing(String driverUid)
            throws ExecutionException, InterruptedException {

        if (driverUid == null || driverUid.isEmpty()) {
            throw new IllegalArgumentException("Driver UID must be provided.");
        }

        Firestore db = FirestoreClient.getFirestore();

        ApiFuture<WriteResult> future = db.collection(COLLECTION_NAME)
                .document(driverUid)
                .delete();

        future.get(); // Wait for the delete to complete
        System.out.println("Removed live location for driver: " + driverUid);
    }
}