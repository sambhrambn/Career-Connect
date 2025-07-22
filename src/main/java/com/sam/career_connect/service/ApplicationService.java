package com.sam.career_connect.service;

import com.sam.career_connect.common.ApplicationStatus;
import com.sam.career_connect.entity.Application;
import com.sam.career_connect.entity.Job;
import com.sam.career_connect.entity.Student;
import com.sam.career_connect.repository.ApplicationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class ApplicationService {

    @Autowired
    private ApplicationRepository applicationRepository;

    @Autowired
    private StudentService studentService;

    @Autowired
    private JobService jobService;

    public List<Application> getJobs(Long id) {
        return applicationRepository.findAllByStudentId(id);
    }

    public Long getApplicationCount(Long id) {
        return (Long)applicationRepository.countByStudent_Id(id);
    }

    public Long getShortListedCount(Long id) {
        return (Long)applicationRepository.countByStatusAndStudent_Id(ApplicationStatus.SHORTLISTED, id);
    }

    public void applyJob(Long studentId, Long jobId) {
        Student student=studentService.getStudent(studentId);
        Job job=jobService.getJobById(jobId);
        Application application;
       application = applicationRepository.findByStudentIdAndJobId(studentId,jobId).orElse(null);
       if(application!=null){
           applicationRepository.save(application);
           return;
       }
        application=new Application();
        application.setAppliedAt(LocalDate.now());
        application.setStatus(ApplicationStatus.APPLIED);
        application.setStudent(student);
        application.setJob(job);
        applicationRepository.save(application);
    }

    public Application getApplicationByStudentAndJob(Long studentId, Long jobId) {
       return applicationRepository.findByStudentIdAndJobId(studentId,jobId).orElse(null);
    }

    public List<Application> getApplications(Long studentId) {
        return applicationRepository.findAllByStudentId(studentId);
    }

    public List<Application> getApplicants(Long recruiterId) {
        return applicationRepository.findAllByJobRecruiterIdAndStatus(recruiterId,ApplicationStatus.APPLIED);
    }

    public void updateApplicationStatus(Long applicationId) {
        Application app = applicationRepository.findById(applicationId).orElse(null);
        if(app!=null){
            app.setStatus(ApplicationStatus.SHORTLISTED);
            applicationRepository.save(app);
        }

    }

    public void rejectApplicationStatus(Long applicationId) {
        Application app = applicationRepository.findById(applicationId).orElse(null);
        if(app!=null){
            app.setStatus(ApplicationStatus.REJECTED);
            applicationRepository.save(app);
        }
    }
}
