<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Recruiter Job Posts - Campus Career Portal</title>
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
      background: linear-gradient(rgba(44, 44, 44, 0.9), rgba(44, 44, 44, 0.9)),
        url('https://images.unsplash.com/photo-1542744173-8e7e53415bb0') no-repeat center center/cover;
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
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 2rem;
      animation: fadeInUp 1s ease forwards;
      animation-delay: 0.6s;
      margin-bottom: 3rem;
    }

    .Job {
      background-color: var(--card-bg);
      border: 1px solid var(--skyblue);
      border-radius: 12px;
      padding: 1.5rem;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
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
      font-size: 1rem;
      color: var(--softwhite);
      line-height: 1.4;
    }

    footer {
      background-color: var(--charcoal);
      color: var(--muted);
      padding: 2rem 2rem 1rem;
    }

    .footer-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      gap: 2rem;
    }

    .footer-column {
      flex: 1 1 250px;
    }

    .footer-column h3 {
      color: var(--skyblue);
      margin-bottom: 1rem;
    }

    .footer-column ul {
      list-style: none;
      padding-left: 0;
    }

    .footer-column ul li {
      margin-bottom: 0.5rem;
    }

    .footer-column ul li a {
      color: var(--softwhite);
      text-decoration: none;
      transition: color 0.3s ease;
    }

    .footer-column ul li a:hover {
      color: var(--skyblue);
    }

    .social-icons a {
      display: inline-block;
      margin-right: 10px;
    }

    .social-icons img {
      width: 24px;
      height: 24px;
      filter: grayscale(100%) brightness(1.2);
      transition: filter 0.3s ease;
    }

    .social-icons img:hover {
      filter: none;
    }

    .footer-bottom {
      text-align: center;
      padding-top: 1rem;
      border-top: 1px solid #444;
      margin-top: 2rem;
      font-size: 0.9rem;
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
      <div class="Job">
        <c:forEach var="job" items="${jobList}">
          <div class="Job">
            <h3>${job.title}</h3>
            <p><strong>Location:</strong> ${job.jobLocation}</p>
            <p><strong>Workmode:</strong> ${job.workMode}</p>
            <p><strong>Type:</strong> ${job.jobType}</p>
          </div>
        </c:forEach>

      </div>
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
