package com.sam.career_connect.controller;

import com.sam.career_connect.entity.Job;
import com.sam.career_connect.entity.Recruiter;
import com.sam.career_connect.entity.Student;
import com.sam.career_connect.service.RecruiterService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/recruiter")
public class RecruiterController {

    @Autowired
    private RecruiterService recruiterService;

    @GetMapping("/login")
    public String studentLoginForm(){
        return "recruiter-login";
    }

    @PostMapping("/dashboard")
    public String recruiterLogin(@RequestParam("email") String email, @RequestParam("password") String password, HttpSession session, Model model){
        Recruiter recruiter=recruiterService.validateRecruiter(email,password);
        if(recruiter!=null){
            session.setAttribute("recruiterId", recruiter.getId());
            model.addAttribute("recruiter", recruiter);
            model.addAttribute("user", recruiter.getUser());
//            model.addAttribute("applicationCount", (Long)applicationService.getApplicationCount(student.getId()));
//            model.addAttribute("bookmarkedCount", (Long)bookmarkService.getBookmarkedCount(student.getId()));
//            model.addAttribute("shortListedCount", (Long)applicationService.getShortListedCount(student.getId()));

            return "recruiter-dashboard";
        } else {
            model.addAttribute("error", "invalid email or password");
            return "recruiter-login";
        }
    }
    @GetMapping("/post-jobs")
    public String postJobs(Model model, HttpSession session){
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
        List<Job> jobList=recruiterService.getJobs(recruiterId);
model.addAttribute("jobList",jobList);

        return "post-job";
    }

}
