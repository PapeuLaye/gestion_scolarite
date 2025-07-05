package com.gestion_scolarite.controller;

import com.gestion_scolarite.dao.MatiereDAO;
import com.gestion_scolarite.model.Matiere;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class MatiereServlet extends HttpServlet {
    private MatiereDAO matiereDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        matiereDAO = new MatiereDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                List<Matiere> matieres = matiereDAO.getAllMatieres();
                request.setAttribute("matieres", matieres);
                request.getRequestDispatcher("/matieres.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Matiere matiere = matiereDAO.getMatiereById(id);
                request.setAttribute("matiere", matiere);
                request.getRequestDispatcher("/editMatiere.jsp").forward(request, response);
                break;
            case "delete":
                id = Integer.parseInt(request.getParameter("id"));
                matiereDAO.supprimerMatiere(id);
                response.sendRedirect("matieres");
                break;
            default:
                response.sendRedirect("matieres");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("save".equals(action)) {
            Matiere matiere = new Matiere();
            matiere.setNom(request.getParameter("nom"));
            matiere.setCode(request.getParameter("code"));
            matiere.setCoefficient(Integer.parseInt(request.getParameter("coefficient")));

            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                matiere.setId(Integer.parseInt(id));
                matiereDAO.modifierMatiere(matiere);
            } else {
                matiereDAO.ajouterMatiere(matiere);
            }
            response.sendRedirect("matieres");
        }
    }
}
