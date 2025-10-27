package com.example.AdminMicroservice.Service;

import com.example.AdminMicroservice.Model.LostItemReport;
import com.example.AdminMicroservice.Repository.LostItemReportRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class LostItemReportService {

    @Autowired
    private LostItemReportRepository lostItemReportRepository;

    public List<LostItemReport> getAllLostItemReports() throws ExecutionException, InterruptedException {
        return lostItemReportRepository.getAllLostItemReports();
    }
}
