<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin - Manage Users</title>
  <style>
    :root {
      --charcoal: #2c2c2c;
      --skyblue: #4aa3df;
      --softwhite: #f5f5f5;
      --hoverblue: #76c7ff;
      --success: #28a745;
      --danger: #dc3545;
      --warning: #ffc107;
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
      z-index: 2;
      background-color: var(--charcoal);
      color: var(--skyblue); /* changed from white to skyblue */
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    header h1 {
      font-size: 1.5rem;
    }

    .header-buttons a {
      margin-left: 1rem;
      text-decoration: none;
      background-color: var(--skyblue);
      color: var(--charcoal);
      padding: 0.5rem 1rem;
      border-radius: 6px;
      font-weight: bold;
      transition: background-color 0.3s ease;
    }

    .header-buttons a:hover {
      background-color: var(--hoverblue);
    }

    .container {
      position: relative;
      z-index: 1;
      margin-top: 30px; /* added gap below header */
      padding: 2rem;
      max-width: 95%;
      margin-left: auto;
      margin-right: auto;
      background-color: rgba(255, 255, 255, 0.08);
      border-radius: 10px;
      border: 1px solid var(--skyblue);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    }

    .section-title {
      font-size: 1.5rem;
      color: var(--skyblue);
      margin-bottom: 20px;
    }

    .search-bar input {
      width: 350px;
      max-width: 100%;
      padding: 10px;
      border-radius: 5px;
      border: none;
      background-color: #eee;
      color: #000;
      margin-bottom: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: rgba(255, 255, 255, 0.06);
      color: var(--softwhite);
    }

    th, td {
      padding: 12px 15px;
      border: 1px solid #aaa;
      text-align: left;
    }

    th {
      background-color: rgba(74, 163, 223, 0.2);
      color: var(--skyblue);
    }

    tr:nth-child(even) {
      background-color: rgba(255, 255, 255, 0.05);
    }

    .actions a {
      text-decoration: none;
      padding: 6px 12px;
      margin-right: 6px;
      border-radius: 5px;
      font-size: 14px;
      font-weight: bold;
      color: white;
      display: inline-block;
    }

    .approve-btn { background-color: var(--success); }
    .reject-btn  { background-color: var(--danger); }
    .view-btn    { background-color: var(--skyblue); color: var(--charcoal); }

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
  <h1>Career Connect Admin | Manage Users</h1>
  <div class="header-buttons">
    <a href="/admin/dashboard">🔙 Back</a>
    <a href="/logout">🚪 Logout</a>
  </div>
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
