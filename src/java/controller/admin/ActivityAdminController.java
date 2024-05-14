/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin;

import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import model.Dashboard;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import service.FileService;
import service.ImportDataCSV;

/**
 *
 * @author fenor
 */
@Controller
@RequestMapping("")
public class ActivityAdminController {
    
    @RequestMapping(value = "/import-data-file")
    public String loginPageAdmin(Model model, HttpServletRequest req) {

        return "page/Admin/importDataCsv";

    }
    
    @RequestMapping(value="/upload-file-data", method=RequestMethod.POST)
    public String importDataFile(Model model, @RequestParam("maisonTravaux") MultipartFile fileMaisonTravaux, @RequestParam("devis") MultipartFile fileDevis ){
       FileService dataService = new FileService();
        if(!fileMaisonTravaux.isEmpty() || !fileDevis.isEmpty()) {
           String maisonTravaux = "D:\\S6\\BTP_construction\\web\\assets\\upload\\"+ fileMaisonTravaux.getOriginalFilename();           
           String devis = "D:\\S6\\BTP_construction\\web\\assets\\upload\\"+ fileDevis.getOriginalFilename();

           
//           System.out.println(dataService.importData(fileMaisonTravaux,false));               
//           System.out.println("**************************************************************************************************************");           
//           System.out.println(dataService.importData(fileDevis,true));



            File destinationFile1 = new File(maisonTravaux);            
            File destinationFile2 = new File(devis);
    
            try{
                
                fileMaisonTravaux.transferTo(destinationFile1);
                fileMaisonTravaux.transferTo(destinationFile2);
                
                ImportDataCSV importa = new ImportDataCSV();
                importa.importDataFromCsv(maisonTravaux,1);            
                importa.importDataFromCsv(devis,2);
                        
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
}
