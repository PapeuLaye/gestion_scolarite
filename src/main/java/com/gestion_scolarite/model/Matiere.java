package com.gestion_scolarite.model;

public class Matiere {
    private int id;
    private String nom;
    private String code;
    private int coefficient;

    public Matiere() {
    }

    public Matiere(int id, String nom, String code, int coefficient) {
        this.id = id;
        this.nom = nom;
        this.code = code;
        this.coefficient = coefficient;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(int coefficient) {
        this.coefficient = coefficient;
    }
}
