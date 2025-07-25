<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Campus Career Portal</title>
    <style>
        :root {
            --charcoal: #2c2c2c;
            --skyblue: #4aa3df;
            --softwhite: #f5f5f5;
            --muted: #cccccc;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--charcoal);
            color: var(--softwhite);
        }

        header {
            background-color: var(--charcoal);
            padding: 1.2rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--skyblue);
        }

        .logo {
            font-size: 2rem;
            font-weight: bold;
            color: var(--skyblue);
        }

        nav a {
            margin-left: 2rem;
            text-decoration: none;
            color: var(--softwhite);
            font-weight: 500;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: var(--skyblue);
        }

        .hero {
            background: linear-gradient(rgba(44, 44, 44, 0.85), rgba(44, 44, 44, 0.85)),
                        url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover;
            padding: 5rem 4rem;
            text-align: center;
            animation: fadeInDown 1s ease-in-out;
        }

        .hero h1 {
            font-size: 3.2rem;
            color: var(--skyblue);
            margin-bottom: 1rem;
        }

        .hero p {
            font-size: 1.2rem;
            color: var(--muted);
            max-width: 900px;
            margin: auto;
        }

        .cta-buttons {
            margin-top: 2.5rem;
        }

        .cta-buttons a {
            background-color: var(--skyblue);
            color: var(--charcoal);
            padding: 0.8rem 1.8rem;
            text-decoration: none;
            font-weight: bold;
            border-radius: 8px;
            margin: 0 1rem;
            transition: background-color 0.3s ease;
        }

        .cta-buttons a:hover {
            background-color: #3592d6;
        }

        .features {
            display: flex;
            justify-content: space-around;
            padding: 3rem 5rem;
            background-color: #383838;
            gap: 2rem;
            animation: fadeInUp 1.2s ease-in-out;
        }

        .feature-card {
            background-color: #2e2e2e;
            padding: 2rem;
            border-radius: 12px;
            text-align: center;
            flex: 1;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            border: 1px solid var(--skyblue);
        }

        .feature-card h2 {
            color: var(--skyblue);
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .feature-card p {
            color: var(--softwhite);
            font-size: 1rem;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* New Footer Styles */
        footer {
            background-color: #1f1f1f;
            color: var(--muted);
            border-top: 2px solid #4aa3df;
            margin-top: 3rem;
            font-size: 0.95rem;
        }

        .footer-container {
            display: flex;
            justify-content: space-between;
            padding: 2.5rem 4rem;
            flex-wrap: wrap;
        }

        .footer-column {
            flex: 1;
            min-width: 220px;
            margin-bottom: 1.5rem;
        }

        .footer-column h3 {
            color: var(--skyblue);
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .footer-column p,
        .footer-column li {
            color: var(--softwhite);
            font-size: 0.95rem;
            line-height: 1.6;
        }

        .footer-column ul {
            list-style: none;
            padding: 0;
        }

        .footer-column li a {
            color: var(--softwhite);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-column li a:hover {
            color: var(--skyblue);
        }

        .footer-bottom {
            text-align: center;
            padding: 1rem;
            background-color: #161616;
            font-size: 0.85rem;
            color: var(--muted);
            border-top: 1px solid #333;
        }

        .social-icons {
            margin-top: 1rem;
        }

        .social-icons a {
            display: inline-block;
            margin-right: 0.8rem;
            transition: transform 0.3s ease;
        }

        .social-icons a:hover {
            transform: scale(1.1);
        }

        .social-icons img {
            width: 24px;
            height: 24px;
            filter: brightness(0) invert(1);
        }

        @media (max-width: 900px) {
            .features {
                flex-direction: column;
                padding: 2rem;
            }

            .feature-card {
                margin-bottom: 1.5rem;
            }

            .hero h1 {
                font-size: 2.2rem;
            }

            .cta-buttons a {
                display: block;
                margin: 1rem auto;
            }

            nav a {
                margin-left: 1rem;
            }

            .footer-container {
                flex-direction: column;
                padding: 2rem;
            }

            .footer-column {
                margin-bottom: 2rem;
            }
        }
    </style>
</head>
<body>

<header>
    <div class="logo">Campus Career Portal</div>
    <nav>
        <a href="/student/student-form">Student</a>
        <a href="/recruiter/login">Recruiter</a>
        <a href="/admin/login">Admin</a>
    </nav>
</header>

<section class="hero">
    <h1>Empowering Futures, Connecting Talent</h1>
    <p>Welcome to the Campus Career Portal — your all-in-one platform to explore jobs, manage applications, and unlock your professional journey. Students, recruiters, and admins — everything you need is here.</p>
    <div class="cta-buttons">
        <a href="/student/register-form">Join as Student</a>
        <a href="/recruiter/register-form">Join as Recruiter</a>
    </div>
</section>

<section class="features">
    <div class="feature-card">
        <h2>🎓 For Students</h2>
        <p>Create professional profiles, upload resumes, and apply to job and internship listings tailored to your skills.</p>
    </div>
    <div class="feature-card">
        <h2>🏢 For Recruiters</h2>
        <p>Post job openings, manage applications, and connect with top student talent from across the country.</p>
    </div>
    <div class="feature-card">
        <h2>🛡️ Admin Supervision</h2>
        <p>Every user is approved by an admin to ensure a secure and trustworthy platform for everyone.</p>
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

</footer>

</body>
</html>
