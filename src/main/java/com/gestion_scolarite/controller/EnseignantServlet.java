package com.gestion_scolarite.controller;

import com.gestion_scolarite.dao.EnseignantDAO;
import com.gestion_scolarite.model.Enseignant;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class EnseignantServlet extends HttpServlet {
    private EnseignantDAO enseignantDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        enseignantDAO = new EnseignantDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                List<Enseignant> enseignants = enseignantDAO.getAllEnseignants();
                request.setAttribute("enseignants", enseignants);
                request.getRequestDispatcher("/enseignants.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Enseignant enseignant = enseignantDAO.getEnseignantById(id);
                request.setAttribute("enseignant", enseignant);
                request.getRequestDispatcher("/editEnseignant.jsp").forward(request, response);
                break;
            case "delete":
                id = Integer.parseInt(request.getParameter("id"));
                enseignantDAO.supprimerEnseignant(id);
                response.sendRedirect("enseignants");
                break;
            default:
                response.sendRedirect("enseignants");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("save".equals(action)) {
            Enseignant enseignant = new Enseignant();
            enseignant.setNom(request.getParameter("nom"));
            enseignant.setPrenom(request.getParameter("prenom"));
            enseignant.setEmail(request.getParameter("email"));

            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                enseignant.setId(Integer.parseInt(id));
                enseignantDAO.modifierEnseignant(enseignant);
            } else {
                enseignantDAO.ajouterEnseignant(enseignant);
            }
            response.sendRedirect("enseignants");
        }
    }
}
