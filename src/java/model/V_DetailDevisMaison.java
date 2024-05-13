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
import annotation.Table;
import java.sql.Timestamp;
@Table(tableName="V_DetailDevisMaison")
public class V_DetailDevisMaison {
    private int idDetail;
    private int idUser;
    private int idDevis;
    private String descriptions;
    private double prixUnitaire;
    private double quantite;
    private double sousmontant;
    private double montant;
    private String unite;
    private int idTypeMaison;

    public V_DetailDevisMaison() {
    }

    public int getIdDetail() {
        return idDetail;
    }

    public void setIdDetail(int idDetail) {
        this.idDetail = idDetail;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdDevis() {
        return idDevis;
    }

    public void setIdDevis(int idDevis) {
        this.idDevis = idDevis;
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

    public void setPrixUnitaire(double prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getSousmontant() {
        return sousmontant;
    }

    public void setSousmontant(double sousmontant) {
        this.sousmontant = sousmontant;
    }

    public String getUnite() {
        return unite;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public int getIdTypeMaison() {
        return idTypeMaison;
    }

    public void setIdTypeMaison(int idTypeMaison) {
        this.idTypeMaison = idTypeMaison;
    }

}
