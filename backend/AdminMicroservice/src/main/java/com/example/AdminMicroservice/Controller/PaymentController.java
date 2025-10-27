package com.example.AdminMicroservice.Controller;

import com.example.AdminMicroservice.Model.Payment;
import com.example.AdminMicroservice.Service.PaymentService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/payments")
@CrossOrigin("*")
public class PaymentController {

    private final PaymentService paymentService;

    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    // Get all payments
    @GetMapping("/all")
    public List<Payment> getAllPayments() throws ExecutionException, InterruptedException {
        return paymentService.getAllPayments();
    }

    // Get a specific payment by ID
    @GetMapping("/{id}")
    public Payment getPaymentById(@PathVariable String id) throws ExecutionException, InterruptedException {
        return paymentService.getPaymentById(id);
    }
}
