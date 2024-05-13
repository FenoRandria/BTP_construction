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
    
    @Colonne(colonneName ="numero")
    String numero;
    
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
    
    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        System.out.println("number length: ..... "+numero.length());
        if (!this.isValidPhoneNumber(numero)) {
            throw new IllegalArgumentException("Le numéro de téléphone doit être de 10 chiffres et commencer par 033, 034, 038, 032 ou 020");
        }
        this.numero = numero;
    }
    public boolean isValidPhoneNumber(String phoneNumber) {
    if (phoneNumber.length() != 10) {
        return false;
    }
    if (!phoneNumber.startsWith("033") && !phoneNumber.startsWith("034") &&
            !phoneNumber.startsWith("032") && !phoneNumber.startsWith("038") &&
            !phoneNumber.startsWith("020")) {
        return false;
    }
    for (int i = 3; i < phoneNumber.length(); i++) {
        if (!Character.isDigit(phoneNumber.charAt(i))) {
            return false;
        }
    }
    return true;
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
    
    public User(int telephone, String numero) {
        this.setNumero(numero);
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

            return authenticatedUser;
    
        } catch (Exception e) {
            throw e;
        } finally {
            if (shouldCloseConnection && con != null) {
                con.close();
            }
        }
    }
    
     // authenticateUser par numero telephone
    public Object authenticateUser(String numero, Connection con) throws Exception {
        List<String> errors = new ArrayList<>();
        User authenticatedUser = null;
        boolean shouldCloseConnection = false;
    
        try {
            if (con == null) {
                con = new ConnectionDB().getConnection("postgres");
                shouldCloseConnection = true;
            }
    
            GenericDao dao = new GenericDao();
            ArrayList<?> users = dao.find(new User(0,numero), con);
            User u = (User) users.get(0);
            System.out.print(u);
            if (users != null &&  !users.isEmpty()) {
                return (User) users.get(0);
            } else {
                dao.executeQueryGeneral(new User(), "insert into users (numero) values ('"+numero+"') returning *", con);
                users = dao.find(new User(0,numero), con);
                if (users != null && !users.isEmpty()) {
                    return (User) users.get(0);
                }
                return errors;
            }
    
        } catch (Exception e) {
            throw e;
        } finally {
            if (shouldCloseConnection && con != null) {
                con.close();
            }
        }
    }
}
