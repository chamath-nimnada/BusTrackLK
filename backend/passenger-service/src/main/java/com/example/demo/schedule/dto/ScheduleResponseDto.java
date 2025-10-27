package com.example.demo.schedule.dto;

public class ScheduleResponseDto {
    private String route; // e.g., "Route 01"
    private String startLocation; // e.g., "Colombo"
    private String startTime; // e.g., "13.20 PM"
    private String endLocation; // e.g., "Kandy"
    private String endTime; // e.g., "15.30 PM"
    private String busNumber; // e.g., "NC-4578"

    // Getters and Setters
    public String getRoute() { return route; }
    public void setRoute(String route) { this.route = route; }
    public String getStartLocation() { return startLocation; }
    public void setStartLocation(String startLocation) { this.startLocation = startLocation; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }
    public String getEndLocation() { return endLocation; }
    public void setEndLocation(String endLocation) { this.endLocation = endLocation; }
    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }
    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }
}
