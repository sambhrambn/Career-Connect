<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Job Details</title>
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

        /* Full dark overlay */
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

        .container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: rgba(255, 255, 255, 0.08);
            border: 1px solid var(--skyblue);
            border-radius: 10px;
            color: var(--softwhite);
            position: relative;
            z-index: 1;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        h1 {
            text-align: center;
            color: var(--skyblue);
            margin-bottom: 1.5rem;
        }

        .job-info {
            margin-bottom: 1rem;
        }

        .job-info strong {
            color: var(--skyblue);
            display: inline-block;
            width: 180px;
        }

        .apply-button {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
        }

        .apply-button a {
            text-decoration: none;
            padding: 0.75rem 2rem;
            background-color: var(--skyblue);
            color: var(--charcoal);
            font-size: 1rem;
            font-weight: bold;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }

        .apply-button a:hover {
            background-color: var(--hoverblue);
        }

        .apply-button .applied {
            background-color: gray;
            color: white;
            padding: 0.75rem 2rem;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: not-allowed;
        }


        .apply-button .status-other {
            background-color: orange;
            color: white;
            padding: 0.75rem 2rem;
            font-size: 1rem;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: not-allowed;
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

        @media (max-width: 768px) {
            .job-info strong {
                width: 100%;
                display: block;
                margin-bottom: 0.4rem;
            }

            .header-actions {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
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
       <a href="/student/all-jobs">🚪 Jobs</a>
        <a href="/student/bookmark/${job.id}">🔖 Bookmark</a>
        <a href="/student/logout">🚪 Logout</a>
    </div>
</header>

<div class="container">
    <h1>${job.jobTitle}</h1>
    <div class="job-info"><strong>Description:</strong> ${job.jobDescription}</div>
    <div class="job-info"><strong>Type:</strong> ${job.jobType}</div>
    <div class="job-info"><strong>Location:</strong> ${job.jobLocation}</div>
    <div class="job-info"><strong>Qualification Required:</strong> ${job.qualification}</div>
    <div class="job-info"><strong>Salary:</strong> ₹${job.salary}</div>
    <div class="job-info"><strong>Skills Required:</strong> ${job.skillsRequired}</div>
    <div class="job-info"><strong>Work Mode:</strong> ${job.workMode}</div>
    <div class="job-info"><strong>Max Applications:</strong> ${job.maxApplications}</div>
    <div class="job-info"><strong>Visibility:</strong>
        <c:choose>
            <c:when test="${job.visible}">Visible</c:when>
            <c:otherwise>Hidden</c:otherwise>
        </c:choose>
    </div>
    <div class="job-info"><strong>Posted At:</strong> ${job.postedAt}</div>
    <div class="job-info"><strong>Status:</strong>
        <c:choose>
            <c:when test="${job.active}">Active</c:when>
            <c:otherwise>Inactive</c:otherwise>
        </c:choose>
    </div>

    <div class="apply-button">
        <c:choose>
                <c:when test="${status == 'APPLIED'}">
                    <button class="applied" disabled>Applied</button>
                </c:when>

                <c:when test="${empty status}">
                    <a href="/student/apply/${job.id}">Apply Now</a>
                </c:when>

                <c:otherwise>
                    <button class="status-other" disabled>${status}</button>
                </c:otherwise>
            </c:choose>
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
