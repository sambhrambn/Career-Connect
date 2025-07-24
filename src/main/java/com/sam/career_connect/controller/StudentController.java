package com.sam.career_connect.controller;

import com.sam.career_connect.common.ApplicationStatus;
import com.sam.career_connect.common.EducationLevel;
import com.sam.career_connect.common.Gender;
import com.sam.career_connect.common.Role;
import com.sam.career_connect.dto.StudentDto;
import com.sam.career_connect.entity.*;
import com.sam.career_connect.service.*;
import com.sam.career_connect.validation.OnCreate;
import com.sam.career_connect.validation.OnUpdate;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private UserService userService;

    @Autowired
    private ApplicationService applicationService;

    @Autowired
    private BookmarkService bookmarkService;

    @Autowired
    private EducationService educationService;

    @Autowired
    private ResumeService resumeService;

    @Autowired
    private JobService jobService;

    @GetMapping("/home")
    public String homePage(Model model){
        return "home-page";
    }

    @GetMapping("/register-form")
    public String registerPage(Model model){
        model.addAttribute("student", new StudentDto());
        return "student-registration";
    }

    @PostMapping("/register")
    public String registerStudent( @Validated(OnCreate.class) @ModelAttribute("student") StudentDto studentDto,
                                  @RequestParam("imageFile") MultipartFile imageFile) {
            User user= userService.registerUser(studentDto);
            studentService.registerStudent(studentDto,user,imageFile);
        return "home-page";
    }

    @GetMapping("/student-form")
    public String studentLoginForm(){
        return "student-login";
    }

    @PostMapping("/login")
    public String studentLogin(@RequestParam("email") String email, @RequestParam("password") String password, HttpSession session, Model model){
        Student student= studentService.validateStudent(email, password);
        if(student!=null){
            session.setAttribute("studentId", student.getId());
            model.addAttribute("student", student);
            model.addAttribute("user", student.getUser());
            model.addAttribute("applicationCount", (Long)applicationService.getApplicationCount(student.getId()));
            model.addAttribute("bookmarkedCount", (Long)bookmarkService.getBookmarkedCount(student.getId()));
            model.addAttribute("shortListedCount", (Long)applicationService.getShortListedCount(student.getId()));

            return "student-dashboard";
        } else{
            model.addAttribute("error", "invalid email or password");
            return "student-login";
        }
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "home-page";
    }

    @GetMapping("/student-profile")
    public String studentProfile(HttpSession session,Model model){
        Long studentId = (Long) session.getAttribute("studentId");
        Education education = new Education(); // empty object for form
        model.addAttribute("education", education);
        model.addAttribute("student", studentService.getStudent(studentId));
        model.addAttribute("user", studentService.getStudent(studentId).getUser());
        model.addAttribute("educationLevels", Arrays.asList(EducationLevel.values()));
        return "student-profile2";
    }

    @PostMapping("/add-education")
    public String addEducation(@ModelAttribute("education") Education education,HttpSession session, Model model) {
        Long studentId = (Long) session.getAttribute("studentId");
        Student student = studentService.getStudent(studentId);
        educationService.addEducation(education,student);

        Education edu = new Education(); // empty object for form
        model.addAttribute("education", edu);
        model.addAttribute("student", student);
        model.addAttribute("user", student.getUser());
        model.addAttribute("educationLevels", Arrays.asList(EducationLevel.values()));
        return "student-profile2";
    }

    @RequestMapping("/student-edit")
    public String studentEdit(Model model,HttpSession session){
        Long studentId = (Long) session.getAttribute("studentId");
        Student student = studentService.getStudent(studentId);
        User us=student.getUser();
        System.out.println(us);
        StudentDto studentDto =  studentService.getStudentDto(student);
        model.addAttribute("student", studentDto);
        return "student-edit";
    }

    @PostMapping("/update")
    public String updateStudent( @Validated(OnUpdate.class) @ModelAttribute("student") StudentDto studentDto,
                                  @RequestParam("imageFile") MultipartFile imageFile,Model model, HttpSession session ) {
        Long studentId = (Long) session.getAttribute("studentId");
        Student student = studentService.getStudent(studentId);
        User us=student.getUser();
        System.out.println(us);
        User user= userService.updateUser(studentDto, student);
       studentService.updateStudent(studentDto,user,imageFile,student);

        Education education = new Education(); // empty object for form
        model.addAttribute("education", education);
        model.addAttribute("student", studentService.getStudent(studentId));
        model.addAttribute("user", studentService.getStudent(studentId).getUser());
        model.addAttribute("educationLevels", Arrays.asList(EducationLevel.values()));
        return "student-profile2";
    }

    @GetMapping("/resume")
    public String showResumePage(HttpSession session, Model model) {
        Long studentId = (Long)session.getAttribute("studentId");
        Student student = studentService.getStudent(studentId);
        Resume resume = student.getResume();
        if (studentId == null) {
            return "redirect:/student/login";
        }
        model.addAttribute("resume", resume);
        return "student-resume"; // this should match your JSP file name
    }

    @PostMapping("/upload-resume")
    public String addResume(@RequestParam("resumeFile") MultipartFile resumeFile, HttpSession session, Model model){
        Long studentId = (Long)session.getAttribute("studentId");
        Resume resume = resumeService.addResume(resumeFile, studentId);
        System.out.println(resume);
        model.addAttribute("resume", resume);
        return "student-resume";
    }

    @GetMapping("/all-jobs")
    public String showAllJobs(@RequestParam(value = "keyword", required = false) String keyword, Model model, HttpSession session) {
        List<Job> jobs;
        Long studentId = (Long)session.getAttribute("studentId");
            jobs = jobService.getAllJobs();
        Map<Long, ApplicationStatus> applicationStatusMap = new HashMap<>();

        for (Job job : jobs) {
            Application application = applicationService.getApplicationByStudentAndJob(studentId, job.getId());
            if (application != null) {
                applicationStatusMap.put(job.getId(), application.getStatus());
            } else {
                applicationStatusMap.put(job.getId(), null); // no application yet
            }
        }

        model.addAttribute("jobs", jobs);
        model.addAttribute("applicationStatusMap", applicationStatusMap);
        return "job";
    }
    @GetMapping("/view/{id}")
    public String viewJobDetails(@PathVariable("id") Long id, Model model,HttpSession session){
        Job job= jobService.getJobById(id);
        Long studentId = (Long)session.getAttribute("studentId");
        Application application=applicationService.getApplicationByStudentAndJob(studentId,id);
        if(application!=null){
            model.addAttribute("status", application.getStatus());
        }
        model.addAttribute("job", job);
        return "job-view";
    }
    @GetMapping("/apply/{id}")
    public String applyJob(@PathVariable("id") Long jobId,Model model, HttpSession session){
        Long studentId = (Long)session.getAttribute("studentId");
        applicationService.applyJob(studentId,jobId);
        List<Job> jobs = jobService.getAllJobs();
        Map<Long, ApplicationStatus> applicationStatusMap = new HashMap<>();

        for (Job job : jobs) {
            Application application = applicationService.getApplicationByStudentAndJob(studentId, job.getId());
            if (application != null) {
                applicationStatusMap.put(job.getId(), application.getStatus());
            } else {
                applicationStatusMap.put(job.getId(), null);
            }
        }

        model.addAttribute("jobs", jobs);
        model.addAttribute("applicationStatusMap", applicationStatusMap);
        return "job";
    }

    @GetMapping("/bookmark/{id}")
    public String jobBookmark(@PathVariable("id") Long jobId, Model model, HttpSession session){
       Long studentId =  (Long)session.getAttribute("studentId");
       bookmarkService.jobBookmark(studentId,jobId);
       List<Job> jobs = jobService.getAllJobs();

        Map<Long, ApplicationStatus> applicationStatusMap = new HashMap<>();

        for (Job job : jobs) {
            Application application = applicationService.getApplicationByStudentAndJob(studentId, job.getId());
            if (application != null) {
                applicationStatusMap.put(job.getId(), application.getStatus());
            } else {
                applicationStatusMap.put(job.getId(), null);
            }
        }

       model.addAttribute("jobs", jobs);
        model.addAttribute("applicationStatusMap", applicationStatusMap);
       return "job";
    }

    @GetMapping("/bookmarked-jobs")
    public String bookmarkedJobs(Model model, HttpSession session){
        Long studentId =  (Long)session.getAttribute("studentId");
        List<Bookmark> bookmarkList = bookmarkService.getBookmarkedJobs(studentId);
        model.addAttribute("bookmarkList", bookmarkList);
        return "bookmarked-jobs";
    }

    @GetMapping("/removeBookmark/{id}")
    public String removeBookmark(@PathVariable("id") Long jobId, HttpSession session, Model model){
        Long studentId =  (Long)session.getAttribute("studentId");
        bookmarkService.removeBookmark(studentId,jobId);
        List<Bookmark> bookmarkList = bookmarkService.getBookmarkedJobs(studentId);
        model.addAttribute("bookmarkList", bookmarkList);
        return "bookmarked-jobs";
    }

    @GetMapping("/my-applications")
    public String myApplications(Model model, HttpSession session){
        Long studentId =  (Long)session.getAttribute("studentId");
        List<Application> applications = applicationService.getApplications(studentId);
        model.addAttribute("applications", applications);
        return "my-applications";
    }

    @GetMapping("/search/jobs")
    public String searchJobs(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<Job> jobs;
       jobs = jobService.searchJobs(keyword);
        model.addAttribute("jobs", jobs);
        return "job";
    }

    @GetMapping("/dashboard")
    public String studentDashboard( HttpSession session, Model model){

          Long studentId = (Long)session.getAttribute("studentId");
          Student student = studentService.getStudent(studentId);
            model.addAttribute("student", student);
            model.addAttribute("user", student.getUser());
            model.addAttribute("applicationCount", (Long)applicationService.getApplicationCount(student.getId()));
            model.addAttribute("bookmarkedCount", (Long)bookmarkService.getBookmarkedCount(student.getId()));
            model.addAttribute("shortListedCount", (Long)applicationService.getShortListedCount(student.getId()));
            return "student-dashboard";


    }

    @GetMapping("/profile/{id}")
    public String profile(@PathVariable("id") Long studentId, HttpSession session,Model model){
        Education education = new Education();
        model.addAttribute("education", education);
        model.addAttribute("student", studentService.getStudent(studentId));
        model.addAttribute("user", studentService.getStudent(studentId).getUser());
        model.addAttribute("educationLevels", Arrays.asList(EducationLevel.values()));
        return "student-profile3";
    }

}


