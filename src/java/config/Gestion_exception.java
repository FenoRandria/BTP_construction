/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package config;

/**
 *
 * @author fenor
 */
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

public class Gestion_exception {
    public static ResponseEntity<Object>generateResponse(String message, HttpStatus status, Object responseObj, String pageRedirection) {
        Map<String, Object> map = new HashMap<String,Object>();
        map.put("message", message);
        map.put("status", status.value());
        map.put("data", responseObj);        
        map.put("page", pageRedirection);
        return new ResponseEntity<>(map,status);
    }
}