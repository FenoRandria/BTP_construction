/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

/**
 *
 * @author fenor
 */
public class ServiceSearchAvanced {
    
    public String querySearchByFilter(String critere1, String critere2, String dateDebut, String dateFin, double valeurMin, double valeurMax ) {
        StringBuilder sqlQuery = new StringBuilder("SELECT * FROM VotreTable WHERE 1=1 ");
        
// ================= critere normal comme type ou categorie ====================    
        if (critere1 != null && !critere1.trim().isEmpty()) {
            sqlQuery.append("AND critere1 = '").append(critere1).append("' ");
        }

        if (critere2 != null && !critere2.trim().isEmpty()) {
            sqlQuery.append("AND critere2 = '").append(critere2).append("' ");
        }
        
// ================= filtre a interval date ====================================        
        if (critere2 != null && !critere2.trim().isEmpty()) {
            sqlQuery.append("AND daty >= '").append(dateDebut).append("' ");
        }
        
        if (critere2 != null && !critere2.trim().isEmpty()) {
            sqlQuery.append("AND daty <= '").append(dateFin).append("' ");
        } 
        return sqlQuery.toString();
    }
}
