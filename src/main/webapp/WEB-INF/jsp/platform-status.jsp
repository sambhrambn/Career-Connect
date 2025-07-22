<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Detailed Platform Status - Admin Panel</title>
  <style>
    :root {
      --primary: #003366;
      --accent: #007bff;
      --success: #28a745;
      --danger: #dc3545;
      --info: #17a2b8;
      --light: #f8f9fa;
      --dark: #343a40;
    }

    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: var(--light);
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
      margin-bottom: 25px;
      color: var(--primary);
    }

    .cards {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
      margin-bottom: 30px;
    }

    .card {
      flex: 1;
      min-width: 200px;
      background: white;
      padding: 20px;
      border-left: 5px solid var(--accent);
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    .card h2 {
      font-size: 18px;
      color: var(--dark);
      margin-bottom: 10px;
    }

    .card p {
      font-size: 22px;
      font-weight: bold;
      color: var(--primary);
    }

    .search-bar {
      margin-bottom: 20px;
    }

    .search-bar input {
      width: 300px;
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

    .chip {
      padding: 5px 12px;
      border-radius: 20px;
      font-size: 13px;
      font-weight: bold;
      color: white;
      display: inline-block;
    }

    .visible {
      background-color: var(--success);
    }

    .hidden {
      background-color: var(--danger);
    }

    @media (max-width: 768px) {
      .cards {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>

<header>
  <h1>Career Connect Admin | Platform Status</h1>
</header>

<div class="container">
  <div class="title">Platform Overview</div>

  <div class="cards">
    <div class="card">
      <h2>Total Students</h2>
      <p>${studentCount}</p>
    </div>
    <div class="card">
      <h2>Total Recruiters</h2>
      <p>${recruiterCount}</p>
    </div>
    <div class="card">
      <h2>Total Jobs</h2>
      <p>${jobCount}</p>
    </div>
    <div class="card">
      <h2>Total Applications</h2>
      <p>${applicationCount}</p>
    </div>
  </div>

  <div class="title">Job-wise Application Status</div>

  <div class="search-bar">
    <input type="text" id="searchInput" placeholder="Search by job title or recruiter..." onkeyup="filterStatus()" />
  </div>

  <table id="statusTable">
    <thead>
      <tr>
        <th>Job Title</th>
        <th>Posted By</th>
        <th>Applications</th>
        <th>Max Limit</th>
        <th>Visibility</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="job" items="${jobs}">
        <tr>
          <td data-label="Job Title">${job.jobTitle}</td>
          <td data-label="Posted By">${job.recruiterName}</td>
          <td data-label="Applications">${job.applicationCount}</td>
          <td data-label="Limit">${job.maxApplications}</td>
          <td data-label="Visibility">
            <span class="chip ${job.isVisible ? 'visible' : 'hidden'}">
              ${job.isVisible ? 'Visible' : 'Hidden'}
            </span>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

<script>
  function filterStatus() {
    const input = document.getElementById("searchInput").value.toLowerCase();
    const rows = document.querySelectorAll("#statusTable tbody tr");

    rows.forEach(row => {
      const jobTitle = row.cells[0].textContent.toLowerCase();
      const recruiter = row.cells[1].textContent.toLowerCase();
      row.style.display = jobTitle.includes(input) || recruiter.includes(input) ? "" : "none";
    });
  }
</script>

</body>
</html>
