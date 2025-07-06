package com.gestion_scolarite.model;

import java.time.LocalDate;

public class Absence {
    private int id;
    private int idEtudiant;
    private int idMatiere;
    private LocalDate dateAbsence;


    public Absence(int id, int idEtudiant, int idMatiere, LocalDate dateAbsence) {
        this.id = id;
        this.idEtudiant = idEtudiant;
        this.idMatiere = idMatiere;
        this.dateAbsence = dateAbsence;
    }

    public Absence() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdEtudiant() {
        return idEtudiant;
    }

    public void setIdEtudiant(int idEtudiant) {
        this.idEtudiant = idEtudiant;
    }

    public int getIdMatiere() {
        return idMatiere;
    }

    public void setIdMatiere(int idMatiere) {
        this.idMatiere = idMatiere;
    }

    public LocalDate getDateAbsence() {
        return dateAbsence;
    }

    public void setDateAbsence(LocalDate dateAbsence) {
        this.dateAbsence = dateAbsence;
    }
}
