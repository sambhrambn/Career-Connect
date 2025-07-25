package com.sam.career_connect.service;

import com.sam.career_connect.common.Role;
import com.sam.career_connect.dto.RecruiterDto;
import com.sam.career_connect.dto.StudentDto;
import com.sam.career_connect.entity.Job;
import com.sam.career_connect.entity.Recruiter;
import com.sam.career_connect.entity.Student;
import com.sam.career_connect.entity.User;
import com.sam.career_connect.repository.JobRepository;
import com.sam.career_connect.repository.RecruiterRepository;
import com.sam.career_connect.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Service
public class RecruiterService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RecruiterRepository recruiterRepository;

    @Autowired
    private JobRepository jobRepository;

    @Value("${upload.dir}")
    private String uploadDir;

    public Recruiter validateRecruiter(String email, String password) {
        User user = userRepository.findByEmailAndPassword(email,password).orElse(null);
        if(user==null){
            return null;
        }
        //
        else if((user.getRole().equals(Role.RECRUITER)) && (!(user.getIsBlocked()) && user.getIsApproved())){
            return user.getRecruiter();
        }
        return null;
    }

    public Recruiter getRecruiter(Long recruiterId) {
    return recruiterRepository.getById(recruiterId);
    }

    private String getExtension(String fileName) {
        return fileName.substring(fileName.lastIndexOf('.') + 1);
    }


    public List<Job> getJobs(Long recruiterId) {
        return jobRepository.findAllByRecruiterId(recruiterId);
    }

    public void registerRecruiter(RecruiterDto recruiterDto, User user, MultipartFile imageFile) {
          Recruiter recruiter = new Recruiter();
          recruiter.setFirstName(recruiterDto.getFirstName());
          recruiter.setLastName(recruiterDto.getLastName());
          recruiter.setCompanyName(recruiterDto.getCompanyName());
          recruiter.setDesignation(recruiterDto.getDesignation());
          recruiter.setDob(recruiterDto.getDob());
          recruiter.setGender(recruiterDto.getGender());
          recruiter.setAddress(recruiterDto.getAddress());
          recruiter.setImagePath("example path");
          recruiter.setPhoneNumber(recruiterDto.getPhoneNumber());
          recruiter.setObjective(recruiterDto.getObjective());
          recruiter.setUser(user);
          recruiter.setCreatedAt(LocalDate.now());
          Recruiter savedRecruiter = recruiterRepository.save(recruiter);

         try{

            if (!imageFile.isEmpty()) {
               String extension = getExtension(imageFile.getOriginalFilename());
               String fileName = "recruiter_" + savedRecruiter.getId() + "." + extension;

                Path path = Paths.get(uploadDir, fileName);
                Files.createDirectories(path.getParent());
                Files.copy(imageFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                savedRecruiter.setImagePath("/uploads/" + fileName);
                recruiterRepository.save(savedRecruiter);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public RecruiterDto getRecruiterDto(Recruiter student) {
        User user=student.getUser();
        RecruiterDto studentDto=new RecruiterDto();
        studentDto.setId(student.getId());
        studentDto.setEmail(user.getEmail());
        studentDto.setPassword("");
        studentDto.setFirstName(student.getFirstName());
        studentDto.setLastName(student.getLastName());
        if (student.getDob() != null) {
            studentDto.setDob(student.getDob()); //
        }
        if (student.getGender() != null) {
            studentDto.setGender(student.getGender()); //
        }
        studentDto.setDesignation(student.getDesignation());
        studentDto.setCompanyName(student.getCompanyName());
        studentDto.setAddress(student.getAddress());
        studentDto.setObjective(student.getObjective());
        studentDto.setPhoneNumber(student.getPhoneNumber());
        studentDto.setRole(user.getRole());
        return studentDto;
    }

    public void updateRecruiter(RecruiterDto studentDto, User user, MultipartFile imageFile, Recruiter student) {

        student.setFirstName(studentDto.getFirstName());
        student.setLastName(studentDto.getLastName());
        student.setDob(studentDto.getDob());
        student.setGender(studentDto.getGender());
        //List<String> oldSkillsList=student.getSkills();
        // List<String> newSkillsList=studentDto.getSkills();
        // oldSkillsList.addAll(newSkillsList);
        student.setDesignation(studentDto.getDesignation());
        student.setCompanyName(studentDto.getCompanyName());
        student.setAddress(studentDto.getAddress());
        student.setPhoneNumber(studentDto.getPhoneNumber());
        student.setObjective(studentDto.getObjective());
        student.setUser(user);
        //Student savedStudent = studentRepository.save(student);
        try{
            if (!imageFile.isEmpty()) {
                String extension = getExtension(imageFile.getOriginalFilename());
                String fileName = "recruiter_" + studentDto.getId() + "." + extension;
                Path path = Paths.get(uploadDir, fileName);
                Files.createDirectories(path.getParent());
                Files.copy(imageFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                student.setImagePath("/uploads/" + fileName);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        recruiterRepository.save(student);

    }

    public void deactivateRecruiter(Long id) {
        User user = getRecruiter(id).getUser();
        user.setIsBlocked(true);
        userRepository.save(user);
    }
}
