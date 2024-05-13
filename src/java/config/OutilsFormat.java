/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package config;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author fenor
 */
public class OutilsFormat {
    public static String formatNombre(double nombre) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator(' ');
        DecimalFormat formatNumber;
        formatNumber = new DecimalFormat("#,##0.00", symbols);
        return formatNumber.format(nombre);
    }
    
    public static boolean isEmailValid(String email) {
        // Expression régulière pour vérifier le format de l'e-mail
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        // Créer un pattern avec l'expression régulière
        Pattern pattern = Pattern.compile(emailRegex);
        // Créer un Matcher pour l'e-mail donné
        Matcher matcher = pattern.matcher(email);
        // Vérifier si l'e-mail correspond au pattern
        return matcher.matches();
    }
    
    public static boolean profileValid(User user, String rolename) 
    {
        if(user == null){
            return false;
        }
        String admin = "Admin";
        String users = "User";
        System.out.println("id user: "+user.getId());    
        System.out.println("role user: "+"role: "+user.getRoles());
         
        if(user != null && user.getId() > 0) 
        {
            System.out.println("user: --------> "+user);
            if(rolename.equalsIgnoreCase(admin) && user.getRoles().get(0).getRolename().equalsIgnoreCase(rolename)) 
            {
                return true;
            } 
            else if(rolename.equalsIgnoreCase(users) && user.getRoles().get(0).getRolename().equalsIgnoreCase(rolename))
            {
                return true;
            }
        }
        return false;
    }
    
    public static void addMessage(List<String> messages, boolean success, String type, String message) {
    if (success) {
        messages.add("success:" + message);
    } else {
        messages.add(type + ":" + message);
    }
}

}
