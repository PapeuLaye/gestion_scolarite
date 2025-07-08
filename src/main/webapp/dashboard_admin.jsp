<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestion_scolarite.model.Utilisateur" %>
<%
  Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
  if (utilisateur == null || !"ADMIN".equals(utilisateur.getRole())) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tableau de Bord Admin - Gestion Scolaire</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-color: #2563eb;
      --secondary-color: #64748b;
      --success-color: #10b981;
      --warning-color: #f59e0b;
      --danger-color: #ef4444;
      --dark-color: #1e293b;
      --light-color: #f8fafc;
      --border-color: #e2e8f0;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      color: #333;
    }

    .dashboard-container {
      min-height: 100vh;
      padding: 2rem 1rem;
    }

    .dashboard-header {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      padding: 2rem;
      margin-bottom: 2rem;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .welcome-text {
      color: var(--dark-color);
      font-weight: 700;
      font-size: 2.5rem;
      margin-bottom: 0.5rem;
      background: linear-gradient(135deg, var(--primary-color), #8b5cf6);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .user-role {
      color: var(--secondary-color);
      font-size: 1.1rem;
      font-weight: 500;
    }

    .dashboard-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 2rem;
      margin-bottom: 2rem;
    }

    .dashboard-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      padding: 2rem;
      text-decoration: none;
      color: inherit;
      transition: all 0.3s ease;
      border: 1px solid rgba(255, 255, 255, 0.2);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
      position: relative;
      overflow: hidden;
    }

    .dashboard-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), #8b5cf6);
      transform: scaleX(0);
      transition: transform 0.3s ease;
    }

    .dashboard-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
      text-decoration: none;
      color: inherit;
    }

    .dashboard-card:hover::before {
      transform: scaleX(1);
    }

    .card-icon {
      width: 70px;
      height: 70px;
      border-radius: 18px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2rem;
      margin-bottom: 1.5rem;
      background: linear-gradient(135deg, var(--primary-color), #8b5cf6);
      color: white;
      box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
    }

    .card-students .card-icon {
      background: linear-gradient(135deg, #06b6d4, #0891b2);
    }

    .card-teachers .card-icon {
      background: linear-gradient(135deg, #10b981, #059669);
    }

    .card-subjects .card-icon {
      background: linear-gradient(135deg, #f59e0b, #d97706);
    }

    .card-grades .card-icon {
      background: linear-gradient(135deg, #8b5cf6, #7c3aed);
    }

    .card-title {
      font-size: 1.5rem;
      font-weight: 600;
      color: var(--dark-color);
      margin-bottom: 0.5rem;
    }

    .card-description {
      color: var(--secondary-color);
      font-size: 0.95rem;
      line-height: 1.6;
    }

    .logout-section {
      text-align: center;
      margin-top: 3rem;
    }

    .logout-btn {
      background: linear-gradient(135deg, #ef4444, #dc2626);
      color: white;
      border: none;
      padding: 1rem 2rem;
      border-radius: 50px;
      font-weight: 600;
      font-size: 1.1rem;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
    }

    .logout-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
      color: white;
      text-decoration: none;
    }

    .stats-bar {
      background: rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(10px);
      border-radius: 15px;
      padding: 1.5rem;
      margin-bottom: 2rem;
      display: flex;
      justify-content: space-around;
      flex-wrap: wrap;
      gap: 1rem;
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .stat-item {
      text-align: center;
      flex: 1;
      min-width: 120px;
    }

    .stat-number {
      font-size: 2rem;
      font-weight: 700;
      color: var(--primary-color);
    }

    .stat-label {
      font-size: 0.9rem;
      color: var(--secondary-color);
      margin-top: 0.25rem;
    }

    @media (max-width: 768px) {
      .dashboard-container {
        padding: 1rem;
      }

      .welcome-text {
        font-size: 2rem;
      }

      .dashboard-grid {
        grid-template-columns: 1fr;
        gap: 1.5rem;
      }

      .dashboard-card {
        padding: 1.5rem;
      }

      .stats-bar {
        flex-direction: column;
        gap: 1rem;
      }

      .stat-item {
        min-width: auto;
      }
    }

    /* Animation d'entrée */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .dashboard-card {
      animation: fadeInUp 0.6s ease forwards;
    }

    .dashboard-card:nth-child(1) { animation-delay: 0.1s; }
    .dashboard-card:nth-child(2) { animation-delay: 0.2s; }
    .dashboard-card:nth-child(3) { animation-delay: 0.3s; }
    .dashboard-card:nth-child(4) { animation-delay: 0.4s; }
  </style>
</head>
<body>
<div class="dashboard-container">
  <!-- En-tête du dashboard -->
  <div class="dashboard-header">
    <h1 class="welcome-text">
      <i class="fas fa-tachometer-alt me-3"></i>
      Bienvenue, <%= utilisateur.getNom() %>
    </h1>
    <p class="user-role">
      <i class="fas fa-user-shield me-2"></i>
      Administrateur - Système de Gestion Scolaire
    </p>
  </div>

  <!-- Barre de statistiques -->
  <div class="stats-bar">
    <div class="stat-item">
      <div class="stat-number">156</div>
      <div class="stat-label">Étudiants</div>
    </div>
    <div class="stat-item">
      <div class="stat-number">24</div>
      <div class="stat-label">Enseignants</div>
    </div>
    <div class="stat-item">
      <div class="stat-number">12</div>
      <div class="stat-label">Matières</div>
    </div>
    <div class="stat-item">
      <div class="stat-number">1,247</div>
      <div class="stat-label">Notes</div>
    </div>
  </div>

  <!-- Grille des cartes de gestion -->
  <div class="dashboard-grid">
    <!-- Gestion des étudiants -->
    <a href="etudiants" class="dashboard-card card-students">
      <div class="card-icon">
        <i class="fas fa-user-graduate"></i>
      </div>
      <h3 class="card-title">Gérer les Étudiants</h3>
      <p class="card-description">
        Ajoutez, modifiez et consultez les informations des étudiants inscrits dans l'établissement.
      </p>
    </a>

    <!-- Gestion des enseignants -->
    <a href="enseignants" class="dashboard-card card-teachers">
      <div class="card-icon">
        <i class="fas fa-chalkboard-teacher"></i>
      </div>
      <h3 class="card-title">Gérer les Enseignants</h3>
      <p class="card-description">
        Administrez le corps enseignant, leurs affectations et leurs informations personnelles.
      </p>
    </a>

    <!-- Gestion des matières -->
    <a href="matieres" class="dashboard-card card-subjects">
      <div class="card-icon">
        <i class="fas fa-book"></i>
      </div>
      <h3 class="card-title">Gérer les Matières</h3>
      <p class="card-description">
        Configurez les matières, leurs coefficients et les programmes d'enseignement.
      </p>
    </a>

    <!-- Gestion des notes -->
    <a href="notes" class="dashboard-card card-grades">
      <div class="card-icon">
        <i class="fas fa-clipboard-list"></i>
      </div>
      <h3 class="card-title">Gérer les Notes</h3>
      <p class="card-description">
        Consultez et gérez les évaluations et les résultats scolaires des étudiants.
      </p>
    </a>
  </div>

  <!-- Section de déconnexion -->
  <div class="logout-section">
    <a href="logout" class="logout-btn">
      <i class="fas fa-sign-out-alt"></i>
      Déconnexion
    </a>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // Animation au chargement
  document.addEventListener('DOMContentLoaded', function() {
    // Effet de chargement progressif
    const cards = document.querySelectorAll('.dashboard-card');
    cards.forEach((card, index) => {
      setTimeout(() => {
        card.style.opacity = '1';
        card.style.transform = 'translateY(0)';
      }, index * 100);
    });
  });

  // Effet de parallaxe léger sur le fond
  document.addEventListener('mousemove', function(e) {
    const body = document.body;
    const x = e.clientX / window.innerWidth;
    const y = e.clientY / window.innerHeight;

    body.style.backgroundPosition = `${x * 20}px ${y * 20}px`;
  });
</script>
</body>
</html>