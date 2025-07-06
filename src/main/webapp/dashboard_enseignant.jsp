<%@ page import="com.gestion_scolarite.model.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null || !"ENSEIGNANT".equals(utilisateur.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<h1>Bienvenue <%= utilisateur.getNom() %> (Enseignant)</h1>
<ul>
    <li><a href="matieres">Voir mes matières</a></li>
    <li><a href="notes">Gérer les notes</a></li>
    <li><a href="logout">Déconnexion</a></li>
</ul>
