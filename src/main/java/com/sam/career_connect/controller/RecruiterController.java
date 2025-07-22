package com.sam.career_connect.controller;

import com.sam.career_connect.dto.RecruiterDto;
import com.sam.career_connect.dto.StudentDto;
import com.sam.career_connect.entity.*;
import com.sam.career_connect.service.ApplicationService;
import com.sam.career_connect.service.JobService;
import com.sam.career_connect.service.RecruiterService;
import com.sam.career_connect.service.UserService;
import com.sam.career_connect.validation.OnCreate;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/recruiter")
public class RecruiterController {

    @Autowired
    private RecruiterService recruiterService;

    @Autowired
    private ApplicationService applicationService;

    @Autowired
    private JobService jobService;

    @Autowired
    private UserService userService;

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

            return "recruiter-dashboard2";
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

    @GetMapping("/applicants")
    public String viewApplicants(Model model, HttpSession session){
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
        List<Application> applicants = applicationService.getApplicants(recruiterId);
        model.addAttribute("applicants", applicants);
        return "view-applicants";
    }

    @GetMapping("/short-list/{id}")
    public String doShortList(@PathVariable("id")  Long applicationId, Model model, HttpSession session){
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
        applicationService.updateApplicationStatus(applicationId);
        List<Application> applicants = applicationService.getApplicants(recruiterId);
        model.addAttribute("applicants", applicants);
        return "view-applicants";
    }

    @GetMapping("/reject/{id}")
    public String doReject(@PathVariable("id")  Long applicationId, Model model, HttpSession session){
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
        applicationService.rejectApplicationStatus(applicationId);
        List<Application> applicants = applicationService.getApplicants(recruiterId);
        model.addAttribute("applicants", applicants);
        return "view-applicants";
    }

    @GetMapping("/job-form")
    public String jobPage(Model model){
        model.addAttribute("job", new Job());
        return "new-job";
    }

    @GetMapping("/add-job")
    public String addJob(@ModelAttribute("job") Job job, Model model, HttpSession session){
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
        jobService.addJob(job, recruiter);
        model.addAttribute("recruiter", recruiter);
        model.addAttribute("user", recruiter.getUser());
        return "recruiter-dashboard2";
    }

    @GetMapping("/register-form")
    public String registerPage(Model model){
        model.addAttribute("recruiter", new RecruiterDto());
        return "recruiter-registration";
    }

    @PostMapping("/register")
    public String registerStudent( @Validated(OnCreate.class) @ModelAttribute("recruiter") StudentDto studentDto,
                                   @RequestParam("imageFile") MultipartFile imageFile) {
        User user= userService.registerUser(studentDto);
        studentService.registerStudent(studentDto,user,imageFile);
        return "home-page";
    }

}
