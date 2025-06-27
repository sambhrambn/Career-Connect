package com.sam.career_connect.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

}
//    @GetMapping("/students")
//    public ResponseEntity<List<String>> getAllStudentsNames() {
//        List<String> names = studentRepository.findAll()
//                .stream()
//                .map(s -> s.getFirstName() + " " + s.getLastName())
//                .collect(Collectors.toList());
//        return ResponseEntity.ok(names);
//    }