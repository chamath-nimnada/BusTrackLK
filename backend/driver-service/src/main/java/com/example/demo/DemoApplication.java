package com.example.demo;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource; // Import Resource

import java.io.FileNotFoundException; // Import FileNotFoundException
import java.io.IOException;
import java.io.InputStream;

@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) { // Remove 'throws IOException' for now

        // --- IMPROVED FIREBASE INIT CODE ---
        try {
            // 1. Define the path to your key file
            String firebaseKeyPath = "firebase-key.json";
            System.out.println("Attempting to load Firebase key from: " + firebaseKeyPath);

            // 2. Load the file as a Resource first to check existence
            Resource resource = new ClassPathResource(firebaseKeyPath);
            if (!resource.exists()) {
                // Throw specific error if file not found in resources
                throw new FileNotFoundException("Firebase key file not found at path: " + firebaseKeyPath);
            }

            // 3. Load the file as a stream
            InputStream serviceAccount = resource.getInputStream();
            System.out.println("Firebase key file loaded successfully.");

            // 4. Build the Firebase credentials
            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    // Optional: Specify database URL if needed (usually auto-detected)
                    // .setDatabaseUrl("https://<YOUR_PROJECT_ID>.firebaseio.com")
                    .build();

            // 5. Initialize the Firebase Admin SDK only if not already initialized
            if (FirebaseApp.getApps().isEmpty()) { // Check if already initialized
                FirebaseApp.initializeApp(options);
                System.out.println(">>>> Firebase has been initialized successfully! <<<<");
            } else {
                System.out.println(">>>> Firebase is already initialized. <<<<");
            }

        } catch (FileNotFoundException e) {
            // Catch specific file not found error
            System.err.println(">>>> CRITICAL ERROR: Could not find Firebase key file. <<<<");
            System.err.println("Make sure 'firebase-key.json' is directly inside 'src/main/resources'");
            System.err.println("Error details: " + e.getMessage());
            // Optionally exit if Firebase is critical
            // System.exit(1);
        } catch (IOException e) {
            // Catch general IO errors (reading file, network issues during init)
            System.err.println(">>>> CRITICAL ERROR: Failed to initialize Firebase. <<<<");
            System.err.println("Check the key file content and network connection.");
            e.printStackTrace(); // Print the full error stack trace
            // Optionally exit
            // System.exit(1);
        }
        // --- END OF IMPROVED FIREBASE INIT CODE ---


        // This line runs your Spring Boot application
        System.out.println("Starting Spring Boot application...");
        SpringApplication.run(DemoApplication.class, args);
    }
}

