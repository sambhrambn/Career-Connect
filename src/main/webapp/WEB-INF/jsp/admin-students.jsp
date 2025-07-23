<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - View All Students</title>
    <style>
        :root {
            --charcoal: #2c2c2c;
            --skyblue: #4aa3df;
            --softwhite: #f5f5f5;
            --hoverblue: #76c7ff;
            --border: #555;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html, body {
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
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

        header {
            position: relative;
            z-index: 1;
            background-color: var(--charcoal);
            color: var(--skyblue);
            padding: 20px 30px;
        }

        header h1 {
            font-size: 24px;
            margin: 0;
        }

         header {
                    background-color: var(--charcoal);
                    color: var(--skyblue);
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    padding: 20px 30px;
                    border-bottom: 1px solid var(--skyblue);
                }

                .header-left {
                    display: flex;
                    align-items: center;
                    gap: 20px;
                }

                .header-left h1 {
                    font-size: 20px;
                    margin: 0;
                    color: var(--skyblue);
                }

                .back-btn {
                    background-color: var(--skyblue);
                    color: var(--charcoal);
                    text-decoration: none;
                    padding: 8px 16px;
                    border-radius: 5px;
                    font-weight: bold;
                    transition: background-color 0.2s ease;
                }

                .back-btn:hover {
                    background-color: var(--hoverblue);
                }

                .logout-btn {
                    background-color: var(--red);
                    color: var(--white);
                    text-decoration: none;
                    padding: 8px 16px;
                    border-radius: 5px;
                    font-weight: bold;
                    transition: background-color 0.2s ease;
                }

                .logout-btn:hover {
                    background-color: var(--hoverred);
                }

        .container {
            padding: 2rem;
            position: relative;
            z-index: 2;
            color: var(--softwhite);
        }

        .section-title {
            margin-bottom: 20px;
            font-size: 22px;
            color: var(--skyblue);
        }

        .search-bar {
            margin-bottom: 20px;
        }

        .search-bar input[type="text"] {
            padding: 10px;
            width: 300px;
            max-width: 100%;
            border-radius: 5px;
            border: 1px solid var(--border);
            background-color: #eee;
            color: #000;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.06);
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid var(--border);
            text-align: left;
            color: var(--softwhite);
        }

        th {
            background-color: var(--skyblue);
            color: var(--charcoal);
        }

        tr:nth-child(even) {
            background-color: rgba(255, 255, 255, 0.05);
        }

        tr:nth-child(odd) {
            background-color: rgba(255, 255, 255, 0.03);
        }

        .actions a {
            text-decoration: none;
            padding: 6px 12px;
            margin-right: 5px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            transition: 0.2s ease-in-out;
            display: inline-block;
        }

        .view-btn {
            background-color: var(--skyblue);
            color: var(--charcoal);
        }

        .deactivate-btn {
            background-color: #ff4d4d;
            color: var(--white);
        }

        .actions a:hover {
            opacity: 0.9;
            transform: scale(1.05);
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
                white-space: normal;
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
        <h1>Career Connect Admin | View All Students</h1>
    </div>
    <div class="header-right">
        <a href="/logout" class="logout-btn">Logout</a>
    </div>
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
                    <td data-label="Email">${student.user.email}</td>
                    <td data-label="DOB">${student.dob}</td>
                    <td data-label="Gender">${student.gender}</td>
                    <td data-label="Skills">${student.skills}</td>
                    <td data-label="Registered On">${student.createdAt}</td>
                    <td data-label="Actions" class="actions">
                        <a class="view-btn" href="/admin/students/${student.id}">View</a>
                        <a class="deactivate-btn" href="/admin/students/${student.id}/deactivate"
                           onclick="return confirm('Are you sure you want to deactivate this student?');">Deactivate</a>
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
