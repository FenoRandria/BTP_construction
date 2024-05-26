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
import connection.ConnectionDB;
import java.sql.Connection;
import java.sql.Statement;
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

    public TypeFinition(int id, double niveau) {
        this.id = id;
        this.niveau = niveau;
    }

    public TypeFinition() {
    }

    // Getters and Setters...

    public TypeFinition(int id) {
        this.id = id;
    }
    
    

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
    public  void updatePourcentage(String newPourcentage, int id) {
        
        if (!String.valueOf(newPourcentage).contains(".")) {
            // Ajouter ".00" au nouveau pourcentage s'il n'y a pas de virgule
            newPourcentage += ".00";
        }
        String query = "UPDATE typeFinition SET pourcentage = ((" + newPourcentage + "/100) + 1) WHERE id = " + id;

        System.out.println(query);
        try {
            ConnectionDB co = new ConnectionDB();
            Connection connection = co.getConnection("postgres");
            Statement statement = connection.createStatement();
            statement.executeUpdate(query);
            System.out.println("Mise à jour du pourcentage du type de finition réussie");
        } catch (Exception e) {
            System.out.println("Erreur lors de la mise à jour du pourcentage du type de finition : " + e.getMessage());
        }
    }
}
