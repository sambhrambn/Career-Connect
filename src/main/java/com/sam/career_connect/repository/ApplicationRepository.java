package com.sam.career_connect.repository;

import com.sam.career_connect.common.ApplicationStatus;
import com.sam.career_connect.entity.Application;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface ApplicationRepository extends JpaRepository<Application,Long> {

    List<Application> findAllByStudentId(Long id);
    Long countByStudent_Id(Long studentId);

    Long countByStatusAndStudent_Id(ApplicationStatus shortlisted, Long id);

    Optional<Application> findByStudentIdAndJobId(Long studentId, Long jobId);

    List<Application> findAllByJobRecruiterIdAndStatus(Long recruiterId, ApplicationStatus status);

}
