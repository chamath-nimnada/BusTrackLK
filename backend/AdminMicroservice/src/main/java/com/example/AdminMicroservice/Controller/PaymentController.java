package com.example.AdminMicroservice.Controller;

import com.example.AdminMicroservice.Model.Payment;
import com.example.AdminMicroservice.Service.PaymentService;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/payments")
@CrossOrigin(origins = "http://localhost:5173")
public class PaymentController {

    private final PaymentService paymentService;

    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    // Get all payments
    @GetMapping("/all")
    @CrossOrigin(origins = "http://localhost:5173")
    public List<Payment> getAllPayments() throws ExecutionException, InterruptedException {
        return paymentService.getAllPayments();
    }

    // Get a specific payment by ID
    @GetMapping("/{id}")
    @CrossOrigin(origins = "http://localhost:5173")
    public Payment getPaymentById(@PathVariable String id) throws ExecutionException, InterruptedException {
        return paymentService.getPaymentById(id);
    }
}
