package com.sam.career_connect.service;

import com.sam.career_connect.common.Role;
import com.sam.career_connect.dto.RecruiterDto;
import com.sam.career_connect.dto.StudentDto;
import com.sam.career_connect.entity.Recruiter;
import com.sam.career_connect.entity.Student;
import com.sam.career_connect.entity.User;
import com.sam.career_connect.repository.UserRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @PersistenceContext
    private EntityManager entityManager;

    public User registerUser(StudentDto studentDto) {
        User user = new User();
        user.setEmail(studentDto.getEmail());
        user.setPassword(studentDto.getPassword());
        user.setRole(studentDto.getRole());
        userRepository.save(user);
        return  user;
    }
    public User registerUser(RecruiterDto recruiterDto) {
        User user = new User();
        user.setEmail(recruiterDto.getEmail());
        user.setPassword(recruiterDto.getPassword());
        user.setRole(recruiterDto.getRole());
        userRepository.save(user);
        return  user;
    }

    public User updateUser(StudentDto studentDto, Student student) {
        User user = userRepository.findById(student.getUser().getId())
                .orElseThrow(() -> new RuntimeException("User not found")); // This is already managed (fetched from DB)
        user.setEmail(studentDto.getEmail());
        if (studentDto.getPassword() != null && !studentDto.getPassword().isBlank()) {
            user.setPassword(studentDto.getPassword());
        }
        if (studentDto.getRole() != null) {
            user.setRole(studentDto.getRole());
        }
        return user;
    }

    public User updateUser(RecruiterDto studentDto, Recruiter student) {
        User user = userRepository.findById(student.getUser().getId())
                .orElseThrow(() -> new RuntimeException("User not found")); // This is already managed (fetched from DB)
        user.setEmail(studentDto.getEmail());
        if (studentDto.getPassword() != null && !studentDto.getPassword().isBlank()) {
            user.setPassword(studentDto.getPassword());
        }
        if (studentDto.getRole() != null) {
            user.setRole(studentDto.getRole());
        }
        return user;
    }


    public void doApprove(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if(user!=null){
            user.setIsApproved(true);
            userRepository.save(user);
        }

    }

    public void doReject(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if(user!=null){
            user.setIsApproved(false);
            userRepository.save(user);
        }
    }
}
