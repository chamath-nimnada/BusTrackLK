package com.example.demo.tracking.dto;

import com.google.cloud.firestore.GeoPoint;
import java.util.Date;

public class LiveBusLocationDto {

    private String driverUid;
    private String driverName;
    private String busNo;
    private String routeNo;
    private GeoPoint location;
    private Date lastUpdated;

    // Constructor
    public LiveBusLocationDto(String driverUid, String driverName, String busNo, String routeNo, GeoPoint location, Date lastUpdated) {
        this.driverUid = driverUid;
        this.driverName = driverName;
        this.busNo = busNo;
        this.routeNo = routeNo;
        this.location = location;
        this.lastUpdated = lastUpdated;
    }

    // Getters and Setters
    public String getDriverUid() { return driverUid; }
    public void setDriverUid(String driverUid) { this.driverUid = driverUid; }
    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }
    public String getBusNo() { return busNo; }
    public void setBusNo(String busNo) { this.busNo = busNo; }
    public String getRouteNo() { return routeNo; }
    public void setRouteNo(String routeNo) { this.routeNo = routeNo; }
    public GeoPoint getLocation() { return location; }
    public void setLocation(GeoPoint location) { this.location = location; }
    public Date getLastUpdated() { return lastUpdated; }
    public void setLastUpdated(Date lastUpdated) { this.lastUpdated = lastUpdated; }
}