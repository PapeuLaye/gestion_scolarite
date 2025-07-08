package com.gestion_scolarite.controller;

import com.gestion_scolarite.dao.NoteDAO;
import com.gestion_scolarite.dao.MatiereDAO;
import com.gestion_scolarite.model.Note;
import com.gestion_scolarite.model.Matiere;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class NoteServlet extends HttpServlet {

    private NoteDAO noteDAO;
    private MatiereDAO matiereDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        noteDAO = new NoteDAO();
        matiereDAO = new MatiereDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        HttpSession session = request.getSession(false);
        String role = (String) (session != null ? session.getAttribute("role") : null);

        switch (action) {
            case "list":
                int idEtudiant = Integer.parseInt(request.getParameter("id"));
                List<Note> notes = noteDAO.getNotesByEtudiant(idEtudiant);
                float moyenne = noteDAO.calculerMoyenne(idEtudiant);
                request.setAttribute("notes", notes);
                request.setAttribute("idEtudiant", idEtudiant);
                request.setAttribute("moyenne", moyenne);
                request.getRequestDispatcher("/notes.jsp").forward(request, response);
                break;

            case "add":
            case "edit":
            case "delete":
                // 🔒 Protection : seuls les admins peuvent ajouter/modifier/supprimer
                if (!"ADMIN".equals(role)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès non autorisé");
                    return;
                }

                if ("add".equals(action)) {
                    int etudiantId = Integer.parseInt(request.getParameter("idEtudiant"));
                    List<Matiere> matieres = matiereDAO.getAllMatieres();
                    request.setAttribute("matieres", matieres);
                    request.setAttribute("etudiantId", etudiantId);
                    request.getRequestDispatcher("/ajouterNote.jsp").forward(request, response);
                } else if ("edit".equals(action)) {
                    int noteId = Integer.parseInt(request.getParameter("noteId"));
                    Note note = noteDAO.getNoteById(noteId);
                    List<Matiere> matieresEdit = matiereDAO.getAllMatieres();
                    request.setAttribute("note", note);
                    request.setAttribute("matieres", matieresEdit);
                    request.getRequestDispatcher("/modifier_note.jsp").forward(request, response);
                } else if ("delete".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    int etuId = Integer.parseInt(request.getParameter("idEtudiant"));
                    noteDAO.supprimerNote(id);
                    response.sendRedirect("notes?id=" + etuId);
                }
                break;

            default:
                response.sendRedirect("etudiants");
                break;
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (String) (session != null ? session.getAttribute("role") : null);

        if (!"ADMIN".equals(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès non autorisé");
            return;
        }

        String action = request.getParameter("action");

        if ("save".equals(action)) {
            Note note = new Note();
            note.setIdEtudiant(Integer.parseInt(request.getParameter("idEtudiant")));
            note.setIdMatiere(Integer.parseInt(request.getParameter("idMatiere")));
            note.setNote(Float.parseFloat(request.getParameter("note")));

            noteDAO.ajouterNote(note);
            response.sendRedirect("notes?id=" + note.getIdEtudiant());

        } else if ("update".equals(action)) {
            Note note = new Note();
            note.setId(Integer.parseInt(request.getParameter("id")));
            note.setIdEtudiant(Integer.parseInt(request.getParameter("idEtudiant")));
            note.setIdMatiere(Integer.parseInt(request.getParameter("idMatiere")));
            note.setNote(Float.parseFloat(request.getParameter("note")));

            noteDAO.modifierNote(note);
            response.sendRedirect("notes?id=" + note.getIdEtudiant());
        }
    }
}
