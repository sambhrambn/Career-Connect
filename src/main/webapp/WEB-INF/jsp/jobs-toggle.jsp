<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Toggle Job Visibility - Admin Panel</title>
  <style>
    :root {
      --primary: #003366;
      --accent: #007bff;
      --success: #28a745;
      --danger: #dc3545;
      --bg: #f5f7fa;
    }

    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
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

    .title {
      font-size: 24px;
      margin-bottom: 20px;
      color: var(--primary);
    }

    .search-bar {
      margin-bottom: 20px;
    }

    .search-bar input {
      width: 350px;
      padding: 10px;
      font-size: 14px;
      border-radius: 6px;
      border: 1px solid #ccc;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: white;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }

    th {
      background-color: #e9f1ff;
      color: var(--primary);
    }

    tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    .visibility-chip {
      padding: 6px 12px;
      border-radius: 20px;
      color: white;
      font-weight: bold;
      font-size: 13px;
    }

    .visible {
      background-color: var(--success);
    }

    .hidden {
      background-color: var(--danger);
    }

    .toggle-btn {
      background-color: var(--accent);
      color: white;
      padding: 6px 14px;
      border: none;
      border-radius: 5px;
      font-size: 14px;
      cursor: pointer;
      text-decoration: none;
      transition: background 0.3s ease;
    }

    .toggle-btn:hover {
      background-color: var(--primary);
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
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      }

      td {
        position: relative;
        padding-left: 50%;
        border: none;
        border-bottom: 1px solid #eee;
      }

      td::before {
        content: attr(data-label);
        position: absolute;
        top: 12px;
        left: 15px;
        font-weight: bold;
        color: #333;
      }
    }
  </style>
</head>
<body>

<header>
  <h1>Career Connect Admin | Toggle Job Visibility</h1>
</header>

<div class="container">

  <div class="title">Manage Job Visibility</div>

  <div class="search-bar">
    <input type="text" id="searchInput" placeholder="Search job title or recruiter..." onkeyup="filterJobs()" />
  </div>

  <table id="jobTable">
    <thead>
      <tr>
        <th>Job ID</th>
        <th>Title</th>
        <th>Recruiter</th>
        <th>Location</th>
        <th>Status</th>
        <th>Action</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="job" items="${jobs}">
        <tr>
          <td data-label="Job ID">${job.id}</td>
          <td data-label="Title">${job.jobTitle}</td>
          <td data-label="Recruiter">${job.recruiterName}</td>
          <td data-label="Location">${job.jobLocation}</td>
          <td data-label="Status">
            <span class="visibility-chip ${job.isVisible ? 'visible' : 'hidden'}">
              ${job.isVisible ? 'Visible' : 'Hidden'}
            </span>
          </td>
          <td data-label="Action">
            <a class="toggle-btn"
               href="/admin/jobs/${job.id}/toggle-visibility">
              Toggle
            </a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

</div>

<script>
  function filterJobs() {
    const input = document.getElementById("searchInput").value.toLowerCase();
    const rows = document.querySelectorAll("#jobTable tbody tr");

    rows.forEach(row => {
      const title = row.cells[1].textContent.toLowerCase();
      const recruiter = row.cells[2].textContent.toLowerCase();
      row.style.display = title.includes(input) || recruiter.includes(input) ? "" : "none";
    });
  }
</script>

</body>
</html>
