package com.sam.career_connect.service;

import com.sam.career_connect.entity.Bookmark;
import com.sam.career_connect.entity.Job;
import com.sam.career_connect.entity.Student;
import com.sam.career_connect.repository.BookmarkRepository;
import com.sam.career_connect.repository.JobRepository;
import com.sam.career_connect.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookmarkService {

    @Autowired
    private BookmarkRepository bookmarkRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private JobRepository jobRepository;

    public Long getBookmarkedCount(Long id){
        return (Long)bookmarkRepository.countByStudent_Id(id);
    }

    public void jobBookmark(Long studentId, Long jobId) {
        Bookmark bookmark;
        Student student= studentRepository.findById(studentId).orElse(null);
        Job job=jobRepository.findById(jobId).orElse(null);
          bookmark = bookmarkRepository.findByStudent_IdAndJob_Id(studentId,jobId).orElse(null);
         if(bookmark==null){
             bookmark = new Bookmark();
         }
        bookmark.setStudent(student);
        bookmark.setJob(job);
        bookmarkRepository.save(bookmark);
    }

    public List<Bookmark> getBookmarkedJobs(Long studentId) {
        return bookmarkRepository.findAllByStudent_IdAndJob_ActiveTrueAndJob_VisibleTrue(studentId);
    }

    public void removeBookmark(Long studentId, Long jobId) {
        Bookmark bookmark=bookmarkRepository.findByStudent_IdAndJob_Id(studentId,jobId).orElse(null);
        if(bookmark!=null){
            bookmarkRepository.delete(bookmark);
        }
    }
}
