package com.example.AdminMicroservice.Model;

public class Driver {

    private String id; // Firestore document ID
    private String name;
    private int age;
    private String username;
    private String password;
    private String driverStatus;
    private String registrationDate;
    private String nic;

    public Driver() {}

    public Driver(String id, String name, int age, String username, String password, String driverStatus, String registrationDate, String nic) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.username = username;
        this.password = password;
        this.driverStatus = driverStatus;
        this.registrationDate = registrationDate;
        this.nic = nic;
    }

    // Getters and Setters

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getDriverStatus() { return driverStatus; }
    public void setDriverStatus(String driverStatus) { this.driverStatus = driverStatus; }

    public String getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(String registrationDate) { this.registrationDate = registrationDate; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }
}
