package com.gestion_scolarite;

import com.gestion_scolarite.dao.EtudiantDAO;
import com.gestion_scolarite.model.Etudiant;

public class Main {
    public static void main(String[] args) {
        EtudiantDAO etudiantDAO = new EtudiantDAO();

        // Ajouter un étudiant
        Etudiant etudiant = new Etudiant();
        etudiant.setNom("John");
        etudiant.setPrenom("Doe");
        etudiant.setEmail("john.doe@example.com");
        etudiant.setMatricule("2021-1234");
        etudiant.setDateNaissance("1999-05-15");

        etudiantDAO.ajouterEtudiant(etudiant);

        // Récupérer un étudiant par ID
        Etudiant retrievedEtudiant = etudiantDAO.getEtudiantById(1);
        System.out.println("Nom : " + retrievedEtudiant.getNom());
    }
}
