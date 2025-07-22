<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin - Manage Users</title>
  <style>
    :root {
      --primary: #003366;
      --accent: #007bff;
      --danger: #dc3545;
      --success: #28a745;
      --warning: #ffc107;
      --bg: #f9fafc;
      --table-header: #e6f0ff;
    }

    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      background-color: var(--bg);
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
      font-size: 24px;
      color: var(--primary);
      margin-bottom: 20px;
    }

    .search-bar {
      margin-bottom: 20px;
    }

    .search-bar input {
      width: 350px;
      max-width: 100%;
      padding: 10px;
      border-radius: 5px;
      border: 1px solid #ccc;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: white;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
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
        color: var(--primary);
      }
    }
  </style>
</head>
<body>

<header>
  <h1>Career Connect Admin | Manage Users</h1>
</header>

<div class="container">

  <div class="section-title">User Management Panel</div>

  <div class="search-bar">
    <input type="text" id="searchInput" placeholder="Search by name, email or role..." onkeyup="filterUsers()" />
  </div>

  <table id="userTable">
    <thead>
      <tr>
        <th>ID</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Role</th>
        <th>Status</th>
        <th>Registered On</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="user" items="${users}">
        <tr>
          <td data-label="ID">${user.id}</td>
          <td data-label="Full Name">${user.firstName} ${user.lastName}</td>
          <td data-label="Email">${user.email}</td>
          <td data-label="Role">${user.role}</td>
          <td data-label="Status">
            <span class="status-pill ${user.status}">
              ${user.status}
            </span>
          </td>
          <td data-label="Registered">${user.registeredAt}</td>
          <td data-label="Actions" class="actions">
            <a class="approve-btn" href="/admin/users/${user.id}/approve">Approve</a>
            <a class="reject-btn" href="/admin/users/${user.id}/reject">Reject</a>
            <a class="view-btn" href="/admin/users/${user.id}">View</a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

</div>

<script>
  function filterUsers() {
    const input = document.getElementById("searchInput");
    const filter = input.value.toLowerCase();
    const rows = document.querySelectorAll("#userTable tbody tr");

    rows.forEach(row => {
      const name = row.cells[1].textContent.toLowerCase();
      const email = row.cells[2].textContent.toLowerCase();
      const role = row.cells[3].textContent.toLowerCase();

      row.style.display = (
        name.includes(filter) ||
        email.includes(filter) ||
        role.includes(filter)
      ) ? "" : "none";
    });
  }
</script>

</body>
</html>
