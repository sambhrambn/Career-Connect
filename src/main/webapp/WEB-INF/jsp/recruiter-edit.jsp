<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Student Registration - Campus Career Portal</title>
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
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        background-color: var(--charcoal);
        color: var(--softwhite);
    }

    header {
        background-color: var(--charcoal);
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 2px solid var(--skyblue);
        z-index: 10;
        position: relative;
    }

    .logo {
        font-size: 1.8rem;
        font-weight: bold;
        color: var(--skyblue);
        user-select: none;
    }

    nav a {
        margin-left: 1.5rem;
        text-decoration: none;
        color: var(--softwhite);
        font-weight: 500;
        transition: color 0.3s ease;
    }

    nav a:hover {
        color: var(--skyblue);
    }

    .background-wrapper {
        position: relative;
        flex: 1;
        background: url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80') no-repeat center center / cover;
    }

    .overlay {
        position: absolute;
        inset: 0;
        background-color: rgba(0, 0, 0, 0.7);
        z-index: 1;
    }

    .content {
        position: relative;
        z-index: 2;
        color: var(--softwhite);
        padding-bottom: 4rem;
    }

    .hero {
        padding: 4rem 2rem 3rem;
        text-align: center;
        animation: fadeInDown 1s ease;
    }

    .hero h1 {
        font-size: 2.8rem;
        color: var(--skyblue);
        letter-spacing: 1.5px;
        margin-bottom: 0.3rem;
    }

    .hero p {
        color: var(--muted);
        font-size: 1rem;
        max-width: 600px;
        margin: auto;
        font-weight: 400;
    }

    .form-container {
        background-color: rgba(56, 56, 56, 0.88);
        margin: 2rem auto 4rem;
        padding: 2.5rem 3rem;
        max-width: 720px;
        border-radius: 12px;
        box-shadow: 0 0 20px rgba(74, 163, 223, 0.5);
        animation: fadeInUp 1.2s ease;
    }

    form {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1.4rem 2rem;
        align-items: center;
    }

    form label[for="skills"],
    form label[for="address"],
    form label[for="imageFile"],
    form label[for="objective"],
    form label[for="phoneNumber"],
    form button,
    form textarea,
    form #skills-container {
        grid-column: span 2;
    }

    label {
        font-weight: 600;
        font-size: 0.95rem;
        margin-bottom: 0.35rem;
        color: var(--skyblue);
        user-select: none;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="date"],
    select,
    textarea,
    input[type="file"] {
        width: 100%;
        padding: 0.55rem 0.75rem;
        border-radius: 6px;
        border: 1.5px solid var(--skyblue);
        background-color: #2c2c2c;
        color: var(--softwhite);
        font-size: 1rem;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
        font-weight: 400;
    }

    input[type="text"]:focus,
    input[type="email"]:focus,
    input[type="password"]:focus,
    input[type="date"]:focus,
    select:focus,
    textarea:focus,
    input[type="file"]:focus {
        outline: none;
        border-color: var(--softwhite);
        box-shadow: 0 0 8px var(--skyblue);
    }

    textarea {
        resize: vertical;
        min-height: 70px;
        font-family: inherit;
    }

    #skill-input-row {
        display: flex;
        gap: 1rem;
    }

    #skill-input-row input {
        flex-grow: 1;
    }

    #add-skill-btn {
        background-color: var(--skyblue);
        border: none;
        padding: 0.5rem 1rem;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 700;
        color: var(--charcoal);
        transition: background-color 0.3s ease;
        user-select: none;
    }

    #add-skill-btn:hover {
        background-color: #3579b8;
    }

    #skills-container {
        margin-top: 0.65rem;
        min-height: 28px;
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .skill-tag {
        background-color: var(--skyblue);
        padding: 0.3rem 0.7rem;
        border-radius: 20px;
        font-weight: 600;
        color: var(--charcoal);
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 0.9rem;
    }

    .skill-tag button {
        background: transparent;
        border: none;
        color: var(--charcoal);
        font-weight: 700;
        cursor: pointer;
        font-size: 1.1rem;
        padding: 0;
    }

    .skill-tag button:hover {
        color: #a1a1a1;
    }

    button[type="submit"] {
        grid-column: span 2;
        background-color: var(--skyblue);
        color: var(--charcoal);
        font-weight: 700;
        padding: 0.9rem 0;
        border-radius: 10px;
        cursor: pointer;
        font-size: 1.25rem;
        transition: background-color 0.3s ease;
        margin-top: 1.3rem;
        user-select: none;
    }

    button[type="submit"]:hover {
        background-color: #3579b8;
    }

    @media (max-width: 650px) {
        form {
            grid-template-columns: 1fr;
        }

        #skill-input-row {
            flex-direction: column;
        }

        #add-skill-btn {
            width: 100%;
        }

        button[type="submit"] {
            font-size: 1.1rem;
        }
    }

    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    footer {
        background-color: #1e1e1e;
        color: var(--softwhite);
        padding: 2rem 2.5rem;
        border-top: 2px solid var(--skyblue);
    }

    .footer-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        gap: 2rem;
    }

    .footer-column h3 {
        color: var(--skyblue);
        margin-bottom: 1rem;
        font-size: 1.2rem;
    }

    .footer-column p, .footer-column a {
        font-size: 0.95rem;
        color: var(--softwhite);
        line-height: 1.6;
        text-decoration: none;
    }

    .footer-column ul {
        list-style: none;
        padding: 0;
    }

    .footer-column li {
        margin-bottom: 0.5rem;
    }

    .footer-column a:hover {
        color: var(--skyblue);
    }

    .social-icons img {
        width: 24px;
        margin-right: 10px;
        filter: brightness(0.9);
        transition: filter 0.3s ease;
    }

    .social-icons img:hover {
        filter: brightness(1.3);
    }

    .footer-bottom {
        text-align: center;
        margin-top: 2rem;
        font-size: 0.85rem;
        color: var(--muted);
    }
</style>
</head>
<body>

<header>
    <div class="logo">Campus Career Portal</div>
    <nav>
        <a href="/recruiter/profile">Back</a>
        <a href="/recruiter/logout">Logout</a>
    </nav>
</header>

<div class="background-wrapper">
    <div class="overlay"></div>
    <div class="content">
        <section class="hero">
            <h1>Recruiter Edit</h1>
            <p>Please update the details below to your recruiter account.</p>
        </section>

        <div class="form-container">
            <form:form modelAttribute="recruiter" method="post" action="/recruiter/update" enctype="multipart/form-data" id="registrationForm">

                <label for="email">Email:</label>
                <form:input path="email" id="email" type="email" placeholder="you@example.com" required="required" />

                <label for="password">Password:</label>
                <form:password path="password" id="password" placeholder="Min 6 characters" minlength="6" />

                <label for="role">Role:</label>
                <form:select path="role" id="role" required="required">
                    <form:option value="" label="-- Select Role --" />
                    <form:option value="STUDENT" label="Student" />
                    <form:option value="RECRUITER" label="Recruiter" />
                    <form:option value="ADMIN" label="Admin" />
                </form:select>

                <label for="firstName">First Name:</label>
                <form:input path="firstName" id="firstName" type="text" placeholder="First Name" required="required" />

                <label for="lastName">Last Name:</label>
                <form:input path="lastName" id="lastName" type="text" placeholder="Last Name" required="required" />

                <label for="companyName">Company Name:</label>
                <form:input path="companyName" id="companyName" type="text" placeholder="Company Name" required="required" />

                <label for="designation">Designation:</label>
                <form:input path="designation" id="designation" type="text" placeholder="Designation" required="required" />


                <label for="dob">Date of Birth:</label>
                <form:input path="dob" id="dob" type="date" placeholder="YYYY-MM-DD" required="required" />

                <label for="gender">Gender:</label>
                <form:select path="gender" id="gender" required="required">
                    <form:option value="" label="-- Select Gender --" />
                    <form:option value="MALE" label="Male" />
                    <form:option value="FEMALE" label="Female" />
                    <form:option value="OTHER" label="Other" />
                </form:select>

                <label for="phoneNumber">Phone Number:</label>
                <form:input path="phoneNumber" id="phoneNumber" type="text" placeholder="+1 234 567 8901" pattern="^\+?[0-9\s\-]{7,15}$" title="Enter valid phone number" required="required" />

                <label for="objective">Objective:</label>
                <form:textarea path="objective" id="objective" placeholder="Write a brief career objective or summary..." maxlength="500" rows="4" />

                <label for="address">Address:</label>
                <form:input path="address" id="address" type="text" placeholder="Your address" />

                <label for="imageFile">Upload Profile Image:</label>
                <form:input path="imageFile" id="imageFile" type="file" accept="image/*" />

                <button type="submit">Update</button>
            </form:form>
        </div>
    </div>
</div>

<!-- ✅ NEW FOOTER SECTION -->
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
