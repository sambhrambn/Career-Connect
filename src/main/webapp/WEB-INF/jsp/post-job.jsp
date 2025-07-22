<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Recruiter Job Posts - Campus Career Portal</title>
  <style>
    :root {
      --charcoal: #2c2c2c;
      --skyblue: #4aa3df;
      --hoverblue: #76c7ff;
      --softwhite: #f5f5f5;
      --muted: #cccccc;
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

    header, footer, main {
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
      color: var(--softwhite);
      margin-left: 1.2rem;
      text-decoration: none;
      font-weight: bold;
      transition: color 0.3s ease;
    }

    nav a:hover {
      color: var(--hoverblue);
    }

    main {
      max-width: 1200px;
      margin: 4rem auto;
      padding: 2rem;
      color: var(--softwhite);
    }

    h1 {
      font-size: 2.5rem;
      margin-bottom: 0.5rem;
      color: var(--skyblue);
    }

    p.subtitle {
      font-size: 1.2rem;
      color: var(--muted);
      margin-bottom: 2rem;
    }

    .dashboard-section {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 2rem;
    }

    .Job {
      background-color: rgba(255, 255, 255, 0.08);
      border: 1px solid var(--skyblue);
      border-radius: 10px;
      padding: 1.5rem;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
      transition: transform 0.3s ease;
    }

    .Job:hover {
      transform: translateY(-5px);
    }

    .Job h3 {
      color: var(--skyblue);
      margin-bottom: 0.5rem;
    }

    .Job p {
      color: var(--softwhite);
      margin-bottom: 0.3rem;
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
    <a href="/Post Job">Post Jobs</a>
    <a href="/Application">Application</a>
    <a href="/Messages">Messages</a>
    <a href="/Settings">Settings</a>
    <a href="/logout">Logout</a>
  </nav>
</header>

<main>
  <h1>Job Posts</h1>
  <p class="subtitle">Easily manage job postings, and find the right talent for your company.</p>

  <section class="dashboard-section">
    <c:forEach var="job" items="${jobList}">
      <div class="Job">
        <h3>${job.jobTitle}</h3>
        <p><strong>Location:</strong> ${job.jobLocation}</p>
        <p><strong>Workmode:</strong> ${job.workMode}</p>
        <p><strong>Type:</strong> ${job.jobType}</p>
      </div>
    </c:forEach>
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
