package com.example.AdminMicroservice.Service;

import com.example.AdminMicroservice.Model.Booking;
import com.example.AdminMicroservice.Repository.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    public List<Booking> getAllBookings() throws ExecutionException, InterruptedException {
        return bookingRepository.getAllBookings();
    }
}
