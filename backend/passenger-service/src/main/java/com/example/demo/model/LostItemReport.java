package com.example.demo.model;

import com.google.cloud.firestore.FieldValue;
import com.google.cloud.firestore.annotation.ServerTimestamp;
import java.util.Date;

public class LostItemReport {
    // --- CHANGED ---
    private String reporterName; // Name entered by the user
    // --- END CHANGE ---
    private String contactNo;
    private String itemName;
    private String busRouteInfo;
    private String dateTimeLost;
    private String additionalInfo;
    private String status = "Pending";
    @ServerTimestamp
    private Date createdAt;

    // --- UPDATE Getters and Setters ---
    public String getReporterName() { return reporterName; }
    public void setReporterName(String reporterName) { this.reporterName = reporterName; }
    // --- END UPDATE ---

    public String getContactNo() { return contactNo; }
    public void setContactNo(String contactNo) { this.contactNo = contactNo; }
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    public String getBusRouteInfo() { return busRouteInfo; }
    public void setBusRouteInfo(String busRouteInfo) { this.busRouteInfo = busRouteInfo; }
    public String getDateTimeLost() { return dateTimeLost; }
    public void setDateTimeLost(String dateTimeLost) { this.dateTimeLost = dateTimeLost; }
    public String getAdditionalInfo() { return additionalInfo; }
    public void setAdditionalInfo(String additionalInfo) { this.additionalInfo = additionalInfo; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}