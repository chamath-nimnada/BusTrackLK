package com.example.demo.model;

import com.google.cloud.firestore.annotation.IgnoreExtraProperties;
import java.util.Date;

@IgnoreExtraProperties
public class Trip {
    private String assignedRouteID;
    private String busID;
    private String driverID;
    private String status;
    private int totalSeats;
    private int availableSeats;
    private Date departureTimestamp;
    private Date arrivalTimestamp;

    // Getters and Setters
    public String getAssignedRouteID() { return assignedRouteID; }
    public void setAssignedRouteID(String assignedRouteID) { this.assignedRouteID = assignedRouteID; }
    public String getBusID() { return busID; }
    public void setBusID(String busID) { this.busID = busID; }
    public String getDriverID() { return driverID; }
    public void setDriverID(String driverID) { this.driverID = driverID; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public int getTotalSeats() { return totalSeats; }
    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }
    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }
    public Date getDepartureTimestamp() { return departureTimestamp; }
    public void setDepartureTimestamp(Date departureTimestamp) { this.departureTimestamp = departureTimestamp; }
    public Date getArrivalTimestamp() { return arrivalTimestamp; }
    public void setArrivalTimestamp(Date arrivalTimestamp) { this.arrivalTimestamp = arrivalTimestamp; }
}