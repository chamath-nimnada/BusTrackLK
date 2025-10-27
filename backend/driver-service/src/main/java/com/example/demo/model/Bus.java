package com.example.demo.model;

import java.util.Date; // We need this for the registration date

// This class is a "blueprint" for the data we will save
// in the "buses" collection in Firestore.
public class Bus {

    private String busNum;
    private String routeNo;
    private String username; // You mentioned this field
    private Date registeredDate; // We will set this to the current time

    // Getters and Setters for all fields

    public String getBusNum() {
        return busNum;
    }

    public void setBusNum(String busNum) {
        this.busNum = busNum;
    }

    public String getRouteNo() {
        return routeNo;
    }

    public void setRouteNo(String routeNo) {
        this.routeNo = routeNo;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getRegisteredDate() {
        return registeredDate;
    }

    public void setRegisteredDate(Date registeredDate) {
        this.registeredDate = registeredDate;
    }
}
