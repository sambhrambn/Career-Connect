<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Resume</title>
    <style>
        :root {
            --charcoal: #2c2c2c;
            --skyblue: #4aa3df;
            --hoverblue: #76c7ff;
            --softwhite: #f5f5f5;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
            background-size: cover;
            position: relative;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.85);
            z-index: 0;
        }

        header, footer {
            position: relative;
            z-index: 2;
        }

        header {
            background-color: var(--charcoal);
            color: var(--softwhite);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: var(--skyblue);
        }

        .header-actions a {
            text-decoration: none;
            background-color: var(--skyblue);
            color: var(--charcoal);
            font-weight: bold;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            margin-left: 1rem;
            transition: background-color 0.3s ease;
        }

        .header-actions a:hover {
            background-color: var(--hoverblue);
        }

        .resume-section {
            max-width: 900px;
            margin: 3rem auto;
            background-color: rgba(255, 255, 255, 0.05);
            padding: 2rem;
            border-radius: 10px;
            border: 1px solid var(--skyblue);
            z-index: 1;
            position: relative;
        }

        .resume-section h2 {
            color: var(--skyblue);
            margin-bottom: 1rem;
            text-align: center;
        }

        .resume-viewer {
            margin-top: 1rem;
            height: 600px;
            width: 100%;
            border: none;
            border-radius: 8px;
        }

        .upload-form {
            margin-top: 2rem;
            text-align: center;
        }

        .upload-form input[type="file"] {
            margin-top: 1rem;
            padding: 0.5rem;
            border-radius: 5px;
            background: var(--softwhite);
            color: var(--charcoal);
        }

        .upload-form input[type="submit"] {
            margin-top: 1rem;
            padding: 0.7rem 1.5rem;
            background-color: var(--skyblue);
            color: var(--charcoal);
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .upload-form input[type="submit"]:hover {
            background-color: var(--hoverblue);
        }

        .footer-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }

        footer {
            background-color: var(--charcoal);
            color: var(--softwhite);
            padding: 2rem 1rem 1rem;
            margin-top: 3rem;
        }

        .footer-column {
            flex: 1 1 250px;
            padding: 1rem;
        }

        .footer-column h3 {
            color: var(--skyblue);
            margin-bottom: 0.8rem;
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column ul li {
            margin: 0.5rem 0;
        }

        .footer-column ul li a {
            color: var(--softwhite);
            text-decoration: none;
        }

        .footer-column ul li a:hover {
            color: var(--skyblue);
        }

        .social-icons a img {
            width: 24px;
            margin-right: 0.5rem;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 1rem;
            border-top: 1px solid var(--skyblue);
            margin-top: 1rem;
        }

        @media (max-width: 768px) {
            .footer-container {
                flex-direction: column;
                align-items: center;
            }

            .resume-viewer {
                height: 400px;
            }
        }

        .file-label {
            color: var(--softwhite);
            margin-top: 0.5rem;
        }
    </style>

    <script>
        function validateFile(input) {
            const file = input.files[0];
            const fileLabel = document.getElementById("fileLabel");

            if (file && file.type !== "application/pdf") {
                alert("Please upload a PDF file only.");
                input.value = "";
                fileLabel.innerText = "";
                return false;
            }

            if (file) {
                fileLabel.innerText = "Selected: " + file.name;
            }
        }
    </script>
</head>
<body>

<header>
    <div class="logo">Campus Career Portal</div>
    <div class="header-actions">
        <a href="/student/student-profile">👤 Profile</a>
        <a href="/student/logout">🚪 Logout</a>
    </div>
</header>

<div class="resume-section">
    <h2>Your Uploaded Resume</h2>

<c:if test="${not empty resume}">
    <embed src="${pageContext.request.contextPath}${resume.filePath}"
           type="application/pdf" class="resume-viewer" />
</c:if>

<c:if test="${empty resume}">
    <p style="color: white; text-align: center; margin-top: 1rem;">
        No resume uploaded yet. Please upload your resume below.
    </p>
</c:if>

    <!-- Resume Upload Form -->
    <div class="upload-form">
        <form action="/student/upload-resume" method="post" enctype="multipart/form-data">
            <input type="file" name="resumeFile" accept=".pdf" onchange="validateFile(this)" required />
            <div id="fileLabel" class="file-label"></div>
            <input type="submit" value="Upload Resume" />
        </form>
    </div>
</div>

<footer>
    <div class="footer-container">
        <div class="footer-column">
            <h3>About Us</h3>
            <p>Campus Career Portal bridges students, recruiters, and administrators to shape successful careers across universities.</p>
        </div>
        <div class="footer-column">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="/student/student-form">Student Login</a></li>
                <li><a href="/recruiter/login">Recruiter Login</a></li>
                <li><a href="/admin/login">Admin Panel</a></li>
            </ul>
        </div>
        <div class="footer-column">
            <h3>Contact</h3>
            <p>Email: support@campuscareer.com</p>
            <p>Phone: +91 98765 43210</p>
            <div class="social-icons">
                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733547.png" alt="Facebook" /></a>
                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733579.png" alt="Twitter" /></a>
                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733558.png" alt="LinkedIn" /></a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        © 2025 Campus Career Portal. All rights reserved.
    </div>
</footer>
</body>
</html>
