package com.sam.career_connect.service;

import com.sam.career_connect.entity.Education;
import com.sam.career_connect.entity.Student;
import com.sam.career_connect.repository.EducationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EducationService {

    @Autowired
    private EducationRepository educationRepository;

    public void addEducation(Education education, Student student) {
        education.setStudent(student);
        educationRepository.save(education);
    }
}
