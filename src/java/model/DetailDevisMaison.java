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

public class DetailDevisMaison {
    private int id;
    private String descriptions;
    private double prixUnitaire;
    private double quantite;
    private String unite;
    private int idTypeMaison;
    private int corbeille;
    private Timestamp createdAt;

    public DetailDevisMaison(int id, String descriptions, double prixUnitaire, double quantite, String unite, int idTypeMaison, int corbeille, Timestamp createdAt) throws Exception{
        this.id = id;
        this.descriptions = descriptions;
        this.setPrixUnitaire(prixUnitaire);
        this.setQuantite(quantite);
        this.unite = unite;
        this.setIdTypeMaison(idTypeMaison);
        this.corbeille = corbeille;
        this.createdAt = createdAt;
    }

    // Getters and Setters...

    public DetailDevisMaison(String descriptions, double prixUnitaire, double quantite, String unite, int idTypeMaison) {
        this.descriptions = descriptions;
        this.prixUnitaire = prixUnitaire;
        this.quantite = quantite;
        this.unite = unite;
        this.idTypeMaison = idTypeMaison;
    }

    public DetailDevisMaison() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(String descriptions) {
        this.descriptions = descriptions;
    }

    public double getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(double prixUnitaire)throws Exception {
        if(prixUnitaire < 0) throw new Exception("Prix unitaire doit etre superieur à zéro");
        this.prixUnitaire = prixUnitaire;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite)throws Exception {
        if(quantite < 0) throw new Exception("Quantité doit etre superieur à zéro");
        this.quantite = quantite;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        
        this.unite = unite;
    }

    public int getIdTypeMaison() {
        return idTypeMaison;
    }

    public void setIdTypeMaison(int idTypeMaison)throws Exception {
        if(idTypeMaison < 0) throw new Exception("Type maison invalid");
        this.idTypeMaison = idTypeMaison;
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
