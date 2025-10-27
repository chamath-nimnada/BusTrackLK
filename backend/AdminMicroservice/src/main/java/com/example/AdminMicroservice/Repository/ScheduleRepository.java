package com.example.AdminMicroservice.Repository;

import com.example.AdminMicroservice.Model.Schedule;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Repository;

@Repository
public class ScheduleRepository {

    private static final String COLLECTION_NAME = "schedules";

    public String addSchedule(Schedule schedule) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        DocumentReference docRef = db.collection(COLLECTION_NAME).document();
        schedule.setId(docRef.getId());
        ApiFuture<WriteResult> result = docRef.set(schedule);
        result.get(); // wait for completion
        return schedule.getId();
    }

    // Update a schedule
    public void updateSchedule(Schedule schedule) throws Exception {
        Firestore db = FirestoreClient.getFirestore();

        if (schedule.getId() == null || schedule.getId().isEmpty()) {
            throw new IllegalArgumentException("Schedule ID is required for update!");
        }

        DocumentReference docRef = db.collection(COLLECTION_NAME).document(schedule.getId());
        ApiFuture<WriteResult> result = docRef.set(schedule); // Firestore set overwrites existing doc
        result.get(); // wait for completion
    }
}
