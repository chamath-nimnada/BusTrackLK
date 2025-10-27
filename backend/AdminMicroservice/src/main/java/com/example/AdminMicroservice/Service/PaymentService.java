package com.example.AdminMicroservice.Service;

import com.example.AdminMicroservice.Model.Payment;
import com.example.AdminMicroservice.Repository.PaymentRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class PaymentService {

    private final PaymentRepository paymentRepository;

    public PaymentService(PaymentRepository paymentRepository) {
        this.paymentRepository = paymentRepository;
    }

    public List<Payment> getAllPayments() throws ExecutionException, InterruptedException {
        return paymentRepository.getAllPayments();
    }

    public Payment getPaymentById(String paymentID) throws ExecutionException, InterruptedException {
        return paymentRepository.getPaymentById(paymentID);
    }
}
