
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Profile - Campus Career Portal</title>
    <style>
        :root {
            --charcoal: #2c2c2c;
            --skyblue: #4aa3df;
            --softwhite: #f5f5f5;
            --muted: #cccccc;
        }

        * {
            margin: 0; padding: 0; box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--softwhite);
        }

        header {
            background-color: rgba(44, 44, 44, 0.95);
            padding: 1.2rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--skyblue);
            width: 100%;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo { font-size: 2rem; font-weight: bold; color: var(--skyblue); }

        nav a {
            margin-left: 2rem;
            text-decoration: none;
            color: var(--softwhite);
            font-weight: 500;
            transition: color 0.3s ease;
        }

        nav a:hover { color: var(--skyblue); }

        .profile-container {
            display: flex; flex-wrap: wrap;
            margin: 2rem;
            padding: 2rem;
            background-color: rgba(44, 44, 44, 0.9);
            border-radius: 12px;
            animation: fadeInUp 1s ease-in-out;
        }

        .profile-image {
            flex: 1 1 180px;
            max-width: 180px;
            margin-right: 2rem;
        }

        .profile-image img {
            width: 180px;
            height: 220px;
            object-fit: cover;
            border-radius: 50% / 40%;
            border: 2px solid var(--skyblue);
            margin-top: 5px;
        }

        .profile-details {
            flex: 2 1 500px;
        }

        .profile-details h2 { color: var(--skyblue); margin-bottom: 1rem; }
        .profile-details p { margin-bottom: 0.5rem; line-height: 1.5; }

        .action-buttons {
            margin-top: 1rem;
        }

        .action-buttons button {
            margin-right: 1rem;
            padding: 0.6rem 1.2rem;
            background-color: var(--skyblue);
            color: var(--charcoal);
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .action-buttons button:hover { background-color: #368dc5; }

        .education-section {
            padding: 2rem;
            background-color: rgba(56, 56, 56, 0.95);
            margin: 2rem;
            border-radius: 12px;
            animation: fadeInUp 1.2s ease-in-out;
        }

        .education-section h2 {
            color: var(--skyblue);
            margin-bottom: 1rem;
        }

        .timeline {
            position: relative;
            margin-left: 2rem;
            padding-left: 2rem;
            border-left: 2px solid var(--skyblue);
        }

        .timeline-entry {
            position: relative;
            margin-bottom: 2rem;
        }

        .timeline-entry::before {
            content: '';
            position: absolute;
            left: -1.1rem;
            top: 0.3rem;
            width: 1rem;
            height: 1rem;
            background-color: var(--skyblue);
            border-radius: 50%;
        }

        .timeline-entry h3 {
            margin-bottom: 0.5rem;
            color: var(--softwhite);
        }

        .timeline-entry p {
            margin: 0;
            color: var(--muted);
        }

        .education-form {
            display: none;
            margin-top: 2rem;
            background-color: #444;
            padding: 1rem;
            border-radius: 10px;
        }

        .education-form input,
        .education-form select {
            width: 100%;
            margin-bottom: 1rem;
            padding: 0.6rem;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .education-form button {
            background-color: var(--skyblue);
            color: var(--charcoal);
            padding: 0.5rem 1rem;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        footer {
            background-color: var(--charcoal);
            color: var(--softwhite);
            padding: 2rem 1rem 1rem;
        }

        .footer-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
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

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .profile-container { flex-direction: column; align-items: center; }
            .profile-image { margin-right: 0; margin-bottom: 1.5rem; }
            .profile-details { text-align: center; }
            .education-section { margin: 1rem; }
            nav a { margin-left: 1rem; }
            .footer-container { flex-direction: column; align-items: center; }
        }
    </style>

    <script>
        function toggleExperienceForm() {
            const form = document.getElementById('experienceForm');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body>

<header>
    <div class="logo">Campus Career Portal</div>
    <nav>
        <a href="/student/dashboard">Dashboard</a>
        <a href="/student/logout">Logout</a>
    </nav>
</header>

<section class="profile-container">
    <div class="profile-image">
        <img src="${recruiter.imagePath}" alt="Recruiter Photo">
    </div>
    <div class="profile-details">
        <h2>${recruiter.firstName} ${recruiter.lastName}</h2>
        <p><strong>Objective:</strong> ${recruiter.objective}</p>
        <p><strong>Company:</strong> ${recruiter.companyName}</p>
        <p><strong>Designation:</strong> ${recruiter.designation}</p>
        <p><strong>Email:</strong> ${recruiter.user.email}</p>
        <p><strong>Phone:</strong> ${recruiter.phoneNumber}</p>
        <p><strong>DOB:</strong> ${recruiter.dob}</p>
        <p><strong>Address:</strong> ${recruiter.address}</p>

        <div class="action-buttons">
            <button onclick="location.href='/recruiter/edit'">Edit Profile</button>
        </div>
    </div>
</section>

<section class="education-section">
    <h2>Professional Experience</h2>
    <div class="timeline">
        <c:forEach var="exp" items="${recruiter.experiences}">
            <div class="timeline-entry">
                <h3>${exp.jobTitle} at ${exp.companyName}</h3>
                <p><strong>Experience:</strong> ${exp.yoe} years</p>
                <p>${exp.description}</p>
            </div>
        </c:forEach>
    </div>

    <div id="experienceForm" class="education-form">
        <h3>Add New Experience</h3>
        <form:form method="post" action="/recruiter/add-experience" modelAttribute="experience">
            <form:input path="companyName" placeholder="Company Name" required="true" />
            <form:input path="jobTitle" placeholder="Job Title" required="true" />
            <form:input path="yoe" type="number" step="0.1" min="0" placeholder="Years of Experience" required="true" />
            <form:textarea path="description" placeholder="Describe your role or projects" required="true" rows="4"/>
            <button type="submit">Save</button>
        </form:form>
    </div>

    <div class="action-buttons">
        <button onclick="toggleExperienceForm()">Add Experience</button>
    </div>
</section>


<footer>
    <div class="footer-container">
        <div class="footer-column">
            <h3>About Us</h3>
            <p>Campus Career Portal bridges students, recruiters, and administrators to shape successful careers across universities.</p>
        </div>
        <div class="footer-column">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="/student/login">Student Login</a></li>
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
