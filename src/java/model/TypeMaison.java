/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author fenor
 */
import java.sql.Timestamp;

public class TypeMaison {
    private int id;

    private String nom;
    private String descriptions;
    private String photos;
    private double nbJourConstruction;
    private int corbeille;
    private Timestamp createdAt;

    public TypeMaison(int id,String nom, String descriptions, String photos, double nbJourConstruction, int corbeille, Timestamp createdAt) throws Exception {
        this.id = id;
        this.setNom(nom);
        this.descriptions = descriptions;
        this.photos = photos;
        this.setNbJourConstruction(nbJourConstruction);
        this.corbeille = corbeille;
        this.createdAt = createdAt;
    }

    public TypeMaison() {
    }
    
    public TypeMaison(String nom,String descriptions, String photos, double nbJourConstruction) throws Exception  {
        this.nom = nom;        
        this.descriptions = descriptions;
        this.photos = photos;
        this.setNbJourConstruction(nbJourConstruction);
    }
    // Getters and Setters...

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
    
    public String getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(String descriptions) {
        this.descriptions = descriptions;
    }

    public String getPhotos() {
        return photos;
    }

    public void setPhotos(String photos) {
        this.photos = photos;
    }

    public double getNbJourConstruction() {
        return nbJourConstruction;
    }

    public void setNbJourConstruction(double nbJourConstruction)throws Exception {
        if(nbJourConstruction < 0) throw new Exception("jours doivent etres positive");
        this.nbJourConstruction = nbJourConstruction;
    }

    public int getCorbeille() {
        return corbeille;
    }

    public void setCorbeille(int corbeille) {
        this.corbeille = corbeille;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }


}
