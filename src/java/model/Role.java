/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import annotation.Colonne;
import annotation.NotPris;
import annotation.Table;
import java.sql.Timestamp;

/**
 *
 * @author fenor
 */
@Table(tableName="roles")
public class Role {

    @Colonne(colonneName ="id")
    int id;
    
    @Colonne(colonneName ="rolename")
    String rolename;
    @NotPris
    @Colonne(colonneName ="corbeille")
    int corbeille;
    @NotPris
    @Colonne(colonneName ="createdAt")
    Timestamp createdAt;
    
    
    public Role() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
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
