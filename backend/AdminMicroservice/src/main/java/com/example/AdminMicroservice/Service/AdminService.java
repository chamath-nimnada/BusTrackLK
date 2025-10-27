package com.example.AdminMicroservice.Service;

import com.example.AdminMicroservice.Model.Admin;
import com.example.AdminMicroservice.Repository.AdminRepository;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;

@Service
public class AdminService {
    private final AdminRepository adminRepository;
    private static final String COLLECTION_NAME = "admins";

    public AdminService(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }



    public Admin addAdmin(Admin admin) throws Exception {
        // Step 1: Create Firebase Auth user
        UserRecord.CreateRequest request = new UserRecord.CreateRequest()
                .setEmail(admin.getUsername() + "@example.com") // using username as email base
                .setPassword(admin.getPassword())
                .setDisplayName(admin.getName())
                .setDisabled(false);

        UserRecord userRecord = FirebaseAuth.getInstance().createUser(request);

        // Step 2: Set the Firebase UID as document ID
        admin.setId(userRecord.getUid());

        // Step 3: Save in Firestore
        adminRepository.saveAdmin(admin);

        return admin;
    }

    public String updateAdmin(Admin admin) throws ExecutionException, InterruptedException {
        // If adminStatus is empty, you can optionally keep existing or set default
        if (admin.getAdminStatus() == null || admin.getAdminStatus().isEmpty()) {
            admin.setAdminStatus("pending");
        }
        return adminRepository.saveOrUpdate(admin);
    }
}
