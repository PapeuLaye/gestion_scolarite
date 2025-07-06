package com.gestion_scolarite.controller;

import com.gestion_scolarite.dao.AbsenceDAO;
import com.gestion_scolarite.model.Absence;
import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class AbsenceServlet extends HttpServlet {

    private AbsenceDAO absenceDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        absenceDAO = new AbsenceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                int idEtudiant = Integer.parseInt(request.getParameter("id"));
                List<Absence> absences = absenceDAO.getAbsencesByEtudiant(idEtudiant);
                request.setAttribute("absences", absences);
                request.getRequestDispatcher("/absences.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect("absences");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Absence absence = new Absence();
        absence.setIdEtudiant(Integer.parseInt(request.getParameter("idEtudiant")));
        absence.setIdMatiere(Integer.parseInt(request.getParameter("idMatiere")));
        absence.setDateAbsence(LocalDate.parse(request.getParameter("dateAbsence")));

        absenceDAO.enregistrerAbsence(absence);
        response.sendRedirect("absences");
    }
}
