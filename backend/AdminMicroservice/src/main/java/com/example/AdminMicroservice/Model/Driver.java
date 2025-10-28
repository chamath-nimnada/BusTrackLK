package com.example.AdminMicroservice.Model;

public class Driver {

    private String busNo;
    private String busRoute;
    private String email;
    private String nic;
    private String phoneNo;
    private String status;
    private String uid;

    // ✅ Default constructor (required for Firebase / serialization)
    public Driver() {
    }

    // ✅ Parameterized constructor
    public Driver(String busNo, String busRoute, String email, String nic, String phoneNo, String status, String uid) {
        this.busNo = busNo;
        this.busRoute = busRoute;
        this.email = email;
        this.nic = nic;
        this.phoneNo = phoneNo;
        this.status = status;
        this.uid = uid;
    }

    // ✅ Getters and Setters
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    // ✅ Optional: toString() for debugging
    @Override
    public String toString() {
        return "Driver{" +
                "busNo='" + busNo + '\'' +
                ", busRoute='" + busRoute + '\'' +
                ", email='" + email + '\'' +
                ", nic='" + nic + '\'' +
                ", phoneNo='" + phoneNo + '\'' +
                ", status='" + status + '\'' +
                ", uid='" + uid + '\'' +
                '}';
    }
}
