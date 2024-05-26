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
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import connection.ConnectionDB;
import java.util.List;

public class Paiement {
    private int id;
    private int idDevis;
    private double montant;
    private Date datePaiement;
    String reference;

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }
    

    // Constructeurs
    public Paiement() {
    }

    public Paiement(int idDevis, double montant, Date datePayment) {
        this.idDevis = idDevis;
        this.montant = montant;
        this.datePaiement = datePayment;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdDevis() {
        return idDevis;
    }

    public void setIdDevis(int idDevis) {
        this.idDevis = idDevis;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDatePaiement() {
        return datePaiement;
    }

    public void setDatePayment(Date datePayment) {
        this.datePaiement = datePayment;
    }

    // CRUD Operations

    // Insertion d'un paiement
    public int insertPayment() {
        String query = "INSERT INTO payment (idDevis, montant, datePayment) VALUES (" + this.idDevis + ", "
                + this.montant + ", '" + this.datePaiement + "') RETURNING id";

        int id = 0;
        try {
            ConnectionDB co = new ConnectionDB();
            Connection c = co.getConnection("postgres");
            Statement st = c.createStatement();
            ResultSet rs = st.executeQuery(query);
            if (rs.next()) {
                id = rs.getInt(1);
            }
            System.out.println("Insertion du paiement réussie");
        } catch (Exception e) {
            System.out.println(e);
        }
        return id;
    }

    // Sélection de tous les paiements
//    public static Payment[] findAll() throws Exception {
//        ArrayList<Payment> payments = new ArrayList<>();
//        String query = "SELECT * FROM payment";
//        ConnectionDB co = new ConnectionDB();
//        Connection c = co.getConnection("postgres");
//        try {
//            Statement st = c.createStatement();
//            ResultSet result = st.executeQuery(query);
//            while (result.next()) {
//                Payment payment = new Payment();
//                payment.setId(result.getInt("id"));
//                payment.setIdDevis(result.getInt("idDevis"));
//                payment.setMontant(result.getDouble("montant"));
//                payment.setDatePayment(result.getDate("datePayment"));
//                payments.add(payment);
//            }
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        return payments.toArray(new Payment[payments.size()]);
//    }

        // Sélection de tous les paiements
        public  List<Paiement> findPaymentDevis(String idDevis ) throws Exception {
            ArrayList<Paiement> payments = new ArrayList<>();
            String query = "select * from paiement where iddevis = "+ idDevis;
            ConnectionDB co = new ConnectionDB();
            Connection c = co.getConnection("postgres");
            try {
                Statement st = c.createStatement();
                ResultSet result = st.executeQuery(query);
                while (result.next()) {
                    Paiement payment = new Paiement();
                    payment.setId(result.getInt("id"));
                    payment.setIdDevis(result.getInt("idDevis"));
                    payment.setMontant(result.getDouble("montant"));
                    payment.setDatePayment(result.getDate("datePaiement"));
                    payments.add(payment);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
            return payments;
        }
        
        
        public List<Paiement> findPayment(String refPaiment) throws Exception {
            ArrayList<Paiement> payments = new ArrayList<>();
            String query = "select * from paiement where reference = '"+ refPaiment+"'";
            ConnectionDB co = new ConnectionDB();
            Connection c = co.getConnection("postgres");
            try {
                Statement st = c.createStatement();
                ResultSet result = st.executeQuery(query);
                while (result.next()) {
                    Paiement payment = new Paiement();
                    payment.setId(result.getInt("id"));
                    payment.setIdDevis(result.getInt("idDevis"));
                    payment.setMontant(result.getDouble("montant"));
                    payment.setDatePayment(result.getDate("datePaiement"));
                    payments.add(payment);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
            return payments;
        }
    

    // Mise à jour d'un paiement
//    public static void updatePayment(int id, double newMontant, Date newDatePayment) {
//        String query = "UPDATE payment SET montant = " + newMontant + ", datePayment = '" + newDatePayment
//                + "' WHERE id = " + id;
//        System.out.println(query);
//        try {
//            ConnectionDB co = new ConnectionDB();
//            Connection connection = co.getConnection("postgres");
//            Statement statement = connection.createStatement();
//            statement.executeUpdate(query);
//            System.out.println("Mise à jour du paiement réussie");
//        } catch (Exception e) {
//            System.out.println("Erreur lors de la mise à jour du paiement : " + e.getMessage());
//        }
//    }

    // Suppression d'un paiement
//    public static void deletePayment(int id) {
//        String query = "DELETE FROM payment WHERE id = " + id;
//        System.out.println(query);
//        try {
//            ConnectionDB co = new ConnectionDB();
//            Connection connection = co.getConnection("postgres");
//            Statement statement = connection.createStatement();
//            statement.executeUpdate(query);
//            System.out.println("Suppression du paiement réussie");
//        } catch (Exception e) {
//            System.out.println("Erreur lors de la suppression du paiement : " + e.getMessage());
//        }
//    }

    // Méthode pour vérifier le login de l'utilisateur
//    public boolean checkLogin(String mail, String mdp) {
//        String query = "SELECT * FROM users WHERE mail = '" + mail + "' AND mdp = '" + mdp + "'";
//        try {
//            ConnectionDB co = new ConnectionDB();
//            Connection connection = co.getConnection("postgres");
//            Statement statement = connection.createStatement();
//            ResultSet result = statement.executeQuery(query);
//            if (result.next()) {
//                // Si on trouve une correspondance pour l'email et le mot de passe, retourne vrai
//                return true;
//            }
//        } catch (Exception e) {
//            System.out.println("Erreur lors de la vérification du login : " + e.getMessage());
//        }
//        // Si aucune correspondance trouvée, retourne faux
//        return false;
//    }

    // Méthode pour récupérer l'ID de l'utilisateur après vérification du login
//    public int getUserId(String mail, String mdp) {
//        if (checkLogin(mail, mdp)) {
//            String query = "SELECT id_user FROM users WHERE mail = '" + mail + "'";
//            try {
//                ConnectionDB co = new ConnectionDB();
//                Connection connection = co.getConnection("postgres");
//                Statement statement = connection.createStatement();
//                ResultSet result = statement.executeQuery(query);
//                if (result.next()) {
//                    return result.getInt("id_user");
//                }
//            } catch (Exception e) {
//                System.out.println("Erreur lors de la récupération de l'ID de l'utilisateur : " + e.getMessage());
//            }
//        }
//        return 0;
//    }
}
