/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.users;

import config.OutilsFormat;
import connection.ConnectionDB;
import dao.GenericDao;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Devis;
import model.TypeFinition;
import model.TypeMaison;
import model.User;
import model.V_DetailDevisMaison;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author fenor
 */
@Controller
@RequestMapping(value = "")
public class ActivityUserController {
    @RequestMapping(value = "/devis")
    public String listDevisClient(Model model, HttpServletRequest req) {
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
        if(user == null) return "redirect:/user";
        if(OutilsFormat.profileValid(user)) 
        {
            try {
                GenericDao gen = new GenericDao();
                Connection con = new ConnectionDB().getConnection("postgres");
                List<Devis> devis = (List<Devis>) gen.find(new Devis(), con);
                model.addAttribute("devis", devis);
                con.close();
                return "page/Client/devis-liste";
            }catch(Exception e) {
                model.addAttribute("error", e.getMessage());
            }
        }
        return "redirect:/user";
    }
    
    @RequestMapping(value = "/devis-form")
    public String formulaireDevisClient(Model model, HttpServletRequest req) {
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
        String role = "user";
        if(user == null) return "redirect:/admin";
        if(OutilsFormat.profileValid(user)) 
        {
            try {
                GenericDao gen = new GenericDao();
                Connection con = new ConnectionDB().getConnection("postgres");
                List<TypeFinition> typeFinitions = (List<TypeFinition>) gen.find(new TypeFinition(), con);
                List<TypeMaison> TypeMaisons = (List<TypeMaison>) gen.find(new TypeMaison(), con);
                model.addAttribute("typeFinitions", typeFinitions);             
                model.addAttribute("typeMaisons", TypeMaisons);
                con.close();
                return "page/Client/devis-formulaire";
            }catch(Exception e) {
                 return "redirect:/user?error="+e.getMessage();
            }
            
            
        } else {
            return "redirect:/user";
        }
    }
    
    @RequestMapping(value = "/devis-insert",method = RequestMethod.POST)
    @ResponseBody
    public void insertDevisClient(Model model, HttpServletRequest req,HttpServletResponse resp) {
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
        PrintWriter out = null;
        List<String> messages = new ArrayList<String>();
        
        try{
            out = resp.getWriter();
        }catch(Exception e){
            OutilsFormat.addMessage(messages, false, "error", e.getMessage());
            return;
        }
        
        if(user==null){
           OutilsFormat.addMessage(messages, false, "error", "Veuillez-reconnectez svp!");
           return;
        }
        
        int idTypeMaison = (req.getParameter("idTypeMaison") != null && !req.getParameter("idTypeMaison").trim().isEmpty()) ? Integer.parseInt(req.getParameter("idTypeMaison")) : 0;
        int idFinition = (req.getParameter("idFinition") != null && !req.getParameter("idFinition").trim().isEmpty()) ? Integer.parseInt(req.getParameter("idFinition")) : 0;
        String dateDebut = (req.getParameter("dateDebut") != null && !req.getParameter("dateDebut").trim().isEmpty()) ? req.getParameter("dateDebut") : null;
        String descriptions = (req.getParameter("descriptions") != null && !req.getParameter("descriptions").trim().isEmpty()) ? req.getParameter("descriptions") : null;
        int idUser = user.getId()>0 ? user.getId() : 0;
        
        System.out.println("tonga : ---- "+dateDebut+"/"+idTypeMaison+"/"+idFinition+"/"+idUser);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date dateDebuttype = null;
        
        boolean success = true;
        if (idTypeMaison == 0) {
            OutilsFormat.addMessage(messages, false, "errorIdTypeMaison", "Type Maison Invalide!");
            success = false;
        }
        if (idFinition == 0) {
            OutilsFormat.addMessage(messages, false, "errorIdFinition", "Type Finition Invalide!");
            success = false;
        }

        if (dateDebut == null) {
            OutilsFormat.addMessage(messages, false, "errorDateDebut", "Date Invalide!");
            success = false;
        } else {
            try {
                java.util.Date date = sdf.parse(dateDebut);
                dateDebuttype = new java.sql.Date(date.getTime());
            } catch (ParseException e) {
                OutilsFormat.addMessage(messages, false, "errorDateDebut", "Date Invalide!");
            }
        }

        if(idUser == 0)
        {
            OutilsFormat.addMessage(messages, false, "error", "Vous etes non authentifié");
            success = false;
        }
        
        if(success){
            
            Connection con = null;
            try{  
                Devis devis = new Devis(idUser, descriptions, idFinition, idTypeMaison,dateDebuttype);
                con = new ConnectionDB().getConnection("postgres");
                GenericDao gen = new GenericDao();
                String query = query = "INSERT INTO devis (iduser, descriptions, idtypefinition, idtypemaison, datedebut, datefin, montant, pourcentagefinition) VALUES (" 
                    + idUser + ", '"+devis.getDescriptions()+"',"
                    + ""+devis.getIdTypeFinition()+","
                    + " "+devis.getIdTypeMaison()+", "
                    + "'"+devis.getDateDebut() +"', "
                    + "(SELECT '"+devis.getDateDebut() +"'::DATE + (SELECT nbjourconstruction * INTERVAL '1 day' FROM typemaison WHERE id = "+devis.getIdTypeMaison()+")), "
                    + "(SELECT SUM(quantite * prixunitaire) AS montant FROM detaildevismaison WHERE idtypemaison = "+devis.getIdTypeMaison()+")*(SELECT pourcentage FROM typeFinition WHERE id = "+devis.getIdTypeFinition()+"),"
                    + "(SELECT pourcentage FROM typeFinition WHERE id = "+devis.getIdTypeFinition()+")) returning *";

                System.out.println(query);
                devis = (Devis) gen.executeQueryGeneral(devis,query, con).get(0);
                if(devis.getId()>0)
                {
                    OutilsFormat.addMessage(messages, true, null, "/devis");
                }
            }catch(Exception e){
                OutilsFormat.addMessage(messages, false, "error", e.getMessage());
            } finally  {
                try {
                    con.close();
                } catch (SQLException ex) {
                    OutilsFormat.addMessage(messages, false, "error", ex.getMessage());
                }
            }
        }
        out.print(String.join("+", messages));
    }
    
    @RequestMapping(value = "/devis-details")
    public String detailsDevisClient(@RequestParam("devis") int idDevis, Model model, HttpServletRequest req) {
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
        String role = "user";
        if(user == null) return "redirect:/user";
        if(idDevis <= 0) return "redirect:/devis";
        
        if(OutilsFormat.profileValid(user))
        {
            try {
               Connection con = new ConnectionDB().getConnection("postgres");
               GenericDao gen = new GenericDao();
               Devis devis = new Devis(idDevis);
               V_DetailDevisMaison vd = new V_DetailDevisMaison();
               devis =(Devis) gen.find(devis,con).get(0);
               if(devis.getIdUser()!=user.getId()) return "redirect:/devis?error=userInconnu";
               List<V_DetailDevisMaison> listDetails = (List<V_DetailDevisMaison>) gen.executeQueryGeneral(vd, "select * from V_DetailDevisMaison where idDevis = "+idDevis, con);
               model.addAttribute("detailsdevis", listDetails);
               return "page/Client/devis-details";           
            }catch(Exception e){
                e.printStackTrace();
                return "redirect:/devis?error=true";
            }
        } else {
            return "redirect:/devis";
        }
        
    }
    
    @RequestMapping(value = "/devis-paiement")
    public String paiementDevisClient(@RequestParam("devis") int idDevis,Model model, HttpServletRequest req) {
        
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
        if(user == null) return "redirect:/user";        
        if(idDevis <= 0) return "redirect:/devis";

        if(OutilsFormat.profileValid(user))
        {
            try {
               Connection con = new ConnectionDB().getConnection("postgres");
               GenericDao gen = new GenericDao();
               Devis devis = new Devis(idDevis);
               devis =(Devis) gen.find(devis,con).get(0);
               if(devis.getIdUser()!=user.getId()) return "redirect:/devis?error=userInconnu";
               model.addAttribute("devis", devis);
               return "page/Client/devis-paiement";           
            }catch(Exception e){
                e.printStackTrace();
                return "redirect:/devis?error=true";
            }

        } else {
            return "redirect:/devis";
        }
    }
    
    @RequestMapping(value = "/insert-paiement")
    @ResponseBody
    public void insertPaiementDevis(Model model, HttpServletRequest req,HttpServletResponse resp) {
        
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
       
        PrintWriter out = null;
        List<String> messages = new ArrayList<String>();
        
        String datePaiement = (req.getParameter("datePaiement") != null && !req.getParameter("datePaiement").trim().isEmpty()) ? req.getParameter("datePaiement") : null;
        String montant = (req.getParameter("montant") != null && !req.getParameter("montant").trim().isEmpty()) ? req.getParameter("montant") : null;
        int idDevis = (req.getParameter("idDevis") != null && !req.getParameter("idDevis").trim().isEmpty()) ? Integer.valueOf(req.getParameter("idDevis")) : 0;
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date datePaiementtype = null;
        
        boolean success = true;
        double montantDouble = 0.0;
        if (montant == null) {
            OutilsFormat.addMessage(messages, false, "errorMontant", "Montant Invalide!");
            success = false;
        }else {
            
            try {
                BigDecimal montantDecimal = new BigDecimal(montant);
                montantDouble = montantDecimal.doubleValue();
            } catch (NumberFormatException e) {
                e.printStackTrace();
                OutilsFormat.addMessage(messages, false, "errorMontant", "Montant Invalide!");
            }
        }

        if (datePaiement == null) {
            OutilsFormat.addMessage(messages, false, "errorDatePaiement", "Date Invalide!");
            success = false;
        } else {
            try {
                java.util.Date date = sdf.parse(datePaiement);
                datePaiementtype = new java.sql.Date(date.getTime());
            } catch (ParseException e) {
                OutilsFormat.addMessage(messages, false, "errorDatePaiement", "Date Invalide!");
                success = false;
            }
        }
        
        try{
            out = resp.getWriter();
        }catch(Exception e){
            OutilsFormat.addMessage(messages, false, "error", e.getMessage());
            return;
        }
        
        if(user==null){
           OutilsFormat.addMessage(messages, false, "error", "Veuillez-reconnectez svp!");
           return;
        }
        if(success){
            try {
                
               Connection con = new ConnectionDB().getConnection("postgres");
               GenericDao gen = new GenericDao();
               
               String query = "insert into paiement (idDevis,montant, datePaiement) values ("+idDevis+","+montantDouble+",'"+datePaiement+"')";
               
               if(!gen.insertQueryGeneral(query, con)){
                   OutilsFormat.addMessage(messages, true, null, "/devis");
               }  
               OutilsFormat.addMessage(messages, false, "error", "Paiement invalid!");
            }catch(Exception e){
               OutilsFormat.addMessage(messages, false, "error", e.getMessage());
            }
        }
        out.print(String.join("+", messages));
    }
}
    