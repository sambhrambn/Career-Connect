<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Post a Job</title>
    <style>
        :root {
            --charcoal: #2c2c2c;
            --skyblue: #4aa3df;
            --softwhite: #f5f5f5;
            --hoverblue: #76c7ff;
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
            transition: background-color 0.3s ease;
        }

        .header-actions a:hover {
            background-color: var(--hoverblue);
        }

        .form-container {
            max-width: 900px;
            margin: 3rem auto;
            padding: 2rem 3rem;
            background-color: rgba(255, 255, 255, 0.08);
            border: 1px solid var(--skyblue);
            border-radius: 10px;
            color: var(--softwhite);
            position: relative;
            z-index: 1;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        h2 {
            text-align: center;
            margin-bottom: 2rem;
            color: var(--skyblue);
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        label {
            display: block;
            margin-bottom: 0.4rem;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        textarea,
        select {
            width: 100%;
            padding: 0.6rem;
            border-radius: 6px;
            border: none;
            font-size: 15px;
            background-color: #eee;
            color: #000;
        }

        .form-row {
            display: flex;
            gap: 1.5rem;
        }

        .form-row .form-group {
            flex: 1;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        button {
            width: 100%;
            padding: 0.9rem;
            background-color: var(--skyblue);
            color: var(--charcoal);
            border: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: var(--hoverblue);
        }

        footer {
            background-color: var(--charcoal);
            color: var(--softwhite);
            padding: 2rem 1rem 1rem;
            margin-top: 3rem;
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

        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
            }

            .footer-container {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>

<header>
    <div class="logo">Campus Career Portal</div>
    <div class="header-actions">
        <a href="/recruiter/dashboard">🏠 Dashboard</a>
    </div>
</header>

<div class="form-container">
    <h2>Post a New Job</h2>

    <form:form modelAttribute="job" action="/recruiter/add-job" method="get">

        <div class="form-group">
            <label>Company Name</label>
            <form:input path="companyName"/>
        </div>

        <div class="form-group">
            <label>Job Title</label>
            <form:input path="jobTitle"/>
        </div>

        <div class="form-group">
            <label>Job Description</label>
            <form:textarea path="jobDescription"/>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Job Type</label>
                <form:input path="jobType"/>
            </div>

            <div class="form-group">
                <label>Job Location</label>
                <form:input path="jobLocation"/>
            </div>
        </div>

        <div class="form-group">
            <label>Qualification</label>
            <form:input path="qualification"/>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Salary (₹)</label>
                <form:input path="salary" type="number"/>
            </div>

            <div class="form-group">
                <label>Max Applications</label>
                <form:input path="maxApplications" type="number"/>
            </div>
        </div>

        <div class="form-group">
            <label>Skills Required</label>
            <form:input path="skillsRequired"/>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Work Mode</label>
                <form:select path="workMode">
                    <form:option value="" label="-- Select --"/>
                    <form:option value="Remote"/>
                    <form:option value="On-site"/>
                    <form:option value="Hybrid"/>
                </form:select>
            </div>

            <div class="form-group">
                <label>Visible</label>
                <form:select path="visible">
                    <form:option value="true" label="Yes"/>
                    <form:option value="false" label="No"/>
                </form:select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Posted At</label>
                <form:input path="postedAt" type="date"/>
            </div>

            <div class="form-group">
                <label>Active</label>
                <form:select path="active">
                    <form:option value="true" label="Active"/>
                    <form:option value="false" label="Inactive"/>
                </form:select>
            </div>
        </div>

        <button type="submit">Post Job</button>
    </form:form>
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
                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733547.png" alt="Facebook"/></a>
                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733579.png" alt="Twitter"/></a>
                <a href="#"><img src="https://cdn-icons-png.flaticon.com/512/733/733558.png" alt="LinkedIn"/></a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        © 2025 Campus Career Portal. All rights reserved.
    </div>
</footer>

</body>
</html>
