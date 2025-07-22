package com.sam.career_connect.service;

import com.sam.career_connect.entity.Job;
import com.sam.career_connect.entity.Recruiter;
import com.sam.career_connect.repository.JobRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JobService {
    
    @Autowired
    private JobRepository jobRepository;

    public List<Job> getAllJobs() {
        return jobRepository.findAll();
    }

    public List<Job> searchJobs(String keyword) {
        return jobRepository.findByJobTitleContainingIgnoreCaseOrCompanyNameContainingIgnoreCaseOrJobLocationContainingIgnoreCase(
                keyword, keyword, keyword
        );
    }

    public Job getJobById(Long id) {
       return jobRepository.findById(id).orElse(null);
    }

    public void addJob(Job job, Recruiter recruiter) {
        job.setRecruiter(recruiter);
        jobRepository.save(job);
    }
}
