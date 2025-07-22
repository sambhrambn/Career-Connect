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
import java.util.List;

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

//    public void registerRecruiter(RecruiterDto recruiterDto, User user, MultipartFile imageFile) {
//        Recruiter recruiter = new Recruiter();
//        student.setFirstName(studentDto.getFirstName());
//        student.setLastName(studentDto.getLastName());
//        student.setDob(studentDto.getDob());
//        student.setGender(studentDto.getGender());
//        student.setSkills(studentDto.getSkills());
//        student.setAddress(studentDto.getAddress());
//        student.setImagePath("example path");
//        student.setPhoneNumber(studentDto.getPhoneNumber());
//        student.setObjective(studentDto.getObjective());
//        student.setUser(user);
//        Student savedStudent = studentRepository.save(student);
//
//        try{
//
//            if (!imageFile.isEmpty()) {
//                String extension = getExtension(imageFile.getOriginalFilename());
//                String fileName = "student_" + savedStudent.getId() + "." + extension;
//
//                Path path = Paths.get(uploadDir, fileName);
//                Files.createDirectories(path.getParent());
//                Files.copy(imageFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
//                savedStudent.setImagePath("/uploads/" + fileName);
//                studentRepository.save(savedStudent);
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }

}
