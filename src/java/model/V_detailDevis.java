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
import java.sql.Date;

@Table(tableName ="V_detailDevis")

public class V_detailDevis {
    private int idDevis;
    private int idUser;
    private String devisDescriptions;
    private int idTypeFinition;
    private int idTypeMaison;
    private Date dateDebut;
    private Date dateFin;
    private double pourcentageFinition; 
    private String etatDevis;
    private int devisCorbeille;
    private Date datedevis;
    private String maisonNom;
    private String maisonDescriptions;
    private String maisonPhotos;
    private int duree;
    private int maisonCorbeille;
    private Date datetypemaison;
    private Date datefinition;
    private double devisMontant;
    private double montantPaiement;
    private double progression;    
    private double restePayer;


    // Getters and setters for each field

    public V_detailDevis() {
    }

    public V_detailDevis(int idDevis, int idUser, String devisDescriptions, int idTypeFinition, int idTypeMaison, Date dateDebut, Date dateFin, double pourcentageFinition, String etatDevis, int devisCorbeille, Date datedevis, String maisonNom, String maisonDescriptions, String maisonPhotos, int duree, int maisonCorbeille, Date datetypemaison, Date datefinition, double devisMontant, double montantPaiement, double restePayer,double progression) {
        this.idDevis = idDevis;
        this.idUser = idUser;
        this.devisDescriptions = devisDescriptions;
        this.idTypeFinition = idTypeFinition;
        this.idTypeMaison = idTypeMaison;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.pourcentageFinition = pourcentageFinition;
        this.etatDevis = etatDevis;
        this.devisCorbeille = devisCorbeille;
        this.datedevis = datedevis;
        this.maisonNom = maisonNom;
        this.maisonDescriptions = maisonDescriptions;
        this.maisonPhotos = maisonPhotos;
        this.duree = duree;
        this.maisonCorbeille = maisonCorbeille;
        this.datetypemaison = datetypemaison;
        this.datefinition = datefinition;
        this.devisMontant = devisMontant;
        this.montantPaiement = montantPaiement;
        this.restePayer = restePayer;        
        this.progression = progression;

    }

    public int getIdDevis() {
        return idDevis;
    }

    public void setIdDevis(int idDevis) {
        this.idDevis = idDevis;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getDevisDescriptions() {
        return devisDescriptions;
    }

    public void setDevisDescriptions(String devisDescriptions) {
        this.devisDescriptions = devisDescriptions;
    }

    public int getIdTypeFinition() {
        return idTypeFinition;
    }

    public void setIdTypeFinition(int idTypeFinition) {
        this.idTypeFinition = idTypeFinition;
    }

    public int getIdTypeMaison() {
        return idTypeMaison;
    }

    public void setIdTypeMaison(int idTypeMaison) {
        this.idTypeMaison = idTypeMaison;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    public double getPourcentageFinition() {
        return pourcentageFinition;
    }

    public void setPourcentageFinition(double pourcentageFinition) {
        this.pourcentageFinition = pourcentageFinition;
    }

    public String getEtatDevis() {
        return etatDevis;
    }

    public void setEtatDevis(String etatDevis) {
        this.etatDevis = etatDevis;
    }

    public int getDevisCorbeille() {
        return devisCorbeille;
    }

    public void setDevisCorbeille(int devisCorbeille) {
        this.devisCorbeille = devisCorbeille;
    }

    public Date getDatedevis() {
        return datedevis;
    }

    public void setDatedevis(Date datedevis) {
        this.datedevis = datedevis;
    }

    public String getMaisonNom() {
        return maisonNom;
    }

    public void setMaisonNom(String maisonNom) {
        this.maisonNom = maisonNom;
    }

    public String getMaisonDescriptions() {
        return maisonDescriptions;
    }

    public void setMaisonDescriptions(String maisonDescriptions) {
        this.maisonDescriptions = maisonDescriptions;
    }

    public String getMaisonPhotos() {
        return maisonPhotos;
    }

    public void setMaisonPhotos(String maisonPhotos) {
        this.maisonPhotos = maisonPhotos;
    }

    public int getDuree() {
        return duree;
    }

    public void setDuree(int duree) {
        this.duree = duree;
    }

    public int getMaisonCorbeille() {
        return maisonCorbeille;
    }

    public void setMaisonCorbeille(int maisonCorbeille) {
        this.maisonCorbeille = maisonCorbeille;
    }

    public Date getDatetypemaison() {
        return datetypemaison;
    }

    public void setDatetypemaison(Date datetypemaison) {
        this.datetypemaison = datetypemaison;
    }

    public Date getDatefinition() {
        return datefinition;
    }

    public void setDatefinition(Date datefinition) {
        this.datefinition = datefinition;
    }

    public double getDevisMontant() {
        return devisMontant;
    }

    public void setDevisMontant(double devisMontant) {
        this.devisMontant = devisMontant;
    }

    public double getMontantPaiement() {
        return montantPaiement;
    }

    public void setMontantPaiement(double montantPaiement) {
        this.montantPaiement = montantPaiement;
    }

    public double getProgression() {
        return progression;
    }

    public void setProgression(double progression) {
        this.progression = progression;
    }

    
    public double getRestePayer() {
        return restePayer;
    }

    public void setRestePayer(double restePayer) {
        this.restePayer = restePayer;
    }
    
}
