package com.sam.career_connect.repository;

import com.sam.career_connect.entity.Bookmark;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BookmarkRepository extends JpaRepository<Bookmark,Long> {
    Long countByStudent_Id(Long id);

    List<Bookmark> findAllByStudent_IdAndJob_ActiveTrueAndJob_VisibleTrue(Long studentId);


    Optional<Bookmark> findByStudent_IdAndJob_Id(Long studentId, Long jobId);
}
