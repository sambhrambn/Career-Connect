<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Toggle Job Visibility - Admin Panel</title>
  <style>
    :root {
      --charcoal: #2c2c2c;
      --skyblue: #4aa3df;
      --softwhite: #f5f5f5;
      --hoverblue: #76c7ff;
      --success: #28a745;
      --danger: #dc3545;
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
      padding: 20px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    header h1 {
      font-size: 22px;
      color: var(--skyblue);
    }

    .header-buttons {
      display: flex;
      gap: 12px;
    }

    .header-buttons a {
      padding: 8px 16px;
      text-decoration: none;
      border-radius: 6px;
      font-weight: bold;
      font-size: 14px;
      transition: background 0.3s ease;
    }

    .back-btn {
      background-color: var(--skyblue);
      color: var(--charcoal);
    }

    .back-btn:hover {
      background-color: var(--hoverblue);
    }

    .logout-btn {
      background-color: var(--danger);
      color: white;
    }

    .logout-btn:hover {
      background-color: #a91515;
    }

    .container {
            padding: 2rem;
            position: relative;
            z-index: 2;
            color: var(--softwhite);
        }

    .title {
      font-size: 24px;
      margin-bottom: 20px;
      color: var(--skyblue);
    }

    .search-bar {
      margin-bottom: 20px;
    }

    .search-bar input {
      width: 350px;
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
      background-color: rgba(255, 255, 255, 0.07);
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      color: var(--softwhite);
    }

    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid rgba(255,255,255,0.1);
    }

    th {
      background-color: rgba(74, 163, 223, 0.2);
      color: var(--skyblue);
    }

    tr:nth-child(even) {
      background-color: rgba(255, 255, 255, 0.05);
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
      background-color: var(--skyblue);
      color: var(--charcoal);
      padding: 6px 14px;
      border: none;
      border-radius: 5px;
      font-size: 14px;
      cursor: pointer;
      text-decoration: none;
      transition: background 0.3s ease;
    }

    .toggle-btn:hover {
      background-color: var(--hoverblue);
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
        background: rgba(255, 255, 255, 0.08);
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
        color: var(--skyblue);
      }
    }
  </style>
</head>
<body>

<header>
  <h1>Career Connect Admin | Toggle Job Visibility</h1>
  <div class="header-buttons">
    <a href="/home/dashboard2" class="back-btn">Back</a>
    <a href="/admin/logout" class="logout-btn">Logout</a>
  </div>
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
          <td data-label="Recruiter">${job.recruiter.firstName} ${job.recruiter.lastName}</td>
          <td data-label="Location">${job.jobLocation}</td>
          <td data-label="Status">
            <span class="visibility-chip ${job.visible ? 'visible' : 'hidden'}">
              ${job.visible ? 'Visible' : 'Hidden'}
            </span>
          </td>
          <td data-label="Action">
            <a class="toggle-btn" href="/admin/jobs/${job.id}/toggle-visibility">Toggle</a>
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
