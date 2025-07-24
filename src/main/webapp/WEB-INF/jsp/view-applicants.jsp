<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>View Applicants - Campus Career Portal</title>
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
      background: url('https://images.unsplash.com/photo-1542744173-8e7e53415bb0') no-repeat center center fixed;
      background-size: cover;
      position: relative;
      color: var(--softwhite);
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
      padding: 0.4rem 0.8rem;
      border-radius: 6px;
      transition: background-color 0.3s ease;
    }

    nav a:hover {
      background-color: var(--hoverblue);
      color: var(--charcoal);
    }

    main {
      max-width: 1200px;
      margin: 3rem auto;
      padding: 2rem;
    }

    h1 {
      font-size: 2.4rem;
      margin-bottom: 0.5rem;
      color: var(--skyblue);
    }

    .subtitle {
      color: var(--muted);
      margin-bottom: 2rem;
    }

    .dashboard-section {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 2rem;
    }

    .applicant-card {
      background-color: rgba(255, 255, 255, 0.08);
      border: 1px solid var(--skyblue);
      border-radius: 12px;
      padding: 1.5rem;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
      transition: transform 0.3s ease;
    }

    .applicant-card:hover {
      transform: translateY(-5px);
    }

    .applicant-card h3 {
      color: var(--skyblue);
      margin-bottom: 0.5rem;
    }

    .applicant-card p {
      font-size: 0.95rem;
      line-height: 1.4;
    }

    .btn-group {
      margin-top: 1rem;
    }

    .btn {
      padding: 0.5rem 1.2rem;
      background-color: var(--skyblue);
      color: var(--charcoal);
      font-weight: bold;
      text-decoration: none;
      border-radius: 6px;
      transition: background-color 0.3s ease;
      margin-right: 0.8rem;
      cursor: pointer;
    }

    .btn:hover {
      background-color: var(--hoverblue);
    }

    .btn.reject {
      background-color: #e74c3c;
      color: #fff;
    }

    .btn.reject:hover {
      background-color: #c0392b;
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
      nav {
        flex-direction: column;
        gap: 0.5rem;
      }

      .dashboard-section {
        grid-template-columns: 1fr;
      }

      main {
        padding: 1rem;
      }
    }
  </style>
</head>
<body>

<header>
  <div class="logo">Campus Career Portal</div>
  <nav>
    <a href="/recruiter/dashboard2">Back</a>
    <a href="/recruiter/post-Jobs">Posted Jobs</a>
    <a href="/recruiter/logout">Logout</a>
  </nav>
</header>

<main>
  <h1>Applicants</h1>
  <p class="subtitle">Check who applied to your job listings and take actions like shortlist or reject.</p>

  <section class="dashboard-section">
    <c:forEach var="applicant" items="${applicants}">
      <div class="applicant-card">
        <h3>${applicant.student.firstName} ${applicant.student.lastName}</h3>
        <p><strong>Applied For:</strong> ${applicant.job.jobTitle}</p>
        <p><strong>Email:</strong> ${applicant.student.user.email}</p>
        <p><strong>Work mode:</strong> ${applicant.job.workMode}</p>
        <p><strong>Skills:</strong> ${applicant.student.skills}</p>
        <div class="btn-group">
          <a class="btn" href="/recruiter/short-list/${applicant.id}">Shortlist</a>
          <a class="btn reject" href="/recruiter/reject/${applicant.id}">Reject</a>
        </div>
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
