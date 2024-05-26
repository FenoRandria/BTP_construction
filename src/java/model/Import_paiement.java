/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Date;

/**
 *
 * @author fenor
 */
public class Import_paiement {
        String devis_refs ;
        String paiement_ref;
        Date paiement_date ;
       double paiement_montant;

    public Import_paiement(String devis_refs, String paiement_ref, Date paiement_date, double paiement_montant) {
        this.devis_refs = devis_refs;
        this.paiement_ref = paiement_ref;
        this.paiement_date = paiement_date;
        this.paiement_montant = paiement_montant;
    }

    public Import_paiement() {
    }

    public String getDevis_refs() {
        return devis_refs;
    }

    public void setDevis_refs(String devis_refs) {
        this.devis_refs = devis_refs;
    }

    public String getPaiement_ref() {
        return paiement_ref;
    }

    public void setPaiement_ref(String paiement_ref) {
        this.paiement_ref = paiement_ref;
    }

    public Date getPaiement_date() {
        return paiement_date;
    }

    public void setPaiement_date(Date paiement_date) {
        this.paiement_date = paiement_date;
    }

    public double getPaiement_montant() {
        return paiement_montant;
    }

    public void setPaiement_montant(double paiement_montant) {
        this.paiement_montant = paiement_montant;
    }
       
}
