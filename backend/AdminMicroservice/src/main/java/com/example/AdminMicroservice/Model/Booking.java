package com.example.AdminMicroservice.Model;

public class Booking {

    private String bookingID;
    private String date;
    private String customerName;
    private String startLocation;
    private String endLocation;
    private int noOfSeats;
    private double price;

    // Default constructor
    public Booking() {}

    // All-args constructor
    public Booking(String bookingID, String date, String customerName, String startLocation, String endLocation, int noOfSeats, double price) {
        this.bookingID = bookingID;
        this.date = date;
        this.customerName = customerName;
        this.startLocation = startLocation;
        this.endLocation = endLocation;
        this.noOfSeats = noOfSeats;
        this.price = price;
    }

    // Getters and setters
    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getStartLocation() {
        return startLocation;
    }

    public void setStartLocation(String startLocation) {
        this.startLocation = startLocation;
    }

    public String getEndLocation() {
        return endLocation;
    }

    public void setEndLocation(String endLocation) {
        this.endLocation = endLocation;
    }

    public int getNoOfSeats() {
        return noOfSeats;
    }

    public void setNoOfSeats(int noOfSeats) {
        this.noOfSeats = noOfSeats;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
