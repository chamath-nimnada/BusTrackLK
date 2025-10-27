package com.example.AdminMicroservice.Service;

import com.example.AdminMicroservice.Model.Bus;
import com.example.AdminMicroservice.Repository.BusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BusService {

    @Autowired
    private BusRepository busRepository;

    public String addBus(Bus bus) throws Exception {
        return busRepository.addBus(bus);
    }
}
