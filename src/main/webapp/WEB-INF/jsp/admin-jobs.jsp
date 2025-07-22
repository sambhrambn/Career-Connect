<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin - View All Jobs</title>
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
      width: 350px;
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

    .view-btn {
      background-color: var(--accent);
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
        color: var(--primary);
      }
    }
  </style>
</head>
<body>

<header>
  <h1>Career Connect Admin | View All Jobs</h1>
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
          <td data-label="Recruiter">${job.recruiterName}</td>
          <td data-label="Location">${job.jobLocation}</td>
          <td data-label="Type">${job.jobType}</td>
          <td data-label="Status">
            <span class="status-pill ${job.isActive ? 'active' : 'inactive'}">
              ${job.isActive ? 'Active' : 'Inactive'}
            </span>
          </td>
          <td data-label="Posted">${job.postedAt}</td>
          <td data-label="Actions" class="actions">
            <a class="view-btn" href="/admin/jobs/${job.id}">View</a>
            <a class="${job.isActive ? 'deactivate-btn' : 'toggle-btn'}"
               href="/admin/jobs/${job.id}/toggle">
              ${job.isActive ? 'Deactivate' : 'Activate'}
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
