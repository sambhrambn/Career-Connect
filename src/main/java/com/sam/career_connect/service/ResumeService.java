package com.sam.career_connect.service;

import com.sam.career_connect.entity.Resume;
import com.sam.career_connect.entity.Student;
import com.sam.career_connect.repository.ResumeRepository;
import com.sam.career_connect.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Service
public class ResumeService {

    @Autowired
    private ResumeRepository resumeRepository;

    @Autowired
    private StudentRepository studentRepository;

    public Resume addResume(MultipartFile resumeFile, Long studentId) {
        Resume resume=null;
        try{

            if (!resumeFile.isEmpty()) {
                String extension = getExtension(resumeFile.getOriginalFilename());
                String fileName = "resume_" + studentId + "." + extension;

                Path path = Paths.get("uploads/resume", fileName);
                Files.createDirectories(path.getParent());
                Files.copy(resumeFile.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                String dbPath = "/uploads/resume/" + fileName;

                 resume = resumeRepository.findByStudentId(studentId);
                Student student=studentRepository.findById(studentId).orElse(null);
                if (resume == null) {
                    resume = new Resume();
                    resume.setStudent(student);
                }
                resume.setFileName(fileName);
                resume.setFilePath(dbPath);
                resumeRepository.save(resume);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return resume;
    }

    private String getExtension(String originalName) {
        if (originalName != null && originalName.contains(".")) {
            return originalName.substring(originalName.lastIndexOf('.') + 1);
        }
        return "";
    }
}
