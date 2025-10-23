package com.example.demo.model;

import com.google.cloud.firestore.annotation.IgnoreExtraProperties;
import java.util.Date;

@IgnoreExtraProperties
public class Bus {
    private String busNumber;
    private String ownerName;
    private String assignedRouteID;
    private int numberOfSeats;
    private Date registeredDate;

    // Getters and Setters
    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }
    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
    public String getAssignedRouteID() { return assignedRouteID; }
    public void setAssignedRouteID(String assignedRouteID) { this.assignedRouteID = assignedRouteID; }
    public int getNumberOfSeats() { return numberOfSeats; }
    public void setNumberOfSeats(int numberOfSeats) { this.numberOfSeats = numberOfSeats; }
    public Date getRegisteredDate() { return registeredDate; }
    public void setRegisteredDate(Date registeredDate) { this.registeredDate = registeredDate; }
}
