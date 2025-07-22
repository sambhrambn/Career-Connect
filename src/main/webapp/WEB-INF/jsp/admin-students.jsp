<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - View All Students</title>
    <style>
        :root {
            --primary: #003366;
            --accent: #007bff;
            --bg: #f4f6f9;
            --text: #333;
            --table-header: #e6f0ff;
        }

        * {
            box-sizing: border-box;
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
            width: 300px;
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
            margin-right: 5px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
        }

        .view-btn {
            background-color: var(--accent);
            color: white;
        }

        .deactivate-btn {
            background-color: #dc3545;
            color: white;
        }

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
    <h1>Career Connect Admin | View All Students</h1>
</header>

<div class="container">

    <div class="section-title">All Registered Students</div>

    <div class="search-bar">
        <input type="text" placeholder="Search by name or email..." id="searchInput" onkeyup="filterTable()" />
    </div>

    <table id="studentTable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>DOB</th>
                <th>Gender</th>
                <th>Skills</th>
                <th>Registered On</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="student" items="${students}">
                <tr>
                    <td data-label="ID">${student.id}</td>
                    <td data-label="Full Name">${student.firstName} ${student.lastName}</td>
                    <td data-label="Email">${student.email}</td>
                    <td data-label="DOB">${student.dob}</td>
                    <td data-label="Gender">${student.gender}</td>
                    <td data-label="Skills">${student.skills}</td>
                    <td data-label="Registered On">${student.createdAt}</td>
                    <td data-label="Actions" class="actions">
                        <a class="view-btn" href="/admin/students/${student.id}">View</a>
                        <a class="deactivate-btn" href="/admin/students/${student.id}/deactivate">Deactivate</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</div>

<script>
    function filterTable() {
        const input = document.getElementById("searchInput");
        const filter = input.value.toLowerCase();
        const rows = document.querySelectorAll("#studentTable tbody tr");

        rows.forEach(row => {
            const name = row.cells[1].textContent.toLowerCase();
            const email = row.cells[2].textContent.toLowerCase();
            row.style.display = (name.includes(filter) || email.includes(filter)) ? "" : "none";
        });
    }
</script>

</body>
</html>
