package com.gestion_scolarite.controller;

import com.gestion_scolarite.dao.UtilisateurDAO;
import com.gestion_scolarite.model.Utilisateur;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() {
        utilisateurDAO = new UtilisateurDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");

        Utilisateur user = utilisateurDAO.authentifier(email, motDePasse);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", user);
            session.setAttribute("role", user.getRole());  // ✅ Ajout du rôle dans la session

            switch (user.getRole()) {
                case "ADMIN":
                    response.sendRedirect("dashboard_admin.jsp");
                    break;
                case "ENSEIGNANT":
                    response.sendRedirect("dashboard_enseignant.jsp");
                    break;
                case "ETUDIANT":
                    response.sendRedirect("dashboard_etudiant.jsp");
                    break;
                default:
                    response.sendRedirect("login.jsp?erreur=role_inconnu");
            }
        } else {
            response.sendRedirect("login.jsp?erreur=1");
        }
    }
}
