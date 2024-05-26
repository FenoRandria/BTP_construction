/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

/**
 *
 * @author fenor
 */
import connection.ConnectionDB;
import dao.GenericDao;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import model.Import_paiement;
import model.Paiement;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

public class ImportDataCSV {


    
//    --------------------------------------- data maison et travaux ---------------------------------------
    public void insertDataMaisonTravaux(Object record,Connection con) {
        
        try {
            String sql = "INSERT INTO Import_maison_travaux VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            System.out.println("------------------------------------"+Double.parseDouble(((CSVRecord) record).get(6).replace(",", ".")));
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setObject(1, ((CSVRecord) record).get(0));
            statement.setObject(2, ((CSVRecord) record).get(1));
            statement.setObject(3, Double.parseDouble(((CSVRecord) record).get(2).replace(",", ".")));
            statement.setObject(4, Integer.parseInt(((CSVRecord) record).get(3)));
            statement.setObject(5, ((CSVRecord) record).get(4));
            statement.setObject(6, ((CSVRecord) record).get(5));
            statement.setObject(7, Double.parseDouble(((CSVRecord) record).get(6).replace(",", ".")));
            statement.setObject(8, Double.parseDouble(((CSVRecord) record).get(7).replace(",", ".")));
            statement.setObject(9, Double.parseDouble(((CSVRecord) record).get(8).replace(",", ".")));
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void importDataFromCsv(String csvFilePath, int rang) {
        
        try (FileReader reader = new FileReader(csvFilePath);
             CSVParser csvParser = CSVFormat.DEFAULT.withFirstRecordAsHeader().parse(reader)) {
           Connection con = new ConnectionDB().getConnection("postgres");
            Iterator<CSVRecord> csvRecords = csvParser.iterator();
            while (csvRecords.hasNext()) {
                CSVRecord record = csvRecords.next();
                if(rang == 1) {
                    insertDataMaisonTravaux(record,con);
                }               
                if(rang == 2) insertDataDevis(record,con);
                if(rang == 3) insertDataPaiement(record,con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
//    --------------------------------------- data devis ---------------------------------------
    public void insertDataDevis(Object record,Connection con)  {
        
        try {
            SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
            String sql = "INSERT INTO Import_devis VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            System.out.println("------------------------------------"+Double.parseDouble(((CSVRecord) record).get(4).replace("%", "").replace(",", "")));
            
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setObject(1, ((CSVRecord) record).get(0));
            statement.setObject(2, ((CSVRecord) record).get(1));
            statement.setObject(3, ((CSVRecord) record).get(2));
            statement.setObject(4, ((CSVRecord) record).get(3));
            statement.setObject(5, Double.parseDouble(((CSVRecord) record).get(4).replace("%","").replace(",", ".")));
            statement.setObject(6, new Date( format.parse( ((CSVRecord) record).get(5) ).getTime()) );
            statement.setObject(7, new Date( format.parse( ((CSVRecord) record).get(6) ).getTime()));
            statement.setObject(8, ((CSVRecord) record).get(7));
            statement.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

//    --------------------------------------- data devis ---------------------------------------
    public void insertDataPaiement(Object record,Connection con) throws Exception {

            

                try {
                    SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                    String sql = "INSERT INTO Import_paiement VALUES (?, ?, ?, ?)";
                    PreparedStatement statement = con.prepareStatement(sql);
                    statement.setObject(1, ((CSVRecord) record).get(0));
                    statement.setObject(2, ((CSVRecord) record).get(1));
                    statement.setObject(3, new Date( format.parse( ((CSVRecord) record).get(2) ).getTime()));
                    statement.setObject(4, Double.parseDouble(((CSVRecord) record).get(3).replace(",", ".")));
                    statement.executeUpdate();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            
        
        
        
    }
    
    
    
//    =============================================== step 1 ======================================================================
    public boolean insertTypeMaisonFromImport(Connection connection) {
        boolean success = false;
        try {
            Statement statement = connection.createStatement();
            String query = "insert into typeMaison (nom,descriptions,surface,nbJourConstruction) " +
                           "select " +
                           "distinct travaux_type_maison, " +
                           "travaux_maison_descrit, " +
                           "travaux_maison_surf, " +
                           "travaux_duree " +
                           "from Import_maison_travaux;";
            System.out.println(query);
            success = statement.execute(query);
            if(!success) {
                System.out.println("Requête exécutée avec succès.");
                success = true;
            } else {
               success = false;
            }
            statement.close();
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
        }
        return success;
    }
    
    
    
    
    
//    ==================================================== step 2 =================================================================================
    public boolean insertDetailDevisMaisonFromImport(Connection connection) {
        boolean success = false;
        try {
            Statement statement = connection.createStatement();
            String query = "insert into detailDevisMaison (code, descriptions, quantite, prixUnitaire, unite, idTypeMaison) " +
                           "select " +
                            "distinct travaux_code, " +
                            "travaux_type, " +
                            "travaux_maison_quantite, " +
                            "travaux_maison_pu, " +
                            "travaux_unite, " +
                            "typeMaison.id " +
                           "from Import_maison_travaux " +
                           "join typeMaison on typeMaison.nom = Import_maison_travaux.travaux_type_maison;";
            System.out.println(query);
            success = statement.execute(query);
            if(!success) {
                System.out.println("Requête exécutée avec succès.");
                success = true;
            } else {
               success = false;
            }
            statement.close();
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
        }
        return success;
    }

//    ======================================================== step 3 =============================================================================
    public boolean insertUsersFromImport(Connection connection) {
        boolean success = false;
        try {
            Statement statement = connection.createStatement();
            String query = "insert into users (numero) select distinct devis_client_num from Import_devis;";
            success = statement.execute(query);
            if(!success) {
                System.out.println("Requête exécutée avec succès.");
                success = true;
            } else {
               success = false;
            }
            statement.close();
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
        }
        return success;
    }
    
//    ========================================================== step 4 ===========================================================================
    public boolean insertTypeFinitionFromImport(Connection connection) {
        boolean success = false;
        try {
            Statement statement = connection.createStatement();
            String query = "insert into typeFinition (typeFinition,pourcentage) " +
                                "select  " +
                                "distinct devis_type_finition, " +
                                "(devis_taux_finition/100)+1 " +
                                "from Import_devis;";
            System.out.println(query);
            success = statement.execute(query);
            if(!success) {
                System.out.println("Requête exécutée avec succès.");
                success = true;
            } else {
               success = false;
            }
            statement.close();
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
        }
        return success;
    }
//    ========================================================== step 5 ===========================================================================
    public boolean insertDevisFromImport(Connection connection) {
        boolean success = false;
        try {
            Statement statement = connection.createStatement();
            String query = "insert into devis (reference,iduser, descriptions,idtypefinition,idtypemaison,datedebut,datefin,montant,pourcentagefinition,createdAt) " +
                                "SELECT " +
                                    "DISTINCT " +
                                    "d.devis_refs, " +
                                    "u.id AS iduser, " +
                                    "d.devis_lieu, " +
                                    "tf.id AS idTypeFinition, " +
                                    "tm.id AS idTypeMaison, " +
                                    "d.devis_dateDebut, " +
                                    "(d.devis_dateDebut::DATE + (tm.nbjourconstruction * INTERVAL '1 day')) AS datefin, " +
                                    "(SUM(ddm.quantite * ddm.prixunitaire) * tf.pourcentage) AS montant, " +
                                    "tf.pourcentage AS pourcentage, " +
                                    "d.devis_date " +
                                "FROM " +
                                    "Import_devis d " +
                                    "LEFT JOIN users u ON u.numero = d.devis_client_num " +
                                    "LEFT JOIN typeFinition tf ON tf.typeFinition = d.devis_type_finition " +
                                    "LEFT JOIN typeMaison tm ON tm.nom = d.devis_type_maison " +
                                    "LEFT JOIN detaildevismaison ddm ON ddm.idtypemaison = tm.id " +
                                "GROUP BY " +
                                    "u.id, d.devis_refs, d.devis_lieu, tf.id, tm.id, d.devis_dateDebut, d.devis_date, tm.nbjourconstruction, tf.pourcentage;";
            System.out.println(query);
            success = statement.execute(query);
            if(!success) {
                System.out.println("Requête exécutée avec succès.");
                success = true;
            } else {
               success = false;
            }
            statement.close();
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
        }
        return success;
    }
    
    //    ========================================================== step 4 ===========================================================================
    public boolean insertPaiementFromImport(Connection connection) {
        boolean success = false;
        try {
            Statement statement = connection.createStatement();
            String query = "INSERT INTO paiement (reference,idDevis, montant, datePaiement)  " +
                            "select  " +
                            "DISTINCT  " +
                            "paiement_refs, " +
                            "devis.id, " +
                            "paiement_montant, " +
                            "paiement_date " +
                            "from Import_paiement,devis where devis.reference = Import_paiement.devis_refs and paiement_refs not in (select reference from paiement);";
            System.out.println(query);
            success = statement.execute(query);
            if(!success) {
                System.out.println("Requête exécutée avec succès.");
                success = true;
            } else {
               success = false;
            }
            statement.close();
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'exécution de la requête : " + e.getMessage());
        }
        return success;
    }
}

