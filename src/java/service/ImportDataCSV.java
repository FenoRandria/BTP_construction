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
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

public class ImportDataCSV {


    
//    --------------------------------------- data maison et travaux ---------------------------------------
    public void insertDataMaisonTravaux(Object record) {
        
        try {
            Connection con = new ConnectionDB().getConnection("postgres");
            String sql = "INSERT INTO Import_maison_travaux VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            System.out.println(((CSVRecord) record).get(6).replace(",", "."));
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setObject(1, ((CSVRecord) record).get(0));
            statement.setObject(2, ((CSVRecord) record).get(1));
            statement.setObject(3, new BigDecimal(((CSVRecord) record).get(2)));
            statement.setObject(4, Integer.parseInt(((CSVRecord) record).get(3)));
            statement.setObject(5, ((CSVRecord) record).get(4));
            statement.setObject(6, ((CSVRecord) record).get(5));
            statement.setObject(7, new BigDecimal(((CSVRecord) record).get(6).replace(",", ".")));
            statement.setObject(8, new BigDecimal(((CSVRecord) record).get(7)));
            statement.setObject(9, new BigDecimal(((CSVRecord) record).get(8)));
            statement.executeUpdate();
            con.close();
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
                if(rang == 1) insertDataMaisonTravaux(record);                
                if(rang == 2) insertDataDevis(record);
                if(rang == 3) insertDataPaiement(record);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
//    --------------------------------------- data devis ---------------------------------------
    public void insertDataDevis(Object record) {
        
        try {
            Connection con = new ConnectionDB().getConnection("postgres");
            String sql = "INSERT INTO Import_devis VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            System.out.println(((CSVRecord) record).get(4).replace("%", "").replace(",", "."));
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setObject(1, ((CSVRecord) record).get(0));
            statement.setObject(2, ((CSVRecord) record).get(1));
            statement.setObject(3, ((CSVRecord) record).get(2));
            statement.setObject(4, ((CSVRecord) record).get(3));
            statement.setObject(5, new BigDecimal(((CSVRecord) record).get(4).replace("%","").replace(",", ".")));
            statement.setObject(6, Date.valueOf(((CSVRecord) record).get(5)));
            statement.setObject(7, Date.valueOf(((CSVRecord) record).get(6)));
            statement.setObject(8, ((CSVRecord) record).get(7));
            statement.executeUpdate();
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
 
//    --------------------------------------- data devis ---------------------------------------
    public void insertDataPaiement(Object record) {
        
        try {
            Connection con = new ConnectionDB().getConnection("postgres");
            String sql = "INSERT INTO Import_paiement VALUES (?, ?, ?, ?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setObject(1, ((CSVRecord) record).get(0));
            statement.setObject(2, ((CSVRecord) record).get(1));
            statement.setObject(3, Date.valueOf(((CSVRecord) record).get(2)));
            statement.setObject(4, new BigDecimal(((CSVRecord) record).get(3)));
            statement.executeUpdate();
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
