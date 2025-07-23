package com.sam.career_connect.service;

import com.sam.career_connect.entity.Experience;
import com.sam.career_connect.entity.Recruiter;
import com.sam.career_connect.repository.ExperienceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExperienceService {

    @Autowired
    private ExperienceRepository experienceRepository;

    public void addExperience(Experience experience, Recruiter recruiter) {
        experience.setRecruiter(recruiter);
        experienceRepository.save(experience);
    }
}
