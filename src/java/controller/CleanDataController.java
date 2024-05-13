/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.GenericDao;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author fenor
 */
@Controller
@RequestMapping("")
public class CleanDataController {
    @RequestMapping(value = "/clean", method = RequestMethod.POST)
    public void clean() {
        String requete = "TRUNCATE userroles,test,users,roles CASCADE";
        try {
            new GenericDao().insertQueryGeneral(requete, null);
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
