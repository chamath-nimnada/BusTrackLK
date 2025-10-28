package com.example.demo.dto;

// Using Google's GeoPoint for Firestore compatibility
import com.google.cloud.firestore.GeoPoint;

public class LocationUpdateRequest {

    // This is the Firebase UID of the driver
    private String driverUid;
    private GeoPoint location; // com.google.cloud.firestore.GeoPoint
    private String routeNo;
    private String busNo;
    private String driverName; // Good to have for the passenger app

    // Getters and Setters

    public String getDriverUid() {
        return driverUid;
    }

    public void setDriverUid(String driverUid) {
        this.driverUid = driverUid;
    }

    public GeoPoint getLocation() {
        return location;
    }

    public void setLocation(GeoPoint location) {
        this.location = location;
    }

    public String getRouteNo() {
        return routeNo;
    }

    public void setRouteNo(String routeNo) {
        this.routeNo = routeNo;
    }

    public String getBusNo() {
        return busNo;
    }

    public void setBusNo(String busNo) {
        this.busNo = busNo;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }
}