<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gestion_scolarite.model.Note" %>
<%@ page import="com.gestion_scolarite.model.Utilisateur" %>

<%
    List<Note> notesList = (List<Note>) request.getAttribute("notes");
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    boolean isAdmin = utilisateur != null && "ADMIN".equals(utilisateur.getRole());
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Notes</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
        }

        .student-info {
            color: #4a5568;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .stats-card {
            background: linear-gradient(45deg, #48bb78, #38b2ac);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(72, 187, 120, 0.3);
            position: relative;
            overflow: hidden;
        }

        .stats-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .stats-card h2 {
            font-size: 1.8rem;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }

        .stats-card .moyenne {
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            position: relative;
            z-index: 1;
        }

        .notes-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .notes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 300px));
            gap: 20px;
            margin-bottom: 30px;
            justify-content: center;
            max-width: 1000px;
            margin-left: auto;
            margin-right: auto;
        }

        .note-card {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f4fd 100%);
            border-radius: 15px;
            padding: 20px;
            border: 2px solid transparent;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            max-width: 300px;
        }

        .note-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            border-color: #667eea;
        }

        .note-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transform: translateX(-100%);
            transition: transform 0.6s;
        }

        .note-card:hover::before {
            transform: translateX(100%);
        }

        .note-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .matiere {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2d3748;
        }

        .note-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: #667eea;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .note-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn {
            padding: 6px 14px;
            border: none;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            position: relative;
            overflow: hidden;
        }

        .btn-edit {
            background: linear-gradient(45deg, #4299e1, #3182ce);
            color: white;
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(66, 153, 225, 0.4);
        }

        .btn-delete {
            background: linear-gradient(45deg, #e53e3e, #c53030);
            color: white;
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(229, 62, 62, 0.4);
        }

        .btn-add {
            background: linear-gradient(45deg, #48bb78, #38a169);
            color: white;
            padding: 15px 30px;
            font-size: 1.1rem;
            border-radius: 25px;
            margin-top: 20px;
        }

        .btn-add:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(72, 187, 120, 0.4);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #718096;
        }

        .empty-state .icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #4a5568;
        }

        .table-view {
            display: none;
        }

        .view-toggle {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            justify-content: center;
        }

        .toggle-btn {
            padding: 10px 20px;
            border: 2px solid #667eea;
            background: transparent;
            color: #667eea;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .toggle-btn.active {
            background: #667eea;
            color: white;
        }

        .modern-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .modern-table th {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .modern-table td {
            padding: 15px;
            border-bottom: 1px solid #e2e8f0;
            background: white;
        }

        .modern-table tr:hover td {
            background: #f7fafc;
        }

        .back-btn {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .note-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .note-actions {
                flex-direction: column;
            }
        }

        .grade-indicator {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1rem;
            color: white;
            margin-left: 15px;
        }

        .grade-excellent { background: linear-gradient(45deg, #48bb78, #38a169); }
        .grade-good { background: linear-gradient(45deg, #4299e1, #3182ce); }
        .grade-average { background: linear-gradient(45deg, #ed8936, #dd6b20); }
        .grade-poor { background: linear-gradient(45deg, #e53e3e, #c53030); }
    </style>
</head>
<body>
<div class="container">
    <a href="javascript:history.back()" class="back-btn">← Retour au Dashboard</a>

    <div class="header">
        <h1>📊 Mes Notes</h1>
        <div class="student-info">Étudiant #${idEtudiant}</div>
    </div>

    <div class="stats-card">
        <h2>Moyenne Générale</h2>
        <div class="moyenne">${moyenne != null ? moyenne : "N/A"}/20</div>
    </div>

    <div class="notes-container">
        <div class="view-toggle">
            <button class="toggle-btn active" onclick="toggleView('cards')">Vue Cartes</button>
            <button class="toggle-btn" onclick="toggleView('table')">Vue Tableau</button>
        </div>

        <div id="cards-view" class="cards-view">
            <div class="notes-grid">
                <%
                    if (notesList != null && !notesList.isEmpty()) {
                        for (Note note : notesList) {
                            double noteValue = note.getNote();
                            String gradeClass = "";
                            if (noteValue >= 16) gradeClass = "grade-excellent";
                            else if (noteValue >= 14) gradeClass = "grade-good";
                            else if (noteValue >= 10) gradeClass = "grade-average";
                            else gradeClass = "grade-poor";
                %>
                <div class="note-card">
                    <div class="note-header">
                        <div class="matiere"><%= note.getNomMatiere() %></div>
                        <div class="grade-indicator <%= gradeClass %>">
                            <%= note.getNote() %>
                        </div>
                    </div>
                    <% if (isAdmin) { %>
                    <div class="note-actions">
                        <a href="notes?action=edit&noteId=<%= note.getId() %>" class="btn btn-edit">
                            ✏️ Modifier
                        </a>
                        <a href="notes?action=delete&id=<%= note.getId() %>&idEtudiant=<%= note.getIdEtudiant() %>"
                           class="btn btn-delete"
                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette note ?');">
                            🗑️ Supprimer
                        </a>
                    </div>
                    <% } %>
                </div>
                <%
                    }
                } else {
                %>
                <div class="empty-state">
                    <div class="icon">📝</div>
                    <h3>Aucune note disponible</h3>
                    <p>Les notes apparaîtront ici une fois saisies</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <div id="table-view" class="table-view">
            <table class="modern-table">
                <thead>
                <tr>
                    <th>Matière</th>
                    <th>Note</th>
                    <% if (isAdmin) { %>
                    <th>Actions</th>
                    <% } %>
                </tr>
                </thead>
                <tbody>
                <%
                    if (notesList != null && !notesList.isEmpty()) {
                        for (Note note : notesList) {
                %>
                <tr>
                    <td><%= note.getNomMatiere() %></td>
                    <td>
                        <span class="note-value"><%= note.getNote() %>/20</span>
                    </td>
                    <% if (isAdmin) { %>
                    <td>
                        <a href="notes?action=edit&noteId=<%= note.getId() %>" class="btn btn-edit">
                            Modifier
                        </a>
                        <a href="notes?action=delete&id=<%= note.getId() %>&idEtudiant=<%= note.getIdEtudiant() %>"
                           class="btn btn-delete"
                           onclick="return confirm('Supprimer cette note ?');">
                            Supprimer
                        </a>
                    </td>
                    <% } %>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="<%= isAdmin ? 3 : 2 %>" style="text-align:center; padding: 40px;">
                        <div class="empty-state">
                            <div class="icon">📝</div>
                            <h3>Aucune note disponible</h3>
                        </div>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <% if (isAdmin) { %>
        <div style="text-align: center;">
            <a href="notes?action=add&idEtudiant=${idEtudiant}" class="btn btn-add">
                ➕ Ajouter une Note
            </a>
        </div>
        <% } %>
    </div>
</div>

<script>
    function toggleView(view) {
        const cardsView = document.getElementById('cards-view');
        const tableView = document.getElementById('table-view');
        const toggleBtns = document.querySelectorAll('.toggle-btn');

        toggleBtns.forEach(btn => btn.classList.remove('active'));

        if (view === 'cards') {
            cardsView.style.display = 'block';
            tableView.style.display = 'none';
            toggleBtns[0].classList.add('active');
        } else {
            cardsView.style.display = 'none';
            tableView.style.display = 'block';
            toggleBtns[1].classList.add('active');
        }
    }

    // Animation d'entrée des cartes
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.note-card');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';

            setTimeout(() => {
                card.style.transition = 'all 0.6s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100 + 200);
        });
    });

    // Effet de ripple sur les boutons
    document.querySelectorAll('.btn').forEach(button => {
        button.addEventListener('click', function(e) {
            if (this.classList.contains('btn-delete')) {
                return; // Pas d'effet sur le bouton de suppression
            }

            const ripple = document.createElement('div');
            ripple.style.position = 'absolute';
            ripple.style.background = 'rgba(255, 255, 255, 0.6)';
            ripple.style.borderRadius = '50%';
            ripple.style.transform = 'scale(0)';
            ripple.style.animation = 'ripple 0.6s linear';
            ripple.style.left = (e.clientX - e.target.offsetLeft) + 'px';
            ripple.style.top = (e.clientY - e.target.offsetTop) + 'px';

            this.appendChild(ripple);

            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });

    // Animation CSS pour l'effet ripple
    const style = document.createElement('style');
    style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
    document.head.appendChild(style);
</script>
</body>
</html>