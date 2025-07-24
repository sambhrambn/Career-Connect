package com.sam.career_connect.controller;

import com.sam.career_connect.common.EducationLevel;
import com.sam.career_connect.dto.RecruiterDto;
import com.sam.career_connect.dto.StudentDto;
import com.sam.career_connect.entity.*;
import com.sam.career_connect.service.*;
import com.sam.career_connect.validation.OnCreate;
import com.sam.career_connect.validation.OnUpdate;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/recruiter")
public class RecruiterController {

    @Autowired
    private RecruiterService recruiterService;

    @Autowired
    private UserService userService;


    @Autowired
    private ApplicationService applicationService;

    @Autowired
    private JobService jobService;

    @Autowired
    private ExperienceService experienceService;


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
    public String registerStudent( @Validated(OnCreate.class) @ModelAttribute("recruiter") RecruiterDto recruiterDto,
                                   @RequestParam("imageFile") MultipartFile imageFile) {
        User user= userService.registerUser(recruiterDto);
        recruiterService.registerRecruiter(recruiterDto,user,imageFile);
        return "home-page";
    }

    @GetMapping("/job-invisible/{id}")
    public String makeInvisible(@PathVariable("id") Long jobId, Model model, HttpSession session){
        jobService.makeJobInvisible(jobId);
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
        List<Job> jobList=recruiterService.getJobs(recruiterId);
        model.addAttribute("jobList",jobList);
        return "post-job";
    }

    @GetMapping("/job-deactivate/{id}")
    public String makeDeactivate(@PathVariable("id") Long jobId, Model model, HttpSession session){
        jobService.makeJobDeactivate(jobId);
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
        List<Job> jobList=recruiterService.getJobs(recruiterId);
        model.addAttribute("jobList",jobList);
        return "post-job";
    }

    @GetMapping("/profile")
    public String recruiterProfile(HttpSession session,Model model){
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Experience experience = new Experience();
        model.addAttribute("experience", experience);
        model.addAttribute("recruiter", recruiterService.getRecruiter(recruiterId));
        return "recruiter-profile";
    }

    @PostMapping("/add-experience")
    public String addExperience(@ModelAttribute("experience") Experience experience,HttpSession session, Model model) {
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
          experienceService.addExperience(experience,recruiter);

       Experience experience1 =  new Experience();// empty object for form
        model.addAttribute("experience",experience1 );
        model.addAttribute("recruiter", recruiter);
//      model.addAttribute("user", student.getUser());
       return "recruiter-profile";
    }

    @RequestMapping("/edit")
    public String recruiterEdit(Model model,HttpSession session){
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
        User us=recruiter.getUser();
        System.out.println(us);
        RecruiterDto recruiterDto =  recruiterService.getRecruiterDto(recruiter);
        model.addAttribute("recruiter", recruiterDto);
        return "recruiter-edit";
    }

    @PostMapping("/update")
    public String updateStudent( @Validated(OnUpdate.class) @ModelAttribute("recruiter") RecruiterDto recruiterDto,
                                 @RequestParam("imageFile") MultipartFile imageFile,Model model, HttpSession session ) {
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Recruiter recruiter = recruiterService.getRecruiter(recruiterId);
        User us=recruiter.getUser();
        User user= userService.updateUser(recruiterDto, recruiter);
        recruiterService.updateRecruiter(recruiterDto,user,imageFile,recruiter);

        Experience experience = new Experience(); // empty object for form
        model.addAttribute("experience", experience);
        model.addAttribute("recruiter", recruiterService.getRecruiter(recruiterId));
        //model.addAttribute("user", studentService.getStudent(studentId).getUser());
        //model.addAttribute("educationLevels", Arrays.asList(EducationLevel.values()));
        return "recruiter-profile";
    }

    @GetMapping("/profile-view/{id}")
    public String recruiterProfileView(@PathVariable("id") Long recruiterId, HttpSession session,Model model){
        Experience experience = new Experience();
        model.addAttribute("experience", experience);
        model.addAttribute("recruiter", recruiterService.getRecruiter(recruiterId));
        return "recruiter-profile2";
    }

}
