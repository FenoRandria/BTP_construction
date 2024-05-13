/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin;

import config.OutilsFormat;
import dao.GenericDao;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.Employer;
import model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author fenor
 */
@RequestMapping("")
@Controller
public class EmployeController {
    @RequestMapping("/gestion-employer")
    public String index(Model model, HttpServletRequest req)
    {
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
        String role = "admin";
        if(OutilsFormat.profileValid(user,role)) 
        {
            return this.listEmployer(model,req);
        } else {
            return "redirect:/admin";
        }
    }
    
    @RequestMapping(value = "/insert-employer", method = RequestMethod.POST)
    public String insertPlace(Model model, HttpServletRequest req)
    {
        Employer place = new Employer();
        GenericDao gen = new GenericDao();
        try{
            gen.save(place, null);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        return index(model,req);
    }
    
    @RequestMapping("/stat-parking")
    public String chart(Model model, HttpServletRequest req)
    {
        return "page/Admin/chart";
    }
    
    @RequestMapping("/list-employer")
    public String listEmployer(Model model, HttpServletRequest req)
    {
        try{
            ArrayList<Employer> employers =(ArrayList<Employer>) new GenericDao().find(new Employer(), null);
            model.addAttribute("dataEmployer", employers);
        }catch(Exception e) {
            e.printStackTrace();
            model.addAttribute("cause", e.getMessage());
        }
        return "page/Admin/list-employer";
    }
    
    @RequestMapping("/ajout-employer")
    public String formulaire(Model model, HttpServletRequest req)
    {
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user");
        String role = "admin";
        if(user == null) return "redirect:/admin";
        if(OutilsFormat.profileValid(user,role )) 
        {
            return "page/Admin/formulaire-employer";
        } else {
            return "redirect:/admin";
        }
    }
}