<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Recruiter Dashboard - Campus Career Portal</title>
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
            font-weight: bold;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: var(--hoverblue);
        }

        main {
            padding: 3rem 4rem;
        }

        h1 {
            font-size: 2.6rem;
            margin-bottom: 0.8rem;
            color: var(--skyblue);
        }

        p.subtitle {
            font-size: 1.2rem;
            color: #bbbbbb;
            margin-bottom: 2.5rem;
        }

        .dashboard-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
        }

        .card {
            background-color: rgba(255, 255, 255, 0.08);
            border: 1px solid var(--skyblue);
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-6px);
        }

        .card h3 {
            color: var(--skyblue);
            margin-bottom: 0.5rem;
        }

        .card p {
            font-size: 1rem;
            color: var(--softwhite);
            line-height: 1.5;
        }

        .btn {
            margin-top: 1rem;
            display: inline-block;
            padding: 0.6rem 1.2rem;
            background-color: var(--skyblue);
            color: var(--charcoal);
            font-weight: bold;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
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
        <a href="/recruiter/profile">Profile</a>
        <a href="/recruiter/post-jobs">Posted Job</a>
        <a href="/recruiter/applicants">Applicants</a>
        <a href="/logout">Logout</a>
    </nav>
</header>

<main>
    <h1>Welcome, ${recruiter.firstName}!</h1>
    <p class="subtitle">Manage your job posts, view applicants, and find top talent for your company.</p>

    <section class="dashboard-section">
        <div class="card">
            <h3>Profile Summary</h3>
            <p><strong>Name:</strong> ${recruiter.firstName} ${recruiter.lastName}</p>
            <p><strong>Company:</strong> ${recruiter.companyName}</p>
            <p><strong>Designation:</strong> ${recruiter.designation}</p>
        </div>

        <div class="card">
            <h3>Post a New Job</h3>
            <p>Create job opportunities and publish them to attract talented students.</p>
            <a class="btn" href="/recruiter/job-form">Post Job</a>
        </div>

        <div class="card">
            <h3>View Applicants</h3>
            <p>Check who applied to your job listings and take actions like shortlist or reject.</p>
            <a class="btn" href="/recruiter/applicants">View Applicants</a>
        </div>

        <div class="card">
            <h3>Analysis (Coming Soon)</h3>
            <p>Monitor performance of your job posts, track applicant trends, and much more.</p>
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
