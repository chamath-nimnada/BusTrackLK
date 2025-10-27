package com.example.AdminMicroservice.Service;

import com.example.AdminMicroservice.Model.Schedule;
import com.example.AdminMicroservice.Repository.ScheduleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ScheduleService {

    @Autowired
    private ScheduleRepository scheduleRepository;

    public String addSchedule(Schedule schedule) throws Exception {
        return scheduleRepository.addSchedule(schedule);
    }

    public void updateSchedule(Schedule schedule) throws Exception {
        scheduleRepository.updateSchedule(schedule);
    }
}
