package com.example.AdminMicroservice.Service;

import com.example.AdminMicroservice.Model.Driver;
import com.example.AdminMicroservice.Repository.DriverRepository;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;

@Service
public class DriverService {

    private final DriverRepository driverRepository;

    public DriverService(DriverRepository driverRepository) {
        this.driverRepository = driverRepository;
    }

    public String addDriver(Driver driver) throws ExecutionException, InterruptedException {
        // Set default driverStatus if missing
        if (driver.getDriverStatus() == null || driver.getDriverStatus().isEmpty()) {
            driver.setDriverStatus("pending");
        }
        return driverRepository.saveDriver(driver);
    }

    public String updateDriverStatus(String driverId, String newStatus) throws ExecutionException, InterruptedException {
        return driverRepository.updateDriverStatus(driverId, newStatus);
    }
}
