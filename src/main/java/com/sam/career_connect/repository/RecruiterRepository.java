package com.sam.career_connect.repository;

import com.sam.career_connect.entity.Recruiter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecruiterRepository extends JpaRepository<Recruiter, Long> {
    List<Recruiter> findAllByUserIsBlockedFalse();
}
