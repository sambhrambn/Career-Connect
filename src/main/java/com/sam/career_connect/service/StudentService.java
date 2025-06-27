package com.sam.career_connect.service;

import com.sam.career_connect.common.Role;
import com.sam.career_connect.dto.StudentDto;
import com.sam.career_connect.entity.Student;
import com.sam.career_connect.entity.User;
import com.sam.career_connect.repository.StudentRepository;
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
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class StudentService {


    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private UserRepository userRepository;

    @Value("${upload.dir}")
    private String uploadDir;

    public StudentDto getStudentDto(Student student) {
        User user=student.getUser();
        StudentDto studentDto=new StudentDto();
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
        studentDto.setSkills(student.getSkills().stream().toList());
        studentDto.setAddress(student.getAddress());
        studentDto.setObjective(student.getObjective());
        studentDto.setPhoneNumber(student.getPhoneNumber());
        studentDto.setRole(user.getRole());
        return studentDto;
    }

    public List<Student> getStudents() {
        return studentRepository.findAll();
    }

    public Student getStudent(Long id) {
        return studentRepository.findById(id).orElse(null);
    }

    private String getExtension(String fileName) {
        return fileName.substring(fileName.lastIndexOf('.') + 1);
    }

    public void registerStudent(StudentDto studentDto, User user, MultipartFile imageFile) {
        Student student= new Student();
        student.setFirstName(studentDto.getFirstName());
        student.setLastName(studentDto.getLastName());
        student.setDob(studentDto.getDob());
        student.setGender(studentDto.getGender());
        student.setSkills(studentDto.getSkills());
        student.setAddress(studentDto.getAddress());
        student.setImagePath("example path");
        student.setPhoneNumber(studentDto.getPhoneNumber());
        student.setObjective(studentDto.getObjective());
        student.setUser(user);
        Student savedStudent = studentRepository.save(student);

        try{

            if (!imageFile.isEmpty()) {
                String extension = getExtension(imageFile.getOriginalFilename());
                String fileName = "student_" + savedStudent.getId() + "." + extension;

                Path path = Paths.get(uploadDir, fileName);
                Files.createDirectories(path.getParent());
                Files.copy(imageFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                savedStudent.setImagePath("/uploads/" + fileName);
                studentRepository.save(savedStudent);
            }
    } catch (IOException e) {
        e.printStackTrace();
    }
    }

    public Student validateStudent(String email, String password) {
        User user = userRepository.findByEmailAndPassword(email,password).orElse(null);
        if(user==null){
            return null;
        }
        else if(user.getRole().equals(Role.STUDENT)){
            return user.getStudent();
        }
       return null;
    }

    public void updateStudent(StudentDto studentDto, User user, MultipartFile imageFile, Student student) {

        student.setFirstName(studentDto.getFirstName());
        student.setLastName(studentDto.getLastName());
        student.setDob(studentDto.getDob());
        student.setGender(studentDto.getGender());
        Set<String> mergedSkills = new LinkedHashSet<>(student.getSkills());
        mergedSkills.addAll(studentDto.getSkills());
        //List<String> oldSkillsList=student.getSkills();
       // List<String> newSkillsList=studentDto.getSkills();
       // oldSkillsList.addAll(newSkillsList);
        student.setSkills(new ArrayList<>(mergedSkills));
        student.setAddress(studentDto.getAddress());
        student.setPhoneNumber(studentDto.getPhoneNumber());
        student.setObjective(studentDto.getObjective());
        student.setUser(user);
        //Student savedStudent = studentRepository.save(student);
        try{
            if (!imageFile.isEmpty()) {
                String extension = getExtension(imageFile.getOriginalFilename());
                String fileName = "student_" + studentDto.getId() + "." + extension;
                Path path = Paths.get(uploadDir, fileName);
                Files.createDirectories(path.getParent());
                Files.copy(imageFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                student.setImagePath("/uploads/" + fileName);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        studentRepository.save(student);
    }
}
