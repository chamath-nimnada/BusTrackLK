package com.example.demo.lostitem.dto;

import jakarta.validation.constraints.NotBlank; // Use jakarta for validation

public class LostItemReportDto {

    // --- ADDED ---
    @NotBlank(message = "Your name is required")
    private String reporterName;
    // --- END ADDITION ---

    @NotBlank(message = "Contact number is required")
    private String contactNo;

    @NotBlank(message = "Item name is required")
    private String itemName;

    @NotBlank(message = "Bus/Route info is required")
    private String busRouteInfo;

    @NotBlank(message = "Date/Time lost is required")
    private String dateTimeLost;

    private String additionalInfo;

    // --- ADD Getters and Setters for reporterName ---
    public String getReporterName() { return reporterName; }
    public void setReporterName(String reporterName) { this.reporterName = reporterName; }
    // --- END ADDITION ---

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
}