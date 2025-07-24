<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - View All Recruiters</title>
    <style>
        :root {
            --charcoal: #2c2c2c;
            --skyblue: #4aa3df;
            --softwhite: #f5f5f5;
            --hoverblue: #76c7ff;
            --danger: #dc3545;
            --success: #28a745;
            --warning: #ffc107;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            height: 100%;
            font-family: 'Segoe UI', sans-serif;
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

        header {
            position: relative;
            z-index: 2;
            background-color: var(--charcoal);
            color: var(--softwhite);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-btn {
            text-decoration: none;
            background-color: var(--skyblue);
            color: var(--charcoal);
            font-weight: bold;
            padding: 0.4rem 0.8rem;
            border-radius: 5px;
        }

        .back-btn:hover {
            background-color: var(--hoverblue);
        }

        .logo-text {
            font-size: 1.6rem;
            font-weight: bold;
            color: var(--skyblue);
        }

        .logout-btn {
            text-decoration: none;
            background-color: var(--danger);
            color: white;
            padding: 0.4rem 0.9rem;
            border-radius: 5px;
            font-weight: bold;
        }

        .logout-btn:hover {
            background-color: #c82333;
        }

        .container {
            padding: 2rem;
            position: relative;
            z-index: 2;
            color: var(--softwhite);
        }

        .section-title {
            margin-bottom: 20px;
            font-size: 24px;
            color: var(--skyblue);
        }

        .search-bar input[type="text"] {
            padding: 10px;
            width: 320px;
            max-width: 100%;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.08);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            margin-top: 20px;
            color: var(--softwhite);
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid rgba(255,255,255,0.2);
            text-align: left;
        }

        th {
            background-color: rgba(74, 163, 223, 0.2);
            color: var(--skyblue);
        }

        tr:nth-child(even) {
            background-color: rgba(255,255,255,0.05);
        }

        .actions a {
            text-decoration: none;
            padding: 6px 12px;
            margin-right: 6px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            color: white;
        }

        .approve-btn { background-color: var(--success); }
        .reject-btn  { background-color: var(--danger); }
        .view-btn    { background-color: var(--skyblue); }

        .status-pill {
            padding: 5px 10px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: bold;
            color: white;
        }

        .approved { background-color: var(--success); }
        .pending  { background-color: var(--warning); color: #000; }
        .rejected { background-color: var(--danger); }

        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead {
                display: none;
            }

            tr {
                margin-bottom: 15px;
            }

            td {
                padding-left: 50%;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                top: 12px;
                font-weight: bold;
                color: var(--skyblue);
            }
        }
    </style>
</head>
<body>

<header>
    <div class="header-left">
        <a href="/admin/dashboard" class="back-btn">← Back</a>
        <div class="logo-text">Career Connect</div>
    </div>
    <a href="/logout" class="logout-btn">Logout</a>
</header>

<div class="container">
    <div class="section-title">All Registered Recruiters</div>

    <div class="search-bar">
        <input type="text" placeholder="Search by company or email..." id="searchInput" onkeyup="filterRecruiters()" />
    </div>

    <table id="recruiterTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>Company Name</th>
            <th>Recruiter Name</th>
            <th>Email</th>
            <th>Designation</th>
            <th>Joined</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="recruiter" items="${recruiters}">
            <tr>
                <td data-label="ID">${recruiter.id}</td>
                <td data-label="Company Name">${recruiter.companyName}</td>
                <td data-label="Recruiter Name">${recruiter.firstName} ${recruiter.lastName}</td>
                <td data-label="Email">${recruiter.user.email}</td>
                <td data-label="Designation">${recruiter.designation}</td>
                <td data-label="Joined">${recruiter.createdAt}</td>
                <td data-label="Actions" class="actions">
                    <a class="view-btn" href="/recruiter/profile-view/${recruiter.id}">View</a>
                    <a class="reject-btn" href="/admin/deactivate-recruiter/${recruiter.id}"
                        onclick="return confirm('Are you sure you want to deactivate this student?');">Deactivate</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    function filterRecruiters() {
        const input = document.getElementById("searchInput");
        const filter = input.value.toLowerCase();
        const rows = document.querySelectorAll("#recruiterTable tbody tr");

        rows.forEach(row => {
            const company = row.cells[1].textContent.toLowerCase();
            const email = row.cells[3].textContent.toLowerCase();
            row.style.display = (company.includes(filter) || email.includes(filter)) ? "" : "none";
        });
    }
</script>

</body>
</html>
