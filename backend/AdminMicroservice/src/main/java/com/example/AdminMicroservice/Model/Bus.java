package com.example.AdminMicroservice.Model;

public class Bus {
    private String id;              // Firestore document ID
    private String registeredDate;  // Registered date of the bus
    private String busNo;           // Bus number
    private String routeNo;         // Route number

    public Bus() {}

    public Bus(String id, String registeredDate, String busNo, String routeNo) {
        this.id = id;
        this.registeredDate = registeredDate;
        this.busNo = busNo;
        this.routeNo = routeNo;
    }

    // Getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getRegisteredDate() { return registeredDate; }
    public void setRegisteredDate(String registeredDate) { this.registeredDate = registeredDate; }

    public String getBusNo() { return busNo; }
    public void setBusNo(String busNo) { this.busNo = busNo; }

    public String getRouteNo() { return routeNo; }
    public void setRouteNo(String routeNo) { this.routeNo = routeNo; }
}
