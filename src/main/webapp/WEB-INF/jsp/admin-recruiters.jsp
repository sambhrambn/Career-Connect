<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - View All Recruiters</title>
    <style>
        :root {
            --primary: #003366;
            --accent: #007bff;
            --danger: #dc3545;
            --success: #28a745;
            --bg: #f4f6f9;
            --text: #333;
            --table-header: #e6f0ff;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--bg);
            margin: 0;
        }

        header {
            background-color: var(--primary);
            color: white;
            padding: 20px 30px;
        }

        header h1 {
            font-size: 22px;
        }

        .container {
            padding: 30px;
        }

        .section-title {
            margin-bottom: 20px;
            font-size: 24px;
            color: var(--primary);
        }

        .search-bar {
            margin-bottom: 20px;
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
            background-color: white;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: var(--table-header);
            color: var(--primary);
        }

        tr:nth-child(even) {
            background-color: #fafafa;
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
        .view-btn    { background-color: var(--accent); }

        .status-pill {
            padding: 5px 10px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: bold;
            color: white;
        }

        .approved { background-color: var(--success); }
        .pending  { background-color: #ffc107; color: #333; }
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
                color: var(--primary);
            }
        }
    </style>
</head>
<body>

<header>
    <h1>Career Connect Admin | View All Recruiters</h1>
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
                <th>Status</th>
                <th>Joined</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="recruiter" items="${recruiters}">
                <tr>
                    <td data-label="ID">${recruiter.id}</td>
                    <td data-label="Company Name">${recruiter.companyName}</td>
                    <td data-label="Recruiter Name">${recruiter.recruiterName}</td>
                    <td data-label="Email">${recruiter.email}</td>
                    <td data-label="Status">
                        <span class="status-pill ${recruiter.status}">
                            ${recruiter.status}
                        </span>
                    </td>
                    <td data-label="Joined">${recruiter.createdAt}</td>
                    <td data-label="Actions" class="actions">
                        <a class="approve-btn" href="/admin/recruiters/${recruiter.id}/approve">Approve</a>
                        <a class="reject-btn" href="/admin/recruiters/${recruiter.id}/reject">Reject</a>
                        <a class="view-btn" href="/admin/recruiters/${recruiter.id}">View</a>
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
