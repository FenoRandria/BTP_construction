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
import java.sql.Date;
import java.sql.Timestamp;

public class Devis {
    private int id;
    private int idUser;
    private String reference;
    private String descriptions;
    private int idTypeFinition;
    private int idTypeMaison;
    private Date dateDebut;
    private Date dateFin;
    private double montant;
    private double pourcentageFinition;
    private int etatDevis;
    private int corbeille;
    private Timestamp createdAt;

    public Devis(int id, int idUser, String descriptions, int idTypeFinition, int idTypeMaison, Date dateDebut, Date dateFin, double montant, double pourcentageFinition, int etatDevis, int corbeille, Timestamp createdAt)throws Exception {
        this.id = id;
        this.setIdUser(idUser);
        this.setDescriptions(descriptions);
        this.setIdTypeFinition(idTypeFinition);
        this.setIdTypeMaison(idTypeMaison);
        this.setDateDebut(dateDebut);
        this.setDateFin(dateFin);
        this.setMontant(montant);
        this.setPourcentageFinition(pourcentageFinition);
        this.etatDevis = etatDevis;
        this.corbeille = corbeille;
        this.createdAt = createdAt;
    }
    
        public Devis(int id,String reference, int idUser, String descriptions, int idTypeFinition, int idTypeMaison, Date dateDebut, Date dateFin, double montant, double pourcentageFinition, int etatDevis, int corbeille, Timestamp createdAt)throws Exception {
        this.id = id;
        this.setReference(reference);
        this.setIdUser(idUser);
        this.setDescriptions(descriptions);
        this.setIdTypeFinition(idTypeFinition);
        this.setIdTypeMaison(idTypeMaison);
        this.setDateDebut(dateDebut);
        this.setDateFin(dateFin);
        this.setMontant(montant);
        this.setPourcentageFinition(pourcentageFinition);
        this.etatDevis = etatDevis;
        this.corbeille = corbeille;
        this.createdAt = createdAt;
    }


    public Devis(int id) throws Exception{
        if(id <= 0) throw new Exception("references devis invalid!");
        this.id = id;
    }

    public Devis(int idUser, String descriptions, int idTypeFinition, int idTypeMaison, Date dateDebut) throws Exception {
        this.setIdUser(idUser);
        this.setDescriptions(descriptions);
        this.setIdTypeFinition(idTypeFinition);
        this.setIdTypeMaison(idTypeMaison);
        this.setDateDebut(dateDebut);
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public Devis() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser)throws Exception {
        if(idUser <= 0 ) throw new Exception("Le user not found! veuillez-reconnectez");
        this.idUser = idUser;
    }

    public String getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(String descriptions) {
        this.descriptions = descriptions;
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

    public void setDateDebut(Date dateDebut) throws Exception {
        if(dateDebut == null) throw new Exception("Date debut invalid");
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if(montant < 0 ) throw new Exception("Le montant invalid");
        this.montant = montant;
    }

    public double getPourcentageFinition() {
        return pourcentageFinition;
    }

    public void setPourcentageFinition(double pourcentageFinition)throws Exception {
        if(pourcentageFinition < 0 || pourcentageFinition > 100) throw new Exception("Le pourcentage doit etre entre 0 à 100");
        this.pourcentageFinition = pourcentageFinition;
    }

    public int getEtatDevis() {
        return etatDevis;
    }

    public void setEtatDevis(int etatDevis) {
        this.etatDevis = etatDevis;
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
