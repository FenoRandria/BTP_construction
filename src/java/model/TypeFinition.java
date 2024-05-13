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
import annotation.Colonne;
import annotation.Table;
import java.sql.Timestamp;
@Table(tableName="typeFinition")
public class TypeFinition {
    private int id;
    private String typeFinition;
    @Colonne(colonneName="pourcentage")
    private double niveau;
    private Timestamp createdAt;

    public TypeFinition(int id, String typeFinition, double niveau, Timestamp createdAt) throws Exception {
        this.id = id;
        this.typeFinition = typeFinition;
        this.setNiveau(niveau);
        this.createdAt = createdAt;
    }

    public TypeFinition() {
    }

    // Getters and Setters...

    public TypeFinition(double niveau) throws Exception{
        this.setNiveau(niveau);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTypeFinition() {
        return typeFinition;
    }

    public void setTypeFinition(String typeFinition) {
        this.typeFinition = typeFinition;
    }

    public double getNiveau() {
        return niveau;
    }

    public void setNiveau(double niveau)throws Exception {
        if(niveau < 0 || niveau > 100) throw new Exception("Le pourcentage doit etre entre 0 à 100");
        this.niveau = niveau;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
}
