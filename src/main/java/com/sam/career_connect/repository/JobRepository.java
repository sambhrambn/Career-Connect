package com.sam.career_connect.repository;

import com.sam.career_connect.entity.Job;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JobRepository extends JpaRepository<Job,Long> {
   // "Search by job title, company, or location..."
    List<Job> findByJobTitleContainingIgnoreCaseOrCompanyNameContainingIgnoreCaseOrJobLocationContainingIgnoreCase(
            String jobTitle, String companyName, String jobLocation
    );
}
