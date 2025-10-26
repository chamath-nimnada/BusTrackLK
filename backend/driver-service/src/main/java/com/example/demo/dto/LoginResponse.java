package com.example.demo.dto;

// This class is the blueprint for the JSON data our Java backend will send back
// to Flutter after verifying the ID Token and fetching driver data.
public class LoginResponse {

    // Fields matching your Flutter DriverInfo model (excluding uid)
    private String email;
    private String phoneNo;
    private String nic;
    private String busNo;
    private String busRoute;
    private double creditScore; // We added this field earlier

    // Constructor to easily create this object from our Driver model
    public LoginResponse(String email, String phoneNo, String nic, String busNo, String busRoute, double creditScore) {
        this.email = email;
        this.phoneNo = phoneNo;
        this.nic = nic;
        this.busNo = busNo;
        this.busRoute = busRoute;
        this.creditScore = creditScore;
    }

    // Getters (Setters are not strictly needed for the response)
    public String getEmail() { return email; }
    public String getPhoneNo() { return phoneNo; }
    public String getNic() { return nic; }
    public String getBusNo() { return busNo; }
    public String getBusRoute() { return busRoute; }
    public double getCreditScore() { return creditScore; }
}
