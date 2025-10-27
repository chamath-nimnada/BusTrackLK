package com.example.AdminMicroservice.Config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import jakarta.annotation.PostConstruct;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;
import java.io.InputStream;

@Configuration
public class FirebaseConfig {

    @PostConstruct
    public void initializeFirebase() {
        try (InputStream serviceAccount = getClass().getClassLoader()
                .getResourceAsStream("serviceAccountKey.json")) {

            if (serviceAccount == null) {
                throw new RuntimeException("serviceAccountKey.json not found in resources!");
            }

            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
                System.out.println("✅ Firebase initialized successfully.");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
