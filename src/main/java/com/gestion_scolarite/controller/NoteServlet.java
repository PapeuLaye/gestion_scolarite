package com.gestion_scolarite.controller;

import com.gestion_scolarite.dao.NoteDAO;
import com.gestion_scolarite.model.Note;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class NoteServlet extends HttpServlet {

    private NoteDAO noteDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        noteDAO = new NoteDAO();
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
                List<Note> notes = noteDAO.getNotesByEtudiant(idEtudiant);
                float moyenne = noteDAO.calculerMoyenne(idEtudiant);
                request.setAttribute("notes", notes);
                request.setAttribute("idEtudiant", idEtudiant);
                request.setAttribute("moyenne", moyenne);
                request.getRequestDispatcher("/notes.jsp").forward(request, response);
                break;

            case "edit":
                int noteId = Integer.parseInt(request.getParameter("noteId"));
                Note note = noteDAO.getNoteById(noteId);
                request.setAttribute("note", note);
                request.getRequestDispatcher("/modifier_note.jsp").forward(request, response);
                break;

            case "delete":
                int id = Integer.parseInt(request.getParameter("id"));
                noteDAO.supprimerNote(id);
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
            Note note = new Note();
            note.setIdEtudiant(Integer.parseInt(request.getParameter("idEtudiant")));
            note.setIdMatiere(Integer.parseInt(request.getParameter("idMatiere")));
            note.setNote(Float.parseFloat(request.getParameter("note")));

            noteDAO.ajouterNote(note);
            response.sendRedirect("notes");

        }else if ("update".equals(action)) {
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
