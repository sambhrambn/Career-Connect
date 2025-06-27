<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Student Dashboard - Campus Career Portal</title>
    <style>
        :root {
            --charcoal: #2c2c2c;
            --skyblue: #4aa3df;
            --softwhite: #f5f5f5;
            --muted: #cccccc;
            --card-bg: #3b3b3b;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(rgba(44,44,44,0.9), rgba(44,44,44,0.9)),
                url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover;
            color: var(--softwhite);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background-color: var(--charcoal);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--skyblue);
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: var(--skyblue);
        }

        nav a {
            color: var(--softwhite);
            margin-left: 1.5rem;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: var(--skyblue);
        }

        main {
            flex: 1;
            padding: 3rem 4rem;
        }

        h1 {
            font-size: 2.6rem;
            margin-bottom: 1rem;
            color: var(--skyblue);
            animation: fadeInDown 1s ease forwards;
        }

        p.subtitle {
            font-size: 1.2rem;
            color: var(--muted);
            margin-bottom: 3rem;
            animation: fadeInUp 1s ease forwards;
            animation-delay: 0.3s;
        }

        .dashboard-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            animation: fadeInUp 1s ease forwards;
            animation-delay: 0.6s;
            margin-bottom: 3rem;
        }

        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--skyblue);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            color: var(--skyblue);
            margin-bottom: 0.5rem;
        }

        .card p {
            font-size: 1rem;
            color: var(--softwhite);
            line-height: 1.4;
        }

        .course-videos {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 2rem;
            animation: fadeInUp 1s ease forwards;
        }

        .course-card {
            background-color: var(--card-bg);
            border: 1px solid var(--skyblue);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease;
        }

        .course-card:hover {
            transform: translateY(-5px);
        }

        .course-info {
            padding: 1rem 1.5rem;
            flex-grow: 1;
        }

        .course-info h4 {
            color: var(--skyblue);
            margin-bottom: 0.3rem;
            font-size: 1.2rem;
        }

        .course-info p {
            font-size: 0.95rem;
            color: var(--softwhite);
            margin-bottom: 0.5rem;
        }

        .course-info .instructor {
            font-style: italic;
            color: var(--muted);
            font-size: 0.9rem;
        }

        .course-video iframe {
            width: 100%;
            height: 180px;
            border: none;
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
            padding: 0;
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

        @keyframes fadeInDown {
            from {opacity: 0; transform: translateY(-40px);}
            to {opacity: 1; transform: translateY(0);}
        }

        @keyframes fadeInUp {
            from {opacity: 0; transform: translateY(40px);}
            to {opacity: 1; transform: translateY(0);}
        }

        @media (max-width: 900px) {
            main {
                padding: 2rem;
            }

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
        <a href="/student/resume">Resume</a>
        <a href="/student/all-jobs">Jobs</a>
        <a href="/student/logout">Logout</a>
    </nav>
</header>

<main>
    <h1>Welcome, ${student.firstName}!</h1>
    <p class="subtitle">Your dashboard gives you quick access to your profile, job applications, and opportunities.</p>

    <section class="dashboard-section">
        <div class="card">
            <h3>Profile Summary</h3>
            <p><strong>Name:</strong> ${student.firstName} ${student.lastName}</p>
            <p><strong>Email:</strong> ${user.email}</p>
            <p><strong>Skills:</strong> ${student.skills}</p>
        </div>

        <div class="card">
            <h3>Application Stats</h3>
            <p><strong>Total Applications:</strong> ${applicationCount}</p>
            <p><strong>Jobs Bookmarked:</strong> ${bookmarkedCount}</p>
            <p><strong>Shortlisted:</strong> ${shortListedCount}</p>
        </div>

        <div class="card">
            <h3>Recommended Job</h3>
            <c:choose>
                <c:when test="${not empty recommendedJob}">
                    <p><strong>Title:</strong> ${recommendedJob.title}</p>
                    <p><strong>Company:</strong> ${recommendedJob.companyName}</p>
                    <p><strong>Location:</strong> ${recommendedJob.location}</p>
                </c:when>
                <c:otherwise>
                    <p>No recommendations at this time.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <h2 style="color: var(--skyblue); margin-bottom: 1rem;">Your Registered Courses</h2>
    <section class="course-videos">
        <c:forEach var="course" items="${courses}">
            <div class="course-card">
                <div class="course-video">
                    <iframe
                        src="${course.embedLink}"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowfullscreen
                        title="${course.courseName}">
                    </iframe>
                </div>
                <div class="course-info">
                    <h4>${course.courseName}</h4>
                    <p>${course.courseDescription}</p>
                    <p class="instructor">Instructor: ${course.courseInstructor}</p>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty courses}">
            <p style="color: var(--muted); font-style: italic;">You have not registered for any courses yet.</p>
        </c:if>
    </section>
</main>

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
