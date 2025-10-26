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
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.concurrent.ExecutionException;

@Service // Marks this class as a Spring Service
public class AuthService {

    /**
     * Registers a new driver using Firebase Authentication and saves their details
     * to Firestore collections 'driver' and 'buses'.
     *
     * @param registerRequest DTO containing registration details (email, password, etc.)
     * @return The UID of the newly created Firebase user.
     * @throws FirebaseAuthException If Firebase Auth fails (e.g., email already exists).
     * @throws ExecutionException    If Firestore operations fail.
     * @throws InterruptedException  If Firestore operations are interrupted.
     */
    public String registerUser(RegisterRequest registerRequest)
            throws FirebaseAuthException, ExecutionException, InterruptedException {

        // --- OPERATION 1: Create the user in Firebase Authentication ---
        FirebaseAuth auth = FirebaseAuth.getInstance();
        UserRecord.CreateRequest createRequest = new UserRecord.CreateRequest()
                .setEmail(registerRequest.getEmail()) // Use email
                .setPassword(registerRequest.getPassword())
                .setDisplayName(registerRequest.getNic()); // Using NIC as display name for Firebase Auth

        ApiFuture<UserRecord> userRecordFuture = auth.createUserAsync(createRequest);
        UserRecord userRecord = userRecordFuture.get(); // Wait for completion
        String uid = userRecord.getUid();
        System.out.println("Successfully created new Firebase Auth user: " + uid);

        // --- OPERATION 2: Save the Driver details to the "driver" collection ---
        Firestore db = FirestoreClient.getFirestore();
        Driver driver = new Driver();
        driver.setUid(uid); // Link Firestore doc to Auth user
        driver.setEmail(registerRequest.getEmail());
        driver.setPhoneNo(registerRequest.getPhoneNo());
        driver.setNic(registerRequest.getNic());
        driver.setBusNo(registerRequest.getBusNo());
        driver.setBusRoute(registerRequest.getRouteNo());
        // Note: Credit score is likely calculated/assigned later, not during registration

        ApiFuture<WriteResult> driverWriteFuture = db.collection("driver").document(uid).set(driver);
        driverWriteFuture.get(); // Wait for completion
        System.out.println("Saved new driver to Firestore 'driver' collection at doc ID: " + uid);

        // --- OPERATION 3: Save the Bus details to the "buses" collection ---
        Bus bus = new Bus();
        bus.setBusNum(registerRequest.getBusNo());
        bus.setRouteNo(registerRequest.getRouteNo());
        bus.setUsername(registerRequest.getEmail()); // Using email as username reference
        bus.setRegisteredDate(new Date()); // Record the current time

        ApiFuture<com.google.cloud.firestore.DocumentReference> busAddFuture = db.collection("buses").add(bus);
        busAddFuture.get(); // Wait for completion
        System.out.println("Saved new bus to Firestore 'buses' collection");

        return uid; // Return the UID of the created user
    }


    /**
     * Verifies a Firebase ID Token provided by the client and fetches the corresponding
     * driver details from the Firestore 'driver' collection.
     *
     * @param loginRequest DTO containing the Firebase ID Token.
     * @return A LoginResponse DTO containing the driver's details.
     * @throws FirebaseAuthException If the ID Token is invalid or expired.
     * @throws ExecutionException    If Firestore operations fail.
     * @throws InterruptedException  If Firestore operations are interrupted.
     * @throws RuntimeException      If driver data is not found in Firestore for the verified UID.
     */
    public LoginResponse loginUser(LoginRequest loginRequest)
            throws FirebaseAuthException, ExecutionException, InterruptedException {

        // --- OPERATION 1: Verify the ID Token with Firebase Authentication ---
        FirebaseAuth auth = FirebaseAuth.getInstance();
        String idToken = loginRequest.getIdToken();
        if (idToken == null || idToken.isEmpty()) {
            throw new IllegalArgumentException("ID token must not be empty.");
        }

        ApiFuture<FirebaseToken> verifiedTokenFuture = auth.verifyIdTokenAsync(idToken);
        FirebaseToken decodedToken = verifiedTokenFuture.get(); // Wait for verification
        String uid = decodedToken.getUid();
        System.out.println("Successfully verified ID Token for user UID: " + uid);

        // --- OPERATION 2: Fetch the Driver data from Firestore using the UID ---
        Firestore db = FirestoreClient.getFirestore();
        ApiFuture<DocumentSnapshot> driverDocFuture = db.collection("driver").document(uid).get();
        DocumentSnapshot driverDocument = driverDocFuture.get(); // Wait for data retrieval

        if (driverDocument.exists()) {
            // Convert the Firestore document data into our Java Driver object
            Driver driver = driverDocument.toObject(Driver.class);
            if (driver == null) {
                // This should ideally not happen if the document exists
                throw new RuntimeException("Failed to convert Firestore document to Driver object for UID: " + uid);
            }
            System.out.println("Successfully fetched driver data for email: " + driver.getEmail());

            // Safely get the creditScore from the document, defaulting to 0.0 if it doesn't exist or isn't a number
            double creditScore = 0.0;
            if (driverDocument.contains("creditScore") && driverDocument.get("creditScore") instanceof Number) {
                // Use getDouble() for safer number handling
                creditScore = driverDocument.getDouble("creditScore");
            } else {
                System.out.println("Credit score not found or invalid type for UID: " + uid + ", defaulting to 0.0");
            }


            // --- OPERATION 3: Create and return the LoginResponse DTO ---
            // Package the fetched data into the response object for the client
            return new LoginResponse(
                    driver.getEmail(),
                    driver.getPhoneNo(),
                    driver.getNic(),
                    driver.getBusNo(),
                    driver.getBusRoute(),
                    creditScore // Use the safely retrieved score
            );
        } else {
            // If the driver document doesn't exist for this UID, the data is inconsistent
            System.err.println("Error: No driver document found in Firestore for verified UID: " + uid);
            throw new RuntimeException("Driver data not found in database for user: " + uid);
        }
    }
}

