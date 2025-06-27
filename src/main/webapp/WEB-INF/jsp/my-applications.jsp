<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Applications</title>
    <style>
        :root {
            --charcoal: #2c2c2c;
            --skyblue: #4aa3df;
            --softwhite: #f5f5f5;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            height: auto;
            min-height: 100%;
            position: relative;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
            background-size: cover;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            z-index: 0;
            pointer-events: none;
        }

        header, .hero, .job-listings, footer {
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

        nav a {
            margin-left: 1.5rem;
            color: var(--softwhite);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: var(--skyblue);
        }

        .hero {
            text-align: center;
            padding: 3rem 1rem 1rem;
        }

        .hero h1 {
            font-size: 2.5rem;
            color: var(--skyblue);
            margin-bottom: 1rem;
        }

        .job-listings {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            padding: 2rem 3rem;
        }

        .job-card {
            background-color: rgba(255, 255, 255, 0.08);
            color: var(--softwhite);
            border: 1px solid var(--skyblue);
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            transition: transform 0.3s ease;
        }

        .job-card:hover {
            transform: translateY(-5px);
        }

        .job-card h3 {
            color: var(--skyblue);
            font-size: 1.4rem;
            margin-bottom: 0.6rem;
        }

        .job-card p {
            font-size: 0.95rem;
            margin-bottom: 0.4rem;
        }

        .actions {
            margin-top: 1rem;
        }

        .actions a {
            background-color: var(--skyblue);
            color: var(--charcoal);
            text-decoration: none;
            padding: 0.5rem 1.2rem;
            margin-right: 1rem;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .actions a:hover {
            background-color: #3592d6;
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
            nav a {
                margin-left: 1rem;
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
    <nav>
        <a href="/student/student-profile">Profile</a>
        <a href="/student/my-applications">My Applications</a>
        <a href="/student/bookmarked-jobs">My Bookmarks</a>
        <a href="/student/all-jobs">Jobs</a>
        <a href="/student/logout">Logout</a>
    </nav>
</header>

<section class="hero">
    <h1>Jobs You've Applied To</h1>
</section>

<section class="job-listings">
    <c:forEach var="application" items="${applications}">
        <div class="job-card">
            <h3>${application.job.jobTitle}</h3>
            <p><strong>Company:</strong> ${application.job.companyName}</p>
            <p><strong>Location:</strong> ${application.job.jobLocation}</p>
            <p><strong>Status:</strong> ${application.status}</p>
            <p><strong>Applied On:</strong> ${application.appliedAt}</p>
            <div class="actions">
                <a href="/student/view/${application.job.id}">View Job</a>
            </div>
        </div>
    </c:forEach>
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
