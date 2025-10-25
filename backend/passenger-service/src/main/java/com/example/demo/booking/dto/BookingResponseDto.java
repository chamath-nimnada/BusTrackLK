package com.example.demo.booking.dto;

public class BookingResponseDto {
    private String tripId; // Needed to identify the trip for actual booking later
    private String route;
    private String startLocation; // From Route
    private String endLocation; // From Route
    private String departureTime;
    private String arrivalTime;
    private String busNumber;
    private String busType;
    private int availableSeats;

    // Getters and Setters for all fields
    public String getTripId() { return tripId; }
    public void setTripId(String tripId) { this.tripId = tripId; }
    public String getRoute() { return route; }
    public void setRoute(String route) { this.route = route; }
    public String getStartLocation() { return startLocation; }
    public void setStartLocation(String startLocation) { this.startLocation = startLocation; }
    public String getEndLocation() { return endLocation; }
    public void setEndLocation(String endLocation) { this.endLocation = endLocation; }
    public String getDepartureTime() { return departureTime; }
    public void setDepartureTime(String departureTime) { this.departureTime = departureTime; }
    public String getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(String arrivalTime) { this.arrivalTime = arrivalTime; }
    public String getBusNumber() { return busNumber; }
    public void setBusNumber(String busNumber) { this.busNumber = busNumber; }
    public String getBusType() { return busType; }
    public void setBusType(String busType) { this.busType = busType; }
    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }
}