package com.example.AdminMicroservice.Model;

public class Payment {
    private String PaymentID;
    private String PaymentDate;
    private String CustomerID;

    public Payment() {}

    public Payment(String paymentID, String paymentDate, String customerID) {
        this.PaymentID = paymentID;
        this.PaymentDate = paymentDate;
        this.CustomerID = customerID;
    }

    public String getPaymentID() {
        return PaymentID;
    }

    public void setPaymentID(String paymentID) {
        this.PaymentID = paymentID;
    }

    public String getPaymentDate() {
        return PaymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.PaymentDate = paymentDate;
    }

    public String getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(String customerID) {
        this.CustomerID = customerID;
    }
}
