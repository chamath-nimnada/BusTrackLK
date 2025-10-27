package com.example.demo.model;

// This class is a "blueprint" for the data we will save
// in the "driver" collection in Firestore.
public class Driver {

    // This will be the unique UID from Firebase Auth (e.g., "abc123xyz")
    private String uid;

    private String email;
    private String phoneNo;
    private String nic;
    private String busNo;
    private String busRoute; // Matches your collection field "Bus route"

    // --- 1. ADD STATUS FIELD ---
    private String status; // e.g., "pending", "approved", "rejected"

    // Getters and Setters for all fields

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getBusNo() {
        return busNo;
    }

    public void setBusNo(String busNo) {
        this.busNo = busNo;
    }

    public String getBusRoute() {
        return busRoute;
    }

    public void setBusRoute(String busRoute) {
        this.busRoute = busRoute;
    }

    // --- 2. ADD GETTER/SETTER FOR STATUS ---
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}