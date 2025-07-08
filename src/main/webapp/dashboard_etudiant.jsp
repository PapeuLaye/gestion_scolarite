<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestion_scolarite.model.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null || !"ETUDIANT".equals(utilisateur.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<h1>Bienvenue <%= utilisateur.getNom() %> (Étudiant)</h1>
<ul>
    <li><a href="notes?action=list&id=<%= utilisateur.getId() %>">Voir mes notes</a></li>
    <li><a href="logout">Déconnexion</a></li>
</ul>
