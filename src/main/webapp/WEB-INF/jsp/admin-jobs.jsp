<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin - View All Jobs</title>
  <style>
    :root {
      --charcoal: #2c2c2c;
      --skyblue: #4aa3df;
      --hoverblue: #76c7ff;
      --softwhite: #f5f5f5;
      --danger: #dc3545;
      --success: #28a745;
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

    .header-title {
      font-size: 24px;
      font-weight: bold;
      color: var(--skyblue);
    }

    .header-buttons a {
      text-decoration: none;
      background-color: var(--skyblue);
      color: var(--charcoal);
      font-weight: bold;
      padding: 0.5rem 1rem;
      border-radius: 6px;
      margin-left: 1rem;
      transition: background-color 0.3s ease;
    }

    .header-buttons a:hover {
      background-color: var(--hoverblue);
    }

    .container {
      position: relative;
      z-index: 1;
      padding: 30px;
      color: var(--softwhite);
    }

    .section-title {
      margin-bottom: 20px;
      font-size: 24px;
      color: var(--skyblue);
    }

    .search-bar {
      margin-bottom: 20px;
    }

    .search-bar input[type="text"] {
      padding: 10px;
      width: 350px;
      max-width: 100%;
      border-radius: 5px;
      border: none;
      outline: none;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: rgba(255, 255, 255, 0.05);
      border: 1px solid var(--skyblue);
      box-shadow: 0 4px 8px rgba(0,0,0,0.3);
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
      background-color: rgba(255,255,255,0.03);
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

    .view-btn {
      background-color: var(--skyblue);
    }

    .toggle-btn {
      background-color: var(--success);
    }

    .deactivate-btn {
      background-color: var(--danger);
    }

    .status-pill {
      padding: 5px 10px;
      border-radius: 12px;
      font-size: 13px;
      font-weight: bold;
      color: white;
    }

    .active {
      background-color: var(--success);
    }

    .inactive {
      background-color: var(--danger);
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
        color: var(--skyblue);
      }
    }
  </style>
</head>
<body>

<header>
  <div class="header-title">Career Connect Admin | View All Jobs</div>
  <div class="header-buttons">
    <a href="/home/dashboard2">⬅ Back</a>
    <a href="/admin/logout">🚪 Logout</a>
  </div>
</header>

<div class="container">

  <div class="section-title">All Posted Jobs</div>

  <div class="search-bar">
    <input type="text" placeholder="Search by title, recruiter, or location..." id="searchInput" onkeyup="filterJobs()" />
  </div>

  <table id="jobsTable">
    <thead>
      <tr>
        <th>ID</th>
        <th>Job Title</th>
        <th>Recruiter</th>
        <th>Location</th>
        <th>Type</th>
        <th>Status</th>
        <th>Posted On</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="job" items="${jobs}">
        <tr>
          <td data-label="ID">${job.id}</td>
          <td data-label="Title">${job.jobTitle}</td>
          <td data-label="Recruiter">${job.recruiter.firstName} ${job.recruiter.lastName}</td>
          <td data-label="Location">${job.jobLocation}</td>
          <td data-label="Type">${job.jobType}</td>
          <td data-label="Status">
            <span class="status-pill ${job.active ? 'active' : 'inactive'}">
              ${job.active ? 'Active' : 'Inactive'}
            </span>
          </td>
          <td data-label="Posted">${job.postedAt}</td>
          <td data-label="Actions" class="actions">
            <a class="view-btn" href="/admin/jobs/${job.id}">View</a>
            <a class="${job.active ? 'deactivate-btn' : 'toggle-btn'}"
               href="/admin/deactivate-jobs/${job.id}/toggle">
              ${job.active ? 'Deactivate' : 'Activate'}
            </a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

</div>

<script>
  function filterJobs() {
    const input = document.getElementById("searchInput");
    const filter = input.value.toLowerCase();
    const rows = document.querySelectorAll("#jobsTable tbody tr");

    rows.forEach(row => {
      const title = row.cells[1].textContent.toLowerCase();
      const recruiter = row.cells[2].textContent.toLowerCase();
      const location = row.cells[3].textContent.toLowerCase();
      row.style.display = (
        title.includes(filter) ||
        recruiter.includes(filter) ||
        location.includes(filter)
      ) ? "" : "none";
    });
  }
</script>

</body>
</html>
