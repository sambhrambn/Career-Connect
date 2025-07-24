<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Detailed Platform Status - Admin Panel</title>
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
      background-color: var(--charcoal);
      padding: 20px 30px;
      font-size: 22px;
      font-weight: bold;
      color: var(--skyblue);
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: relative;
      z-index: 2;
    }

    .header-buttons {
      display: flex;
      gap: 15px;
    }

    .header-buttons a {
      padding: 8px 16px;
      border-radius: 6px;
      text-decoration: none;
      font-size: 14px;
      font-weight: bold;
      transition: background-color 0.3s ease;
    }

    .btn-back {
      background-color: var(--skyblue);
      color: var(--charcoal);
    }

    .btn-back:hover {
      background-color: var(--hoverblue);
    }

    .btn-logout {
      background-color: var(--danger);
      color: white;
    }

    .btn-logout:hover {
      background-color: #c82333;
    }

    .container {
      padding: 30px;
      position: relative;
      z-index: 2;
    }

    .title {
      font-size: 24px;
      margin-bottom: 25px;
      color: var(--skyblue);
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
      background: rgba(255,255,255,0.08);
      padding: 20px;
      border-left: 5px solid var(--skyblue);
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.3);
    }

    .card h2 {
      font-size: 18px;
      color: var(--softwhite);
      margin-bottom: 10px;
    }

    .card p {
      font-size: 22px;
      font-weight: bold;
      color: var(--skyblue);
    }

    .search-bar {
      margin-bottom: 20px;
    }

    .search-bar input {
      width: 300px;
      padding: 10px;
      font-size: 14px;
      border-radius: 6px;
      border: none;
      background-color: #eee;
      color: #000;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: rgba(255,255,255,0.08);
      box-shadow: 0 2px 6px rgba(0,0,0,0.3);
    }

    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #888;
    }

    th {
      background-color: rgba(255,255,255,0.1);
      color: var(--skyblue);
    }

    tr:nth-child(even) {
      background-color: rgba(255,255,255,0.05);
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

      .header-buttons {
        flex-direction: column;
        align-items: flex-end;
      }
    }
  </style>
</head>
<body>

<header>
  <div>Career Connect Admin | Platform Status</div>
  <div class="header-buttons">
    <a href="/home/dashboard2" class="btn-back">⬅ Back</a>
    <a href="/admin/logout" class="btn-logout">Logout</a>
  </div>
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
          <td data-label="Posted By">${job.recruiter.firstName} ${job.recruiter.lastName}</td>
          <td data-label="Applications">${job.applications.size()}</td>
          <td data-label="Limit">${job.maxApplications}</td>
          <td data-label="Visibility">
            <span class="chip ${job.visible ? 'visible' : 'hidden'}">
              ${job.visible ? 'Visible' : 'Hidden'}
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
