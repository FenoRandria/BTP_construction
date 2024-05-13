/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.file;

import java.io.File;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author fenor
 */
@Controller
@RequestMapping("")
public class FileController {
    @RequestMapping(value="/upload-image", method=RequestMethod.POST)
    public String fileUpload(Model model, @RequestParam("sary") MultipartFile file ){
        if(!file.isEmpty()) {
           String filePath = "D:\\S6\\BTP_construction\\web\\assets\\upload\\"+ file.getOriginalFilename();
            System.out.print(filePath);
            File destinationFile = new File(filePath);
            try{
                file.transferTo(destinationFile);
            }catch(Exception e){
                e.printStackTrace();
                return "redirect:/";
            }
        }
        return "redirect:/user";
    }
}
