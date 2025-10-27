package com.example.demo.dto;

// This is the DTO (Data Transfer Object) that is sent
// back to the Flutter app when a login is successful.
public class LoginResponse {

    private String uid; // Field for Firebase UID
    private String email;
    private String phoneNo;
    private String nic;
    private String busNo;
    private String busRoute;
    private double creditScore;

    // Constructor updated to accept 7 arguments
    public LoginResponse(String uid, String email, String phoneNo, String nic, String busNo, String busRoute, double creditScore) {
        this.uid = uid; // Assign uid
        this.email = email;
        this.phoneNo = phoneNo;
        this.nic = nic;
        this.busNo = busNo;
        this.busRoute = busRoute;
        this.creditScore = creditScore;
    }

    // Getter and Setter for UID
    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    // --- (Existing Getters and Setters) ---
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

    public double getCreditScore() {
        return creditScore;
    }

    public void setCreditScore(double creditScore) {
        this.creditScore = creditScore;
    }
}