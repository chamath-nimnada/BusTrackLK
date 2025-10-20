package com.example.demo.auth.service;

import com.example.demo.auth.dto.RegisterRequestDto;
import com.example.demo.auth.model.User;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;

@Service
public class AuthService {

    @Autowired
    private FirebaseAuth firebaseAuth;

    public String registerUser(RegisterRequestDto registerRequest) throws FirebaseAuthException, ExecutionException, InterruptedException {
        // Step 1: Create user in Firebase Authentication
        UserRecord.CreateRequest request = new UserRecord.CreateRequest()
                .setEmail(registerRequest.getEmail())
                .setPassword(registerRequest.getPassword())
                .setDisplayName(registerRequest.getUserName());

        UserRecord userRecord = firebaseAuth.createUser(request);
        String userId = userRecord.getUid();

        // Step 2: Create user object to save in Firestore
        User user = new User();
        user.setUserName(registerRequest.getUserName());
        user.setEmail(registerRequest.getEmail());
        user.setBirthday(registerRequest.getBirthday());
        user.setContactNo(registerRequest.getContactNo());

        // Step 3: Save the user details in the "users" collection in Firestore
        Firestore dbFirestore = FirestoreClient.getFirestore();
        dbFirestore.collection("users").document(userId).set(user).get();

        return userId;
    }
}