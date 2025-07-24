package com.sam.career_connect.controller;

import com.sam.career_connect.entity.*;
import com.sam.career_connect.repository.*;
import com.sam.career_connect.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Value("${admin.email}")
    private String adminEmail;

    @Value("${admin.password}")
    private String adminPassword;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private RecruiterRepository recruiterRepository;

    @Autowired
    private JobRepository jobRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ApplicationRepository applicationRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private RecruiterService recruiterService;

    @Autowired
    private JobService jobService;

    @Autowired
    private ApplicationService applicationService;


    @GetMapping("/login")
    public String adminLoginForm(){
        return "admin-login";
    }

    @PostMapping("/dashboard")
    public String recruiterLogin(@RequestParam("email") String email, @RequestParam("password") String password, Model model){
        if (email.equals(adminEmail) && password.equals(adminPassword)) {
            model.addAttribute("totalStudents", studentRepository.count());
            model.addAttribute("totalRecruiters", recruiterRepository.count());
            List<User> recentUsers = userRepository.findTop5ByIsApprovedFalseOrderByIdDesc();
            List<Job> recentJobs = jobRepository.findTop5ByOrderByIdDesc();
            if(recentJobs!=null){
                model.addAttribute("recentJobs", recentJobs);
            }

            if(recentUsers!= null){
                model.addAttribute("recentUsers", recentUsers);
            }
            return "admin-dashboard";
        } else {
            model.addAttribute("error", "invalid email or password");
            return "admin-login";
        }
    }

    @GetMapping("/students")
    public String adminStudents(Model model){
        List<Student> students= studentRepository.findAllByUserIsBlockedFalse();
        model.addAttribute("students", students);
        return "admin-students";
    }

    @GetMapping("/recruiters")
    public String adminRecruiters(Model model){
        List<Recruiter> recruiters= recruiterRepository.findAllByUserIsBlockedFalse();
        model.addAttribute("recruiters", recruiters);
        return "admin-recruiters";
    }

    @GetMapping("/jobs")
    public String adminJobs(Model model){
        List<Job> jobs= jobRepository.findAll();
        model.addAttribute("jobs", jobs);
        return "admin-jobs";
    }

    @GetMapping("/users")
    public String manageUsers(Model model){
        List<User> users= userRepository.findAll();
        model.addAttribute("users", users);
        return "manage-users";
    }
    @GetMapping("/toggle")
    public String jobsToggle(Model model){
        List<Job> jobs= jobRepository.findAll();
        model.addAttribute("jobs", jobs);
        return "jobs-toggle";
    }
    @GetMapping("/status")
    public String jobsStatus(Model model){
        List<Job> jobs= jobRepository.findAll();
        List<Application> applications=applicationRepository.findAll();
        model.addAttribute("jobs", jobs);
        model.addAttribute("applications",applications);
        model.addAttribute("studentCount",studentRepository.count());
        model.addAttribute("recruiterCount",recruiterRepository.count());
        model.addAttribute("jobCount",jobRepository.count());
        model.addAttribute("applicationCount",applicationRepository.count());
        return "platform-status";
    }

    @GetMapping("/deactivate/{id}")
    public String deactivateStudent(@PathVariable("id") Long id, Model model){
        studentService.deactivateStudent(id);
        List<Student> students= studentRepository.findAllByUserIsBlockedFalse();
        model.addAttribute("students", students);
        return "admin-students";
    }

    @GetMapping("/deactivate/{id}")
    public String deactivateRecruiter(@PathVariable("id") Long id, Model model){
        recruiterService.deactivateRecruiter(id);
        List<Recruiter> recruiters= recruiterRepository.findAllByUserIsBlockedFalse();
        model.addAttribute("recruiters", recruiters);
        return "admin-recruiters";
    }
    @GetMapping("/jobs/{id}")
    public String viewJobDetails(@PathVariable("id") Long id, Model model,HttpSession session){
        Job job= jobService.getJobById(id);
        model.addAttribute("job", job);
        return "admin-jobview";
    }


}
//    @GetMapping("/students")
//    public ResponseEntity<List<String>> getAllStudentsNames() {
//        List<String> names = studentRepository.findAll()
//                .stream()
//                .map(s -> s.getFirstName() + " " + s.getLastName())
//                .collect(Collectors.toList());
//        return ResponseEntity.ok(names);
//    }