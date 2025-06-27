package com.sam.career_connect.repository;

import com.sam.career_connect.entity.Resume;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ResumeRepository extends JpaRepository<Resume, Long>{

    Resume findByStudentId(Long studentId);
}
