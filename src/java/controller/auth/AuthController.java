/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.auth;

import config.Gestion_exception;
import java.sql.Connection;

import javax.management.modelmbean.ModelMBean;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import connection.ConnectionDB;
import javax.servlet.http.HttpSession;
import model.User;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import config.OutilsFormat;
import dao.GenericDao;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
/**
 *
 * @author fenor
 */
@Controller
@RequestMapping(value="")
public class AuthController {
    @RequestMapping(value = "")
    public String indexUser(Model model, HttpServletRequest req) {
        return this.loginPageUser(model, req);
//            return "index";
    }
    
    @RequestMapping(value = "/admin")
    public String loginPageAdmin(Model model, HttpServletRequest req) {
        return "page/auth/login-admin";
    }
    
    @RequestMapping(value = "/admin-login", method = RequestMethod.POST)
    @ResponseBody
    public String checkLoginAdmin(Model model, HttpServletRequest req, HttpServletResponse resp,RedirectAttributes redirectAttributes)throws Exception {      
        PrintWriter out = resp.getWriter();
        List<String> messages = new ArrayList<String>();

        String mail = (req.getParameter("mail") != null && !req.getParameter("mail").trim().isEmpty()) ? req.getParameter("mail") : null;
        String mdp = (req.getParameter("mdp") != null && !req.getParameter("mdp").trim().isEmpty()) ? req.getParameter("mdp") : null;
    
        boolean success = true;
        if (mail == null || !OutilsFormat.isEmailValid(mail)) {
            OutilsFormat.addMessage(messages, false, "errorMail", "Mail Invalide!");
            success = false;
        }
        if (mdp == null) {
            OutilsFormat.addMessage(messages, false, "errorMdp", "Mot de passe Invalide!");
            success = false;
        }
        
        if(success) {
           User user = new User();
           GenericDao gen = new GenericDao();
           try{
               Connection con = new ConnectionDB().getConnection("postgres");
               System.out.println(con);
               Object obj = user.authenticateUser(mail, mdp, con);
               System.out.println(obj);
               if (obj instanceof User) {
                    HttpSession session = req.getSession();            
                    session.setAttribute("user", (User) obj);
                    con.close();
                    if(user.getMail()!="")
                    {
                        OutilsFormat.addMessage(messages, true, "success", "/gestion-places");
                    } else {
                        OutilsFormat.addMessage(messages, false, "error", "vous n'avez pas d'accès");
                    }
                } else { List<String> errs = (List<String>) obj;
                    OutilsFormat.addMessage(messages, false, "error", errs.get(0));
                    model.addAttribute("cause",obj);
                }
           }catch(Exception e){
               e.printStackTrace();
               OutilsFormat.addMessage(messages, false, "error", HttpStatus.INTERNAL_SERVER_ERROR+"/"+e.getMessage());
           }
           
        }
        out.print(String.join("+", messages));
        return null;
    }
    
//    ============================================= user authentification =========================================================================================
    @RequestMapping(value = "/user-login", method = RequestMethod.POST)
    @ResponseBody
    public String checkLoginUser(Model model, HttpServletRequest req, HttpServletResponse resp,RedirectAttributes redirectAttributes)throws Exception {      
        PrintWriter out = resp.getWriter();
        List<String> messages = new ArrayList<String>();

        String numero = (req.getParameter("telephone") != null && !req.getParameter("telephone").trim().isEmpty()) ? req.getParameter("telephone") : null;
        System.out.println("numero:"+numero);
        boolean success = true;
        if (numero == null) {
            OutilsFormat.addMessage(messages, false, "errorNumero", "Numero Invalide!");
            success = false;
        }
        
        if(success){
           User user = new User();
           GenericDao gen = new GenericDao();
           try{
               Connection con = new ConnectionDB().getConnection("postgres");
               Object obj = user.authenticateUser(numero, con);
               if (obj instanceof User) {
                    HttpSession session = req.getSession();          
                    session.setAttribute("user", (User) obj);
                    con.close();
                    OutilsFormat.addMessage(messages, true, "success", "/devis");
                    
                } else { List<String> errs = (List<String>) obj;
                    OutilsFormat.addMessage(messages, false, "error", errs.get(0));
                    model.addAttribute("cause",obj);
                }
           }catch(Exception e){
               e.printStackTrace();
               OutilsFormat.addMessage(messages, false, "error", HttpStatus.INTERNAL_SERVER_ERROR+"/"+e.getMessage());
           }
           
        }
        out.print(String.join("+", messages));
        return null;
    }
    

    
    @RequestMapping(value = "/user")
    public String loginPageUser(Model model, HttpServletRequest req) {
        return "page/auth/login-user";  
    }
    
    
    
    
    @RequestMapping(value = "/logout",method = RequestMethod.POST)
    public String logout(Model model, HttpServletRequest req) {
        req.getSession().removeAttribute("user");
        return "page/auth/login-user";  
    }
    
    @RequestMapping(value = "/inscrire")
    public String inscrireUser(Model model, HttpServletRequest req) {
        return "page/auth/inscrire-user";
    }
    
    @RequestMapping(value = "/user-inscrire", method = RequestMethod.POST)
    @ResponseBody
    public String inscrireUser(Model model, HttpServletRequest req,HttpServletResponse resp)throws Exception {
        PrintWriter out = resp.getWriter();
        List<String> messages = new ArrayList<String>();

        String mail = (req.getParameter("mail") != null && !req.getParameter("mail").trim().isEmpty()) ? req.getParameter("mail") : null;
        String nom = (req.getParameter("nom") != null && !req.getParameter("nom").trim().isEmpty()) ? req.getParameter("nom") : null;
        String mdp = (req.getParameter("mdp") != null && !req.getParameter("mdp").trim().isEmpty()) ? req.getParameter("mdp") : null;
        String remdp = (req.getParameter("remdp") != null && !req.getParameter("remdp").trim().isEmpty()) ? req.getParameter("remdp") : null;
    
        boolean success = true;

        if (mail == null || !OutilsFormat.isEmailValid(mail)) {
            OutilsFormat.addMessage(messages, false, "errorMail", "Mail Invalide!");
            success = false;
        }
        if (mdp == null) {
            OutilsFormat.addMessage(messages, false, "errorMdp", "Mot de passe Invalide!");
            success = false;
        }
        if (nom == null) {
            OutilsFormat.addMessage(messages, false, "errorNom", "Nom Invalide!");
            success = false;
        }

        if (remdp == null || !remdp.equals(mdp)) {
            OutilsFormat.addMessage(messages, false, "errorRemdp", "Incorrect!");
            success = false;
        }
        if(success){
           User user = new User(nom, mail, mdp);
           Connection con = new ConnectionDB().getConnection("postgres");
           con.setAutoCommit(false);
           GenericDao gen = new GenericDao();
           try{
               gen.save(user, con);
               user = (User) gen.find(user, con).get(0);
               int defaultIdRole = 2;
               if(user.getId() > 0){
                   String query = "insert into userroles (idUser, idRole) values ("+user.getId()+", "+defaultIdRole+")";
                   System.out.println(query);
                   if(!gen.insertQueryGeneral(query, con)) {
                       con.commit();
                       OutilsFormat.addMessage(messages, true, "success", "/user");
                   }else {
                       con.rollback();
                       OutilsFormat.addMessage(messages, false, "error", "votre inscription est échouée!");
                   }
               }
               
               
           }catch(Exception e){
               e.printStackTrace();
               OutilsFormat.addMessage(messages, false, "error", e.getMessage());
           }
        }

        out.print(String.join("+", messages));
        return null;
    }
    



}
