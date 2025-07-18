package com.sam.career_connect.service;

import com.sam.career_connect.common.Role;
import com.sam.career_connect.entity.Job;
import com.sam.career_connect.entity.Recruiter;
import com.sam.career_connect.entity.User;
import com.sam.career_connect.repository.JobRepository;
import com.sam.career_connect.repository.RecruiterRepository;
import com.sam.career_connect.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecruiterService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RecruiterRepository recruiterRepository;

    @Autowired
    private JobRepository jobRepository;

    public Recruiter validateRecruiter(String email, String password) {
        User user = userRepository.findByEmailAndPassword(email,password).orElse(null);
        if(user==null){
            return null;
        }
        else if(user.getRole().equals(Role.RECRUITER)){
            return user.getRecruiter();
        }
        return null;
    }

    public Recruiter getRecruiter(Long recruiterId) {
    return recruiterRepository.getById(recruiterId);
    }

    public List<Job> getJobs(Long recruiterId) {
        return jobRepository.findAllByRecruiterId(recruiterId);
    }
}
