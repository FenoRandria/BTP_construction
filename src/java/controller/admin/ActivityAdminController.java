/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin;

import config.OutilsFormat;
import connection.ConnectionDB;
import dao.GenericDao;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.Dashboard;
import model.DetailDevisMaison;
import model.Devis;
import model.TypeFinition;
import model.User;
import model.V_DetailDevisMaison;
import model.V_detailDevis;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import service.FileService;
import service.ImportDataCSV;
import javax.servlet.http.HttpServletResponse;
import model.Paiement;

/**
 *
 * @author fenor
 */
@Controller
@RequestMapping("")
public class ActivityAdminController {
    
    
    
    @RequestMapping("/dashboard")
    public String loginPageAdmin(Model model, HttpServletRequest req) {
//        return "page/auth/login-admin";  
        Dashboard dash = new Dashboard();
        model.addAttribute("totalMontant",dash.sommeTotalMontant());
        model.addAttribute("devisannee",dash.findmontantdevisannee());
        model.addAttribute("devismois",dash.findmontantdevismois());
        model.addAttribute("yearExistant",new Dashboard().getYearExistant());
        return "page/Admin/dashboard";
    }
    
    @RequestMapping("/adminYears")
    public String adminYears(Model model, HttpServletRequest req) throws Exception 
    {
        model.addAttribute("totalMontant",new Dashboard().sommeTotalMontant());
        model.addAttribute("yearExistant",new Dashboard().getYearExistant());
        model.addAttribute("devisannee",new Dashboard().findmontantdevisannee());
        model.addAttribute("yartCheck",req.getParameter("years"));
        model.addAttribute("devismois",new Dashboard().findmontantdevismoisParAnnee(Integer.valueOf(req.getParameter("years"))));
        return loginPageAdmin(model, req);
    }
    
    @RequestMapping(value = "/refresh-table")
    public String refresh(Model model, HttpServletRequest req) throws Exception {
        String query = "Truncate paiement,devis,typemaison,import_devis,import_maison_travaux,import_paiement,typefinition,users Cascade; " +
                       "INSERT INTO users (nom, mail, numero, mdp) " +
                       "VALUES ('Admin', 'admin@gmail.com', '0341129612', '123');";
        System.out.println(query);
        new GenericDao().insertQueryGeneral(query, null);
        return "redirect:/admin";

    }
    
    
    @RequestMapping(value = "/import-data-file")
    public String importaPageAdmin(Model model, HttpServletRequest req) {

        return "page/Admin/importDataCsv";

    }
    
    @RequestMapping(value = "/travaux")
    public String travauxPageAdmin(Model model, HttpServletRequest req) throws Exception {
        List<DetailDevisMaison> list = (List<DetailDevisMaison>) new GenericDao().find(new DetailDevisMaison(), null);
        model.addAttribute("listTravail", list);
        return "page/Admin/detailDevisMaison";

    }
    
    
    @RequestMapping(value = "/update-travaux")
    public String updateTravauxPageAdmin(Model model, HttpServletRequest req) throws Exception {
        DetailDevisMaison devis = null;
        if(!req.getParameter("id").trim().isEmpty()) {
            int id = Integer.valueOf(req.getParameter("id"));
            if(id <=0) return "redirect:/travaux?error=true";
            devis = new DetailDevisMaison(id);
            try{
                devis = (DetailDevisMaison) new GenericDao().find(devis, null).get(0);
                model.addAttribute("devis", devis);
                return "page/Admin/travaux-update";
            }catch (Exception e) {
                return "redirect:/travaux?error="+e.getMessage();
            }
        }
        return "redirect:/travaux?error=true";
    }      
    
    
    
    @RequestMapping(value = "/finition")
    public String fintionPageAdmin(Model model, HttpServletRequest req) throws Exception {
        List<TypeFinition> list = (List<TypeFinition>) new GenericDao().find(new TypeFinition(), null);
        model.addAttribute("listTypeFinition", list);
        return "page/Admin/finition";

    }
    
    @RequestMapping(value = "/update-finition")
    public String updateFintionPageAdmin(Model model, HttpServletRequest req) throws Exception {
        TypeFinition finition = null;
        if(!req.getParameter("id").trim().isEmpty()) {
            int id = Integer.valueOf(req.getParameter("id"));
            if(id <=0) return "redirect:/finition?error=true";
            finition = new TypeFinition(id);
            try{
                finition = (TypeFinition) new GenericDao().find(finition, null).get(0);
                model.addAttribute("finition", finition);
                return "page/Admin/finition-update";
            }catch (Exception e) {
                return "redirect:/finition?error="+e.getMessage();
            }
        }
        return "redirect:/fintion?error=true";
    }  
    
    @RequestMapping(value="/update-travaux-detail", method=RequestMethod.POST)
    public String updateTravaux(Model model, HttpServletRequest req, HttpServletResponse resp) {
        
        PrintWriter out = null;
        List<String> messages = new ArrayList<String>();
        User user = (User)req.getSession().getAttribute("user");
        try{
            out = resp.getWriter();
        }catch(Exception e){
            OutilsFormat.addMessage(messages, false, "error", e.getMessage());
        }
        
        if(user==null){
           OutilsFormat.addMessage(messages, false, "error", "Veuillez-reconnectez svp!");
        }
        
        int id = (req.getParameter("id") != null && !req.getParameter("id").trim().isEmpty()) ? Integer.parseInt(req.getParameter("id")) : 0;
        String code = (req.getParameter("code") != null && !req.getParameter("code").trim().isEmpty()) ? req.getParameter("code") : null;          
        String descriptions = (req.getParameter("descriptions") != null && !req.getParameter("descriptions").trim().isEmpty()) ? req.getParameter("descriptions") : null;        
        String prixUnitaire = (req.getParameter("prixUnitaire") != null && !req.getParameter("prixUnitaire").trim().isEmpty()) ? req.getParameter("prixUnitaire") : null;        
        String quantite = (req.getParameter("quantite") != null && !req.getParameter("quantite").trim().isEmpty()) ? req.getParameter("quantite") : null;        
        
        System.out.println(id+":"+code+":"+descriptions+":"+prixUnitaire+":"+quantite);
        
        boolean success = true;
        
        if (code == null) {
            OutilsFormat.addMessage(messages, false, "errorCode", "Code Invalide!");
            success = false;
        }

        if (descriptions == null) {
            OutilsFormat.addMessage(messages, false, "errorDescriptions", "Descriptions Invalide!");
            success = false;
        }
        
        double pu = 0.00;
        if (prixUnitaire == null) {      
            OutilsFormat.addMessage(messages, false, "errorPrixUnitaire", "Prix Unitaire Invalide!");
            success = false;
        } else {
        
            try {
                quantite = quantite.replace(",", ".");
                BigDecimal montantDecimal = new BigDecimal(quantite);
                pu = montantDecimal.doubleValue()*100;
                
                if (pu <= 0.00) {
                    OutilsFormat.addMessage(messages, false, "errorPrixUnitaire", "Prix Unitaire invalid!");
                    success = false;
                }
            } catch (Exception e) {
                e.printStackTrace();
                OutilsFormat.addMessage(messages, false, "errorPrixUnitaire", "Prix Unitaire Invalide!");
            }
        }
        
        double qtt = 0.00;
        if (quantite == null) {
            OutilsFormat.addMessage(messages, false, "errorQuantite", "Quantite Invalide!");
            success = false;
        }else {
            try {
                quantite = quantite.replace(",", ".");
                BigDecimal montantDecimal = new BigDecimal(quantite);
                qtt = montantDecimal.doubleValue()*100;
                
                if (qtt <= 0.00) {
                    OutilsFormat.addMessage(messages, false, "errorQuantite", "Quantite invalid!");
                    success = false;
                }
            } catch (Exception e) {
//                e.printStackTrace();
                OutilsFormat.addMessage(messages, false, "errorQuantite", "Quantite Invalide!");
                success = false;
            }
        }

        if(success){
            DetailDevisMaison dt = new  DetailDevisMaison( id, descriptions,  code,  pu,  qtt);
            
            Connection con = null;
            try{  
                con = new ConnectionDB().getConnection("postgres");
                GenericDao gen = new GenericDao();
                dt.updateDetailsDevisMaison(String.valueOf(id), descriptions,code, String.valueOf(pu), String.valueOf(qtt));
//                gen.update(dt, con);
                dt = (DetailDevisMaison) gen.find(dt, con).get(0);
                if(dt.getId()>0)
                {
                    return "redirect:/travaux";
                }
            } catch(Exception e){
//                e.printStackTrace();
                OutilsFormat.addMessage(messages, false, "error", e.getMessage());
            } finally  {
                try {
                    con.close();
                } catch (Exception ex) {
                    OutilsFormat.addMessage(messages, false, "error", ex.getMessage());
                }
            }
        }
//        out.print(String.join("+", messages));
        return "redirect:/update-finition";
    }
    
    
    @RequestMapping(value="/update-finition-detail")
    public String updateFinition(Model model, HttpServletRequest req, HttpServletResponse resp){
        
//        PrintWriter out = null;
//        List<String> messages = new ArrayList<String>();
//        User user = (User)req.getSession().getAttribute("user");
//        try{
//            out = resp.getWriter();
//        }catch(Exception e){
//            OutilsFormat.addMessage(messages, false, "error", e.getMessage());
//            return "redirect:/update-finition";
//        }
//        
//        if(user==null){
//           OutilsFormat.addMessage(messages, false, "error", "Veuillez-reconnectez svp!");
//           return "redirect:/update-finition";
//        }
//        
        int id = (req.getParameter("id") != null && !req.getParameter("id").trim().isEmpty()) ? Integer.parseInt(req.getParameter("id")) : 0;
        String niveau = (req.getParameter("niveau") != null && !req.getParameter("niveau").trim().isEmpty()) ? req.getParameter("niveau") : null;       
        
//        boolean success = true;
//        double pourcentage = 0.00;
//        
//        if (niveau == null) {
//            OutilsFormat.addMessage(messages, false, "errorCode", "Code Invalide!");
//            success = false;
//        }else {
//            try {
//                niveau = niveau.replace(",", ".");
//                BigDecimal montantDecimal = new BigDecimal(niveau);
//                pourcentage = montantDecimal.doubleValue();
//                
//                if (pourcentage <= 0.00 || pourcentage > 100.00) {
//                    
//                    OutilsFormat.addMessage(messages, false, "errorNiveau", "Pourcentage invalid!");
//                    success = false;
//                }
//            } catch (Exception e) {
////                e.printStackTrace();
//                OutilsFormat.addMessage(messages, false, "errorNiveau", "Pourcentage Invalide!");
//                success = false;
//            }
//        }


//        if(success){
//            pourcentage = (pourcentage/100)+1;
            TypeFinition tf = new TypeFinition();
            
//            Connection con = null;
//            try{  
//                con = new ConnectionDB().getConnection("postgres");
//                GenericDao gen = new GenericDao();
                tf.updatePourcentage(niveau, id);
//                gen.update(tf, con);
//                tf = (TypeFinition) gen.find(tf, con).get(0);
//                if(tf.getId()>0)
//                {
                    return "redirect:/finition";
//                }
//            } catch(Exception e){
////                e.printStackTrace();
//                OutilsFormat.addMessage(messages, false, "error", e.getMessage());
//                success = false;
//            } finally  {
//                try {
//                    con.close();
//                } catch (Exception ex) {
//                    OutilsFormat.addMessage(messages, false, "error", ex.getMessage());
//                    success = false;
//                }
//            }
//        }
//        out.print(String.join("+", messages));
//            return "redirect:/update-finition?error=exist";
    }
     
    @RequestMapping(value = "/import-paiement")
    public String pageImportPaiement(Model model, HttpServletRequest req) {
        return "page/Admin/paiementImportCsv";
    }
    
    
    
    @RequestMapping(value = "/devis-encours")
    public String pageDevisEncous(Model model, HttpServletRequest req) {
//        HttpSession session = req.getSession();
//        User user = (User)session.getAttribute("user");
//        if(user == null) return "redirect:/admin";

        try {
            GenericDao gen = new GenericDao();
            Connection con = new ConnectionDB().getConnection("postgres");
            List<V_detailDevis> devis = (List<V_detailDevis>) gen.find(new V_detailDevis(), con);
            model.addAttribute("devisEncours", devis);
            con.close();
            return "page/Admin/devis-encours";
        }catch(Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/admin";
    }
    
    @RequestMapping(value = "/devis-details-admin")
    public String detailsDevisClient(@RequestParam("devis") int idDevis, Model model, HttpServletRequest req) {
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
//        if(user == null) return "redirect:/user";
        if(idDevis <= 0) return "redirect:/admin";
        try {
           Connection con = new ConnectionDB().getConnection("postgres");
           GenericDao gen = new GenericDao();
           Devis devis = new Devis(idDevis);
           V_DetailDevisMaison vd = new V_DetailDevisMaison();
           devis =(Devis) gen.find(devis,con).get(0);
//               if(devis.getIdUser()!=user.getId()) return "redirect:/devis?error=userInconnu";
           List<V_DetailDevisMaison> listDetails = (List<V_DetailDevisMaison>) gen.executeQueryGeneral(vd, "select * from V_DetailDevisMaison where idDevis = "+idDevis, con);
           
           List<Paiement> listPaiements = (List<Paiement>) new Paiement().findPaymentDevis(String.valueOf(idDevis));
           model.addAttribute("detailsdevis", listDetails);           
           model.addAttribute("paiements", listPaiements);

           return "page/Admin/devis-details-admin";           
        }catch(Exception e){
            e.printStackTrace();
            return "redirect:/devis-encours?errordetail=true";
        }
  
    }
    

    @RequestMapping(value="/upload-file-data", method=RequestMethod.POST)
    public String importDataFile(Model model, @RequestParam("maisonTravaux") MultipartFile fileMaisonTravaux, @RequestParam("devis") MultipartFile fileDevis ){
        if(!fileMaisonTravaux.isEmpty() || !fileDevis.isEmpty()) {
           String maisonTravaux = "D:\\S6\\BTP_construction\\web\\assets\\upload\\"+ fileMaisonTravaux.getOriginalFilename();           
           String devis = "D:\\S6\\BTP_construction\\web\\assets\\upload\\"+ fileDevis.getOriginalFilename();

            File destinationFile1 = new File(maisonTravaux);            
            File destinationFile2 = new File(devis);
    
            try{
                
                fileMaisonTravaux.transferTo(destinationFile1);
                fileDevis.transferTo(destinationFile2);
                Connection con = new ConnectionDB().getConnection("postgres");
                

                ImportDataCSV importa = new ImportDataCSV();
                importa.importDataFromCsv(maisonTravaux,1);    
                
                importa.insertTypeMaisonFromImport(con);               
                importa.insertDetailDevisMaisonFromImport(con);
                
                importa.importDataFromCsv(devis,2);
                importa.insertUsersFromImport(con);
                importa.insertTypeFinitionFromImport(con);
                importa.insertDevisFromImport(con);
                return "redirect:/admin?import=success"
                        ;
            }catch(Exception e){
                model.addAttribute("error","import file echouée!"+e.getMessage());
                return "redirect:/import-data-file";
            }
        }
        model.addAttribute("error","file does not null!");
        return "redirect:/import-data-file";
    }
    
    @RequestMapping(value="/upload-file-data-paiement", method=RequestMethod.POST)
    public String importDataFilePaiement(Model model, @RequestParam("paiement") MultipartFile paiementFile ){
        if(!paiementFile.isEmpty()) {
           String paiementFilePath = "D:\\S6\\BTP_construction\\web\\assets\\upload\\"+ paiementFile.getOriginalFilename();
            File destinationFile = new File(paiementFilePath);
            try{
                paiementFile.transferTo(destinationFile);
                ImportDataCSV importa = new ImportDataCSV();
                importa.importDataFromCsv(paiementFilePath,3);
                Connection con = new ConnectionDB().getConnection("postgres");
                importa.insertPaiementFromImport(con);
                return "redirect:/admin?import=success";
            }catch(Exception e){
                model.addAttribute("error","import file echouée!"+e.getMessage());
                return "redirect:/import-data-file";
            }
        }
        model.addAttribute("error","file does not null!");
        return "redirect:/import-data-file";
    }    
}
