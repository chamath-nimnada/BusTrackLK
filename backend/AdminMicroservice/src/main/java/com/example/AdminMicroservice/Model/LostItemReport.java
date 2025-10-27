package com.example.AdminMicroservice.Model;

import java.util.Date;

public class LostItemReport {

    private String id; // Firestore document ID
    private String additionalInfo;
    private String busRouteInfo;
    private String contactNo;
    private Date createdAt;
    private String dateTimeLost;
    private String itemName;
    private String reportingUserID;
    private String status;

    public LostItemReport() {
    }

    public LostItemReport(String id, String additionalInfo, String busRouteInfo, String contactNo,
                          Date createdAt, String dateTimeLost, String itemName,
                          String reportingUserID, String status) {
        this.id = id;
        this.additionalInfo = additionalInfo;
        this.busRouteInfo = busRouteInfo;
        this.contactNo = contactNo;
        this.createdAt = createdAt;
        this.dateTimeLost = dateTimeLost;
        this.itemName = itemName;
        this.reportingUserID = reportingUserID;
        this.status = status;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getAdditionalInfo() { return additionalInfo; }
    public void setAdditionalInfo(String additionalInfo) { this.additionalInfo = additionalInfo; }

    public String getBusRouteInfo() { return busRouteInfo; }
    public void setBusRouteInfo(String busRouteInfo) { this.busRouteInfo = busRouteInfo; }

    public String getContactNo() { return contactNo; }
    public void setContactNo(String contactNo) { this.contactNo = contactNo; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getDateTimeLost() { return dateTimeLost; }
    public void setDateTimeLost(String dateTimeLost) { this.dateTimeLost = dateTimeLost; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public String getReportingUserID() { return reportingUserID; }
    public void setReportingUserID(String reportingUserID) { this.reportingUserID = reportingUserID; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
