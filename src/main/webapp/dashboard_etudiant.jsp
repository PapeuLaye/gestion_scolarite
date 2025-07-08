<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestion_scolarite.model.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null || !"ETUDIANT".equals(utilisateur.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Étudiant</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .dashboard-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 900px;
            padding: 40px;
            animation: slideIn 0.8s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }

        .welcome-title {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
            animation: titleGlow 2s ease-in-out infinite alternate;
        }

        @keyframes titleGlow {
            from {
                text-shadow: 0 0 20px rgba(102, 126, 234, 0.5);
            }
            to {
                text-shadow: 0 0 30px rgba(118, 75, 162, 0.8);
            }
        }

        .student-name {
            font-size: 1.8rem;
            color: #4a5568;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .student-role {
            background: linear-gradient(45deg, #ff6b6b, #ffa726);
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-block;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .dashboard-card {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f4fd 100%);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .dashboard-card::before {
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

        .dashboard-card:hover::before {
            transform: translateX(100%);
        }

        .dashboard-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            border-color: #667eea;
        }

        .card-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 15px 40px rgba(102, 126, 234, 0.5);
            }
            100% {
                transform: scale(1);
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            }
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .card-description {
            color: #718096;
            margin-bottom: 25px;
            line-height: 1.6;
        }

        .card-button {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            position: relative;
            overflow: hidden;
        }

        .card-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .card-button:hover::before {
            left: 100%;
        }

        .card-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .logout-card {
            background: linear-gradient(135deg, #fed7d7 0%, #fbb6ce 100%);
        }

        .logout-card .card-icon {
            background: linear-gradient(45deg, #e53e3e, #d53f8c);
        }

        .logout-card .card-button {
            background: linear-gradient(45deg, #e53e3e, #d53f8c);
        }

        .logout-card .card-button:hover {
            box-shadow: 0 10px 25px rgba(229, 62, 62, 0.4);
        }

        .stats-bar {
            background: linear-gradient(45deg, #48bb78, #38b2ac);
            color: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(72, 187, 120, 0.3);
        }

        .stats-bar h3 {
            font-size: 1.2rem;
            margin-bottom: 10px;
        }

        .stats-bar p {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        @media (max-width: 768px) {
            .dashboard-container {
                padding: 20px;
            }

            .welcome-title {
                font-size: 2rem;
            }

            .student-name {
                font-size: 1.4rem;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }

        .floating-shapes {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 20%;
            right: 10%;
            animation-delay: 2s;
        }

        .shape:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }
    </style>
</head>
<body>
<div class="floating-shapes">
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
</div>

<div class="dashboard-container">
    <div class="header">
        <h1 class="welcome-title">Bienvenue</h1>
        <div class="student-name"><%= utilisateur.getNom() %></div>
        <span class="student-role">Étudiant</span>
    </div>

    <div class="stats-bar">
        <h3>🎓 Année Académique 2024-2025</h3>
        <p>Votre espace personnel pour suivre votre parcours scolaire</p>
    </div>

    <div class="dashboard-grid">
        <div class="dashboard-card">
            <div class="card-icon">📊</div>
            <h3 class="card-title">Mes Notes</h3>
            <p class="card-description">Consultez toutes vos notes et suivez votre progression académique en temps réel</p>
            <a href="notes?action=list&id=<%= utilisateur.getId() %>" class="card-button">Voir mes notes</a>
        </div>

        <div class="dashboard-card logout-card">
            <div class="card-icon">🚪</div>
            <h3 class="card-title">Déconnexion</h3>
            <p class="card-description">Terminez votre session en toute sécurité</p>
            <a href="logout" class="card-button">Se déconnecter</a>
        </div>
    </div>
</div>

<script>
    // Animation d'entrée séquentielle des cartes
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.dashboard-card');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(50px)';

            setTimeout(() => {
                card.style.transition = 'all 0.6s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 200 + 500);
        });
    });

    // Effet de particules au survol
    document.querySelectorAll('.card-button').forEach(button => {
        button.addEventListener('click', function(e) {
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