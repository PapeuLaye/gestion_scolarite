<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gestion_scolarite.model.Etudiant" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Étudiants - Système Scolaire</title>

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
            --info-color: #06b6d4;
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

        .page-container {
            min-height: 100vh;
            padding: 2rem 1rem;
        }

        .page-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .page-title {
            color: var(--dark-color);
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, var(--primary-color), #8b5cf6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .breadcrumb-nav {
            background: rgba(255, 255, 255, 0.7);
            border-radius: 50px;
            padding: 0.75rem 1.5rem;
            margin-bottom: 0;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .breadcrumb-nav .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .breadcrumb-nav .breadcrumb-item.active {
            color: var(--secondary-color);
        }

        .main-content {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .search-box {
            position: relative;
            max-width: 400px;
            flex: 1;
        }

        .search-input {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 3rem;
            border: 2px solid var(--border-color);
            border-radius: 50px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary-color);
            font-size: 1.1rem;
        }

        .add-btn {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
            border: none;
            padding: 0.875rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(16, 185, 129, 0.3);
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.4);
            color: white;
            text-decoration: none;
        }

        .students-table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border: 1px solid var(--border-color);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: linear-gradient(135deg, var(--primary-color), #3b82f6);
            color: white;
            font-weight: 600;
            padding: 1.25rem 1rem;
            border: none;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table tbody td {
            padding: 1.25rem 1rem;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.95rem;
            vertical-align: middle;
        }

        .table tbody tr:hover {
            background: rgba(37, 99, 235, 0.05);
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .student-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), #8b5cf6);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
            margin-right: 0.75rem;
        }

        .student-info {
            display: flex;
            align-items: center;
        }

        .student-details {
            flex: 1;
        }

        .student-name {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.25rem;
        }

        .student-matricule {
            color: var(--secondary-color);
            font-size: 0.85rem;
        }

        .class-badge {
            background: linear-gradient(135deg, var(--info-color), #0891b2);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-edit {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
            color: white;
        }

        .btn-edit:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
        }

        .btn-delete:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            color: white;
        }

        .btn-notes {
            background: linear-gradient(135deg, #8b5cf6, #7c3aed);
            color: white;
        }

        .btn-notes:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(139, 92, 246, 0.3);
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--secondary-color);
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: var(--border-color);
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }

        .back-btn {
            background: rgba(255, 255, 255, 0.9);
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            margin-bottom: 2rem;
        }

        .back-btn:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 1.5rem;
            border-radius: 15px;
            text-align: center;
            border: 1px solid var(--border-color);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--secondary-color);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        @media (max-width: 768px) {
            .page-container {
                padding: 1rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .header-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                max-width: none;
            }

            .table-responsive {
                border-radius: 15px;
                overflow: hidden;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-action {
                justify-content: center;
            }
        }

        /* Animations */
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

        .main-content {
            animation: fadeInUp 0.6s ease forwards;
        }

        .table tbody tr {
            animation: fadeInUp 0.4s ease forwards;
        }

        .table tbody tr:nth-child(odd) { animation-delay: 0.1s; }
        .table tbody tr:nth-child(even) { animation-delay: 0.2s; }
    </style>
</head>
<body>
<div class="page-container">
    <!-- En-tête de la page -->
    <div class="page-header">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb breadcrumb-nav">
                <li class="breadcrumb-item">
                    <a href="dashboard_admin.jsp">
                        <i class="fas fa-tachometer-alt me-1"></i>
                        Dashboard
                    </a>
                </li>
                <li class="breadcrumb-item active">
                    <i class="fas fa-user-graduate me-1"></i>
                    Gestion des Étudiants
                </li>
            </ol>
        </nav>
        <h1 class="page-title">
            <i class="fas fa-user-graduate me-3"></i>
            Gestion des Étudiants
        </h1>
    </div>

    <!-- Contenu principal -->
    <div class="main-content">
        <!-- Statistiques rapides -->
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-number">
                    <%
                        List<Etudiant> etudiants = (List<Etudiant>) request.getAttribute("etudiants");
                        int totalEtudiants = (etudiants != null) ? etudiants.size() : 0;
                    %>
                    <%= totalEtudiants %>
                </div>
                <div class="stat-label">Total Étudiants</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">12</div>
                <div class="stat-label">Classes</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">8</div>
                <div class="stat-label">Nouveaux ce mois</div>
            </div>
        </div>

        <!-- Actions et recherche -->
        <div class="header-actions">
            <div class="search-box">
                <i class="fas fa-search search-icon"></i>
                <input type="text" class="search-input" placeholder="Rechercher un étudiant..." id="searchInput">
            </div>
            <a href="editEtudiant.jsp" class="add-btn">
                <i class="fas fa-plus"></i>
                Ajouter un étudiant
            </a>
        </div>

        <!-- Tableau des étudiants -->
        <div class="students-table">
            <%
                if (etudiants != null && !etudiants.isEmpty()) {
            %>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Étudiant</th>
                        <th>Classe</th>
                        <th>Email</th>
                        <th>Date de Naissance</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody id="studentsTableBody">
                    <%
                        for (Etudiant etudiant : etudiants) {
                            String initials = "";
                            if (etudiant.getNom() != null && !etudiant.getNom().isEmpty()) {
                                initials += etudiant.getNom().charAt(0);
                            }
                            if (etudiant.getPrenom() != null && !etudiant.getPrenom().isEmpty()) {
                                initials += etudiant.getPrenom().charAt(0);
                            }
                    %>
                    <tr class="student-row">
                        <td>
                            <div class="student-info">
                                <div class="student-avatar">
                                    <%= initials.toUpperCase() %>
                                </div>
                                <div class="student-details">
                                    <div class="student-name">
                                        <%= etudiant.getNom() %> <%= etudiant.getPrenom() %>
                                    </div>
                                    <div class="student-matricule">
                                        <i class="fas fa-id-card me-1"></i>
                                        <%= etudiant.getMatricule() %>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>
                                    <span class="class-badge">
                                        <i class="fas fa-graduation-cap me-1"></i>
                                        <%= etudiant.getClasse() %>
                                    </span>
                        </td>
                        <td>
                            <i class="fas fa-envelope me-2 text-muted"></i>
                            <%= etudiant.getEmail() %>
                        </td>
                        <td>
                            <i class="fas fa-calendar me-2 text-muted"></i>
                            <%= etudiant.getDateNaissance() %>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="etudiants?action=edit&id=<%= etudiant.getId() %>" class="btn-action btn-edit">
                                    <i class="fas fa-edit"></i>
                                    Modifier
                                </a>
                                <a href="etudiants?action=delete&id=<%= etudiant.getId() %>"
                                   class="btn-action btn-delete"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet étudiant ?');">
                                    <i class="fas fa-trash"></i>
                                    Supprimer
                                </a>
                                <a href="notes?action=list&id=<%= etudiant.getId() %>" class="btn-action btn-notes">
                                    <i class="fas fa-clipboard-list"></i>
                                    Notes
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
            <%
            } else {
            %>
            <div class="empty-state">
                <i class="fas fa-user-graduate"></i>
                <h3>Aucun étudiant trouvé</h3>
                <p>Commencez par ajouter votre premier étudiant au système.</p>
                <a href="editEtudiant.jsp" class="add-btn mt-3">
                    <i class="fas fa-plus"></i>
                    Ajouter un étudiant
                </a>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Fonction de recherche en temps réel
    document.getElementById('searchInput').addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const rows = document.querySelectorAll('.student-row');

        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(searchTerm)) {
                row.style.display = '';
                row.style.animation = 'fadeInUp 0.3s ease';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // Animation au chargement
    document.addEventListener('DOMContentLoaded', function() {
        const rows = document.querySelectorAll('.student-row');
        rows.forEach((row, index) => {
            setTimeout(() => {
                row.style.opacity = '1';
                row.style.transform = 'translateY(0)';
            }, index * 50);
        });
    });

    // Confirmation de suppression avec style
    document.querySelectorAll('.btn-delete').forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('⚠️ Êtes-vous sûr de vouloir supprimer cet étudiant ?\n\nCette action est irréversible et supprimera également toutes les notes associées.')) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>