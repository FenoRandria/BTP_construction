/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import annotation.Colonne;
import annotation.NotPris;
import annotation.Table;
import connection.ConnectionDB;
import dao.GenericDao;
import java.io.Serializable;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author fenor
 */

@Table(tableName="users")
public class User implements Serializable{

    @Colonne(colonneName ="id")
    int id;
    
    @Colonne(colonneName ="nom")
    String nom;
    
    @Colonne(colonneName ="mail")
    String mail;
    
    @Colonne(colonneName ="mdp")
    String mdp;
    
    @Colonne(colonneName ="corbeille")
    int corbeille;

    @Colonne(colonneName ="createdAt")
    Timestamp createdAt;
    
    @NotPris
    List<Role> roles;

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String name) {
        this.nom = name;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
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
    
    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }
    
    public User(int id, String name, String mail, String mdp, int corbeille, Timestamp createdAt) {
        this.setId(id);
        this.setNom(name);
        this.setMail(mail);
        this.setMdp(mdp);
        this.setCorbeille(corbeille);
        this.setCreatedAt(createdAt);
    }
    
    public User(int id, String name, String mail, String mdp) {
        this.setId(id);
        this.setNom(name);
        this.setMail(mail);
        this.setMdp(mdp);
    }

    public User(String name, String mail, String mdp) {
        this.setNom(name);
        this.setMail(mail);
        this.setMdp(mdp);
    }
    
    public User(String mail) {
        this.setMail(mail);
    }
    public User() {
    }
    
    
    // authenticateUser par mail et password
    public Object authenticateUser(String mail, String password, Connection con) throws Exception {
        List<String> errors = new ArrayList<>();
        User authenticatedUser = null;
        boolean shouldCloseConnection = false;
    
        try {
            if (con == null) {
                con = new ConnectionDB().getConnection("postgres");
                shouldCloseConnection = true;
            }
    
            GenericDao dao = new GenericDao();
            ArrayList<?> users = dao.find(new User(mail), con);

            if (users != null && !users.isEmpty()) {
                authenticatedUser = (User) users.get(0);
                
                if (!authenticatedUser.getMdp().equals(password)) {
                    errors.add("Mot de passe incorrect");
                    return errors;
                }
            } else {
                errors.add("Utilisateur inconnu");
                return errors;
            }
            String query = "SELECT r.id , r.rolename " +
                           "FROM users u " +
                           "JOIN userroles ur ON u.id = ur.idUser " +
                           "JOIN roles r ON ur.idRole = r.id " +
                           "WHERE u.id = "+authenticatedUser.getId();
            
            System.out.println(query);
            
            authenticatedUser.setRoles((List<Role>)dao.executeQueryGeneral(new Role(),query, con));
            System.out.println("aoanananannanna-------------------------------------- "+authenticatedUser.toString());
            System.out.println("rolename: "+authenticatedUser.getRoles().get(0));

            return authenticatedUser;
    
        } catch (Exception e) {
            throw e;
        } finally {
            if (shouldCloseConnection && con != null) {
                con.close();
            }
        }
    }
    
}
