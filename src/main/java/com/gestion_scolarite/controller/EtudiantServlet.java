package com.gestion_scolarite.controller;

import com.gestion_scolarite.dao.EtudiantDAO;
import com.gestion_scolarite.model.Etudiant;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class EtudiantServlet extends HttpServlet {
    private EtudiantDAO etudiantDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        etudiantDAO = new EtudiantDAO(); // Initialisation de la DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Action par défaut
        }

        switch (action) {
            case "list":
                List<Etudiant> etudiants = etudiantDAO.getAllEtudiants();
                request.setAttribute("etudiants", etudiants);
                request.getRequestDispatcher("/etudiants.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Etudiant etudiant = etudiantDAO.getEtudiantById(id);
                request.setAttribute("etudiant", etudiant);
                request.getRequestDispatcher("/editEtudiant.jsp").forward(request, response);
                break;
            case "delete":
                id = Integer.parseInt(request.getParameter("id"));
                etudiantDAO.supprimerEtudiant(id);
                response.sendRedirect("etudiants");
                break;
            default:
                response.sendRedirect("etudiants");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("save".equals(action)) {
            Etudiant etudiant = new Etudiant();
            etudiant.setNom(request.getParameter("nom"));
            etudiant.setPrenom(request.getParameter("prenom"));
            etudiant.setEmail(request.getParameter("email"));
            etudiant.setMatricule(request.getParameter("matricule"));
            etudiant.setDateNaissance(request.getParameter("dateNaissance"));
            etudiant.setClasse(request.getParameter("classe"));

            // Si l'étudiant existe, on le met à jour, sinon on l'ajoute
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                etudiant.setId(Integer.parseInt(id));
                etudiantDAO.modifierEtudiant(etudiant); // On peut aussi ajouter une méthode pour la mise à jour
            } else {
                etudiantDAO.ajouterEtudiant(etudiant);
            }
            response.sendRedirect("etudiants");
        }
    }
}
