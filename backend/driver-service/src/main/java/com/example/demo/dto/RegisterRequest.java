package com.example.demo.dto;

// This class is a "blueprint" for the JSON data our Flutter app will send
// when a driver clicks the "Register" button.
public class RegisterRequest {

    // Fields from your Flutter UI
    private String email; // We use email, not username
    private String password;
    private String phoneNo;
    private String nic;
    private String busNo;
    private String routeNo;

    // --- GETTERS AND SETTERS (These were missing) ---
    // Spring Boot uses these to automatically read the JSON data

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() { // <-- ADDED
        return password;
    }

    public void setPassword(String password) { // <-- ADDED
        this.password = password;
    }

    public String getPhoneNo() { // <-- ADDED
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) { // <-- ADDED
        this.phoneNo = phoneNo;
    }

    public String getNic() { // <-- ADDED
        return nic;
    }

    public void setNic(String nic) { // <-- ADDED
        this.nic = nic;
    }

    public String getBusNo() { // <-- ADDED
        return busNo;
    }

    public void setBusNo(String busNo) { // <-- ADDED
        this.busNo = busNo;
    }

    public String getRouteNo() { // <-- ADDED
        return routeNo;
    }

    public void setRouteNo(String routeNo) { // <-- ADDED
        this.routeNo = routeNo;
    }
    // --- END OF GETTERS AND SETTERS ---
}

