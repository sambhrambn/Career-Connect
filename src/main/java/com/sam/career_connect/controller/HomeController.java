package com.sam.career_connect.controller;

import com.sam.career_connect.entity.Job;
import com.sam.career_connect.entity.User;
import com.sam.career_connect.repository.JobRepository;
import com.sam.career_connect.repository.RecruiterRepository;
import com.sam.career_connect.repository.StudentRepository;
import com.sam.career_connect.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/home")
public class HomeController {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private RecruiterRepository recruiterRepository;

    @Autowired
    private JobRepository jobRepository;

    @Autowired
    private UserRepository userRepository;

    @RequestMapping("/dashboard2")
    public String adminDashboard2( Model model){

            model.addAttribute("totalStudents", studentRepository.count());
            model.addAttribute("totalRecruiters", recruiterRepository.count());
            model.addAttribute("totalJobs", jobRepository.count());
            List<User> recentUsers = userRepository.findTop5ByIsApprovedFalseOrderByIdDesc();
            List<Job> recentJobs = jobRepository.findTop5ByOrderByIdDesc();
            if(recentJobs!=null){
                model.addAttribute("recentJobs", recentJobs);
            }

            if(recentUsers!= null){
                model.addAttribute("recentUsers", recentUsers);
            }
            return "admin-dashboard";
        }
    }

