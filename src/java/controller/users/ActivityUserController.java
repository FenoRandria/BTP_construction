/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.users;

import config.OutilsFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author fenor
 */
@Controller
@RequestMapping(value = "")
public class ActivityUserController {
    @RequestMapping(value = "/devis")
    public String listDevisClient(Model model, HttpServletRequest req) {
//        HttpSession session = req.getSession();
//        User user = (User)session.getAttribute("user");
//        String role = "user";
//        if(user == null) return "redirect:/admin";
//        if(OutilsFormat.profileValid(user,role )) 
//        {
            return "page/Client/devis-liste";
//        } else {
//            return "redirect:/user";
//        }
    }
    
    @RequestMapping(value = "/devis-form")
    public String formulaireDevisClient(Model model, HttpServletRequest req) {
//        HttpSession session = req.getSession();
//        User user = (User)session.getAttribute("user");
//        String role = "user";
//        if(user == null) return "redirect:/admin";
//        if(OutilsFormat.profileValid(user,role )) 
//        {
            return "page/Client/devis-formulaire";
//        } else {
//            return "redirect:/user";
//        }
    }
    
    @RequestMapping(value = "/devis-details")
    public String detailsDevisClient(Model model, HttpServletRequest req) {
//        HttpSession session = req.getSession();
//        User user = (User)session.getAttribute("user");
//        String role = "user";
//        if(user == null) return "redirect:/user";
//        if(OutilsFormat.profileValid(user,role ))
//        {
            return "page/Client/devis-details";
//        } else {
//            return "redirect:/user";
//        }
    }
    
    @RequestMapping(value = "/devis-paiement")
    public String paiementDevisClient(Model model, HttpServletRequest req) {
//        HttpSession session = req.getSession();
//        User user = (User)session.getAttribute("user");
//        String role = "user";
//        if(user == null) return "redirect:/user";
//        if(OutilsFormat.profileValid(user,role ))
//        {
            return "page/Client/devis-paiement";
//        } else {
//            return "redirect:/user";
//        }
    }
}
