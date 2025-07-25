<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Campus Career Portal</title>
    <style>
        :root {
            --charcoal: #2c2c2c;
            --skyblue: #4aa3df;
            --softwhite: #f5f5f5;
            --hoverblue: #76c7ff;
            --cardbg: rgba(255, 255, 255, 0.08);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80') no-repeat center center fixed;
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

        header, footer, .container {
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
            flex-wrap: wrap;
        }

        header h1 {
            font-size: 1.6rem;
            color: var(--skyblue);
        }

        nav a {
            color: var(--softwhite);
            text-decoration: none;
            margin-left: 1.5rem;
            font-weight: bold;
            font-size: 1rem;
            transition: color 0.2s ease;
        }

        nav a:hover {
            color: var(--hoverblue);
        }

        .container {
            padding: 2rem;
        }

        .dashboard-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 2rem;
        }

        .card {
            flex: 1;
            min-width: 250px;
            background-color: var(--cardbg);
            padding: 1.5rem;
            border: 1px solid var(--skyblue);
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        .card h2 {
            font-size: 1.1rem;
            color: var(--skyblue);
            margin-bottom: 0.5rem;
        }

        .card p {
            font-size: 2rem;
            font-weight: bold;
            color: var(--softwhite);
        }

        .section {
            margin-bottom: 2.5rem;
        }

        .section h3 {
            color: var(--skyblue);
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .actions a {
            padding: 0.7rem 1.2rem;
            background-color: var(--skyblue);
            color: var(--charcoal);
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .actions a:hover {
            background-color: var(--hoverblue);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: var(--cardbg);
            border: 1px solid var(--skyblue);
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: left;
            color: var(--softwhite);
        }

        th {
            background-color: var(--skyblue);
            color: var(--charcoal);
        }

        tr:nth-child(even) {
            background-color: rgba(255, 255, 255, 0.04);
        }

        footer {
            background-color: var(--charcoal);
            color: var(--softwhite);
            text-align: center;
            padding: 1.5rem;
            margin-top: 3rem;
            border-top: 1px solid var(--skyblue);
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                align-items: flex-start;
            }

            nav {
                margin-top: 10px;
            }

            .dashboard-cards {
                flex-direction: column;
            }

            .actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<header>
    <h1>Campus Career Portal | Admin Dashboard</h1>
    <nav>
        <a href="/admin/students">Students</a>
        <a href="/admin/recruiters">Recruiters</a>
        <a href="/admin/jobs">Jobs</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/logout">Logout</a>
    </nav>
</header>

<div class="container">

    <div class="dashboard-cards">
        <div class="card">
            <h2>Total Students</h2>
            <p>${totalStudents}</p>
        </div>
        <div class="card">
            <h2>Total Recruiters</h2>
            <p>${totalRecruiters}</p>
        </div>
        <div class="card">
            <h2>Total Jobs</h2>
            <p>${totalJobs}</p>
        </div>
    </div>

    <div class="section">
        <h3>Quick Access</h3>
        <div class="actions">
            <a href="/admin/students">View All Students</a>
            <a href="/admin/recruiters">View All Recruiters</a>
            <a href="/admin/jobs">View All Jobs</a>
            <a href="/admin/users">Manage Users</a>
            <a href="/admin/toggle">Toggle Job Visibility</a>
            <a href="/admin/status">View Detailed Status</a>
        </div>
    </div>

    <div class="section">
        <h3>Recent Registered Users</h3>
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Role</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Registered At</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${recentUsers}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.role}</td>
                        <td><c:choose>
                                          <c:when test="${user.role == 'RECRUITER'}">
                                            ${user.recruiter.firstName} ${user.recruiter.lastName}
                                          </c:when>
                                          <c:when test="${user.role == 'STUDENT'}">
                                            ${user.student.firstName} ${user.student.lastName}
                                          </c:when>
                                          <c:otherwise>
                                            ${user.firstName} ${user.lastName}
                                          </c:otherwise>
                                        </c:choose></td>
                        <td>${user.email}</td>
                        <td><c:choose>
                                                    <c:when test="${user.role == 'RECRUITER'}">
                                                     ${user.recruiter.createdAt}
                                                    </c:when>
                                                    <c:when test="${user.role == 'STUDENT'}">
                                                      ${user.student.createdAt}
                                                    </c:when>
                                                    <c:otherwise>
                                                      ${user.firstName} ${user.lastName}
                                                    </c:otherwise>
                                                  </c:choose></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="section">
        <h3>Recently Posted Jobs</h3>
        <table>
            <thead>
                <tr>
                    <th>Job ID</th>
                    <th>Title</th>
                    <th>Recruiter</th>
                    <th>Type</th>
                    <th>Location</th>
                    <th>Posted At</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="job" items="${recentJobs}">
                    <tr>
                        <td>${job.id}</td>
                        <td>${job.jobTitle}</td>
                        <td>${job.recruiter.companyName}</td>
                        <td>${job.jobType}</td>
                        <td>${job.jobLocation}</td>
                        <td>${job.postedAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</div>

<footer>
    &copy; 2025 Campus Career Portal - Admin Panel. All rights reserved.
</footer>

</body>
</html>
