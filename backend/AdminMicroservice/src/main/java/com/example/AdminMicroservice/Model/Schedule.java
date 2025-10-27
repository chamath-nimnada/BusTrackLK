package com.example.AdminMicroservice.Model;

public class Schedule {

    private String id; // Firestore document ID
    private String scheduleDate;
    private String scheduleTime;
    private String busNumber;
    private String adminName;

    public Schedule() {}

    public Schedule(String id, String scheduleDate, String scheduleTime, String busNumber, String adminName) {
        this.id = id;
        this.scheduleDate = scheduleDate;
        this.scheduleTime = scheduleTime;
        this.busNumber = busNumber;
        this.adminName = adminName;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getScheduleDate() { return scheduleDate; }
    public void setScheduleDate(String scheduleDate) { this.scheduleDate = scheduleDate; }
    public String getScheduleTime() { return scheduleTime; }
    public void setScheduleTime(String scheduleTime) { this.scheduleTime = scheduleTime; }
    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }
    public String getAdminName() { return adminName; }
    public void setAdminName(String adminName) { this.adminName = adminName; }
}
