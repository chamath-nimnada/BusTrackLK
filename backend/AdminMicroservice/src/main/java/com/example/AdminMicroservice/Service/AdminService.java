package com.example.AdminMicroservice.Service;

import com.example.AdminMicroservice.Model.Admin;
import com.example.AdminMicroservice.Repository.AdminRepository;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.UUID;
import java.util.concurrent.ExecutionException;

@Service
public class AdminService {
    private final AdminRepository adminRepository;
    private static final String COLLECTION_NAME = "admins";

    public AdminService(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }



    public String createAdmin(Admin admin) throws FirebaseAuthException, ExecutionException, InterruptedException {
        // 1. Generate a unique ID for Firestore document if not provided
        if (admin.getId() == null || admin.getId().isEmpty()) {
            admin.setId(UUID.randomUUID().toString());
        }

        // 2. Create user in Firebase Authentication
        UserRecord.CreateRequest request = new UserRecord.CreateRequest()
                .setEmail(admin.getEmail())
                .setEmailVerified(false)
                .setPassword(admin.getPassword())
                .setDisplayName(admin.getUsername());

        UserRecord userRecord = FirebaseAuth.getInstance().createUser(request);

        // Optional: you can set the UID in your Firestore document
        admin.setId(userRecord.getUid());

        // 3. Save admin details in Firestore
        return adminRepository.save(admin);
    }

    public String updateAdmin(Admin admin) throws ExecutionException, InterruptedException {
        // If adminStatus is empty, you can optionally keep existing or set default
        if (admin.getAdminStatus() == null || admin.getAdminStatus().isEmpty()) {
            admin.setAdminStatus("pending");
        }
        return adminRepository.saveOrUpdate(admin);
    }
}
