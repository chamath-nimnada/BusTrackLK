package com.example.demo.service;

import com.example.demo.dto.LoginRequest;
import com.example.demo.dto.LoginResponse;
import com.example.demo.dto.RegisterRequest;
import com.example.demo.model.Bus;
import com.example.demo.model.Driver;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.http.HttpStatus; // <-- Import HttpStatus
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException; // <-- Import ResponseStatusException

import java.util.Date;
import java.util.concurrent.ExecutionException;

@Service
public class AuthService {

    // --- registerUser method ---
    public String registerUser(RegisterRequest registerRequest)
            throws FirebaseAuthException, ExecutionException, InterruptedException {
        FirebaseAuth auth = FirebaseAuth.getInstance();
        UserRecord.CreateRequest createRequest = new UserRecord.CreateRequest()
                .setEmail(registerRequest.getEmail())
                .setPassword(registerRequest.getPassword())
                .setDisplayName(registerRequest.getNic());

        ApiFuture<UserRecord> userRecordFuture = auth.createUserAsync(createRequest);
        UserRecord userRecord = userRecordFuture.get();
        String uid = userRecord.getUid();
        System.out.println("Successfully created new Firebase Auth user: " + uid);

        Firestore db = FirestoreClient.getFirestore();
        Driver driver = new Driver();
        driver.setUid(uid);
        driver.setEmail(registerRequest.getEmail());
        driver.setPhoneNo(registerRequest.getPhoneNo());
        driver.setNic(registerRequest.getNic());
        driver.setBusNo(registerRequest.getBusNo());
        driver.setBusRoute(registerRequest.getRouteNo());
        // --- 1. SET INITIAL STATUS TO PENDING ---
        driver.setStatus("pending");

        ApiFuture<WriteResult> driverWriteFuture = db.collection("driver").document(uid).set(driver);
        driverWriteFuture.get();
        System.out.println("Saved new driver to Firestore 'driver' collection with status 'pending'. Doc ID: " + uid);

        // --- (Bus details saving remains the same) ---
        Bus bus = new Bus();
        bus.setBusNum(registerRequest.getBusNo());
        bus.setRouteNo(registerRequest.getRouteNo());
        bus.setUsername(registerRequest.getEmail());
        bus.setRegisteredDate(new Date());

        ApiFuture<com.google.cloud.firestore.DocumentReference> busAddFuture = db.collection("buses").add(bus);
        busAddFuture.get();
        System.out.println("Saved new bus to Firestore 'buses' collection");

        return uid;
    }

    // --- loginUser method ---
    public LoginResponse loginUser(LoginRequest loginRequest)
            throws FirebaseAuthException, ExecutionException, InterruptedException {

        FirebaseAuth auth = FirebaseAuth.getInstance();
        String idToken = loginRequest.getIdToken();
        if (idToken == null || idToken.isEmpty()) {
            throw new IllegalArgumentException("ID token must not be empty.");
        }

        ApiFuture<FirebaseToken> verifiedTokenFuture = auth.verifyIdTokenAsync(idToken);
        FirebaseToken decodedToken = verifiedTokenFuture.get();
        String uid = decodedToken.getUid();
        System.out.println("Successfully verified ID Token for user UID: " + uid);

        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<DocumentSnapshot> driverDocFuture = db.collection("driver").document(uid).get();
        DocumentSnapshot driverDocument = driverDocFuture.get();

        if (driverDocument.exists()) {
            Driver driver = driverDocument.toObject(Driver.class);
            if (driver == null) {
                // This case might indicate Firestore data inconsistency after successful auth
                System.err.println("Error: Driver document exists but failed conversion for UID: " + uid);
                throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Driver data corrupted.");
            }

            // --- 2. CHECK DRIVER STATUS ---
            String currentStatus = driver.getStatus();
            if (!"approved".equalsIgnoreCase(currentStatus)) {
                System.out.println("Login attempt failed for UID: " + uid + ". Status is: " + currentStatus);
                // Throw a specific exception for pending/rejected accounts
                // Using ResponseStatusException sends a proper HTTP status code (403 Forbidden)
                throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Account not approved. Status: " + (currentStatus != null ? currentStatus : "Unknown"));
            }
            // --- END STATUS CHECK ---

            System.out.println("Driver status is 'approved'. Proceeding with login for UID: " + uid);

            // --- (Credit score calculation remains the same) ---
            double creditScore = 0.0;
            if (driverDocument.contains("creditScore") && driverDocument.get("creditScore") instanceof Number) {
                creditScore = driverDocument.getDouble("creditScore");
            } else {
                System.out.println("Credit score not found or invalid type for UID: " + uid + ", defaulting to 0.0");
            }

            // Return LoginResponse only if status is "approved"
            return new LoginResponse(
                    uid,
                    driver.getEmail(),
                    driver.getPhoneNo(),
                    driver.getNic(),
                    driver.getBusNo(),
                    driver.getBusRoute(),
                    creditScore
            );
        } else {
            // This means Firebase Auth user exists, but no corresponding Firestore 'driver' doc
            System.err.println("Error: No driver document found in Firestore for verified UID: " + uid);
            // This could be treated as an internal error or maybe unauthorized
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Driver data not found in database.");
        }
    }
}