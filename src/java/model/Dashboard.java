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

import connection.ConnectionDB;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Dashboard {
    private int year;
    private double month;
    private String month_name;
    private double montanttotal;
    private double sommemontant;

   
    // Constructeurs
    public Dashboard() {
    }

    public Dashboard(int year, double month, String month_name, double montanttotal) {
        this.year = year;
        this.month = month;
        this.month_name = month_name;
        this.montanttotal = montanttotal;
    }

    public Dashboard(int year, double montanttotal) {
        this.year = year;
        this.montanttotal = montanttotal;
    }

    public Dashboard(double sommemontant) {
        this.sommemontant = sommemontant;
    }

    // Getters et Setters
    public double getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public double getMonth() {
        return month;
    }

    public void setMonth(double month) {
        this.month = month;
    }

    public String getMonthName() {
        return month_name;
    }

    public void setMonthName(String month_name) {
        this.month_name = month_name;
    }

    public double getMontantTotal() {
        return montanttotal;
    }

    public void setMontantTotal(double montanttotal) {
        this.montanttotal = montanttotal;
    }

    public double getSommemontant() {
        return sommemontant;
    }

    public void setSommemontant(double sommemontant) {
        this.sommemontant = sommemontant;
    }

    // CRUD Operations

    public  Dashboard[] findmontantdevismois() {
        ArrayList<Dashboard> dashboardData = new ArrayList<>();
        String query = "select * from v_devismois";
        try {
            ConnectionDB co = new ConnectionDB();
            Connection connection = co.getConnection("postgres");
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(query);
            while (result.next()) {
                dashboardData.add(new Dashboard(
                        result.getInt("year"),
                        result.getDouble("month"),
                        result.getString("month_name"),
                        result.getDouble("montanttotal")
                ));
            }
        } catch (Exception e) {
            System.out.println("Erreur lors de la récupération des données du tableau de bord : " + e.getMessage());
        }
        return dashboardData.toArray(new Dashboard[dashboardData.size()]);
    }
    
    public  Dashboard[] findmontantdevismoisFilterByYears(int years) {
        ArrayList<Dashboard> dashboardData = new ArrayList<>();
        String query = "select * from v_devismois where year = "+years;
        try {
            ConnectionDB co = new ConnectionDB();
            Connection connection = co.getConnection("postgres");
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(query);
            while (result.next()) {
                dashboardData.add(new Dashboard(
                        result.getInt("year"),
                        result.getDouble("month"),
                        result.getString("month_name"),
                        result.getDouble("montanttotal")
                ));
            }
        } catch (Exception e) {
            System.out.println("Erreur lors de la récupération des données du tableau de bord : " + e.getMessage());
        }
        return dashboardData.toArray(new Dashboard[dashboardData.size()]);
    }


    public  Dashboard[] findmontantdevisannee() {
        ArrayList<Dashboard> dashboardData = new ArrayList<>();
        String query = " select * from v_devisannee";
        try {
            ConnectionDB co = new ConnectionDB();
            Connection connection = co.getConnection("postgres");
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(query);
            while (result.next()) {
                dashboardData.add(new Dashboard(
                        result.getInt("year"),
                        result.getDouble("montanttotal")
                ));
            }
        } catch (Exception e) {
            System.out.println("Erreur lors de la récupération des données du tableau de bord : " + e.getMessage());
        }
        return dashboardData.toArray(new Dashboard[dashboardData.size()]);
    }

    public  Dashboard[] sommeTotalMontant() {
        ArrayList<Dashboard> dashboardData = new ArrayList<>();
        String query = "select sum(montant)as sommeMontant from devis;";
        try {
            ConnectionDB co = new ConnectionDB();
            Connection connection = co.getConnection("postgres");
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(query);
            while (result.next()) {
                dashboardData.add(new Dashboard(
                        result.getDouble("sommemontant")
                ));
            }
        } catch (Exception e) {
            System.out.println("Erreur lors de la récupération des données du tableau de bord : " + e.getMessage());
        }
        return dashboardData.toArray(new Dashboard[dashboardData.size()]);
    }
    

    
    
//    ------------------- jour 2 *******************************************
    public double getTotalMontantPaiement() {
        String query = "select sum(montant) as totalPaiement from paiement";
        double result = 0.0;
        try {
            ConnectionDB co = new ConnectionDB();
            Connection connection = co.getConnection("postgres");
            Statement statement = connection.createStatement();
            ResultSet res = statement.executeQuery(query);
            if (res.next()) {
                result = res.getDouble("totalPaiement");
            }
            
        } catch (Exception e) {
            System.out.println("Erreur lors de la récupération des données du tableau de bord : " + e.getMessage());
        }
        return result;
    }
    
    public int[] getYearExistant() {
        int[] years = null;
        String query = "select DISTINCT year from v_devismois";
        try {
            ConnectionDB co = new ConnectionDB();
            Connection connection = co.getConnection("postgres");
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(query);
            int i = 0;
            if (result.next()) {
                System.out.println("***************************"+result.getInt("year"));
                years[i]= result.getInt("year");
                i++;
            }
            return years;
        } catch (Exception e) {
            System.out.println("Erreur lors de la récupération des données du tableau de bord : " + e.getMessage());
        }
        return null;
    }
    
     public  Dashboard[] findmontantdevismoisParAnnee(int annee) {
        ArrayList<Dashboard> dashboardData = new ArrayList<>();
        String query = "select * from v_devismois where year = " + annee;
        try {
            ConnectionDB co = new ConnectionDB();
            Connection connection = co.getConnection("postgres");
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(query);
            while (result.next()) {
                dashboardData.add(new Dashboard(
                        result.getInt("year"),
                        result.getDouble("month"),
                        result.getString("month_name"),
                        result.getDouble("montanttotal")
                ));
            }
        } catch (Exception e) {
            System.out.println("Erreur lors de la récupération des données du tableau de bord : " + e.getMessage());
        }
        return dashboardData.toArray(new Dashboard[dashboardData.size()]);
    }
}