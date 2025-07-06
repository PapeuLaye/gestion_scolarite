package com.gestion_scolarite.model;

public class Note {
    private int id;
    private int idEtudiant;
    private int idMatiere;
    private double note;
    private String nomMatiere;

    // Constructeurs
    public Note() {
    }

    public Note(int id, int idEtudiant, int idMatiere, double note, String nomMatiere) {
        this.id = id;
        this.idEtudiant = idEtudiant;
        this.idMatiere = idMatiere;
        this.note = note;
        this.nomMatiere = nomMatiere;
    }

    // Getters et Setters
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

    public double getNote() {
        return note;
    }

    public void setNote(double note) {
        this.note = note;
    }

    // Méthode toString pour affichage
    @Override
    public String toString() {
        return "Note{" +
                "id=" + id +
                ", idEtudiant=" + idEtudiant +
                ", idMatiere=" + idMatiere +
                ", note=" + note +
                '}';
    }

    public String getNomMatiere() {
        return nomMatiere;
    }

    public void setNomMatiere(String nomMatiere) {
        this.nomMatiere = nomMatiere;
    }
}
