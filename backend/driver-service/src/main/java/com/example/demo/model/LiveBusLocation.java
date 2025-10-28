package com.example.demo.model;

import com.google.cloud.firestore.GeoPoint;
import com.google.cloud.firestore.annotation.ServerTimestamp;
import java.util.Date;

// This object will be stored in the 'live_bus_locations' collection
// The document ID will be the driver's UID
public class LiveBusLocation {

    private String driverUid;
    private String driverName;
    private String busNo;
    private String routeNo;
    private GeoPoint location; // The bus's current GPS location

    @ServerTimestamp // Automatically sets the time on the server
    private Date lastUpdated;

    // Getters and Setters

    public String getDriverUid() {
        return driverUid;
    }

    public void setDriverUid(String driverUid) {
        this.driverUid = driverUid;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getBusNo() {
        return busNo;
    }

    public void setBusNo(String busNo) {
        this.busNo = busNo;
    }

    public String getRouteNo() {
        return routeNo;
    }

    public void setRouteNo(String routeNo) {
        this.routeNo = routeNo;
    }

    public GeoPoint getLocation() {
        return location;
    }

    public void setLocation(GeoPoint location) {
        this.location = location;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
}