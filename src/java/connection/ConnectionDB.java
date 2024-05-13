/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author fenor
 */
public class ConnectionDB {
        public Connection getConnection(String typedata) throws Exception{
	Connection con=null;
	try{
	    if(typedata.compareToIgnoreCase("Oracle")==0){
	        Class.forName("oracle.jdbc.driver.OracleDriver");
	        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
                System.out.println("connected");
            }
            else if (typedata.compareToIgnoreCase("Postgres")==0){
            	Class.forName("org.postgresql.Driver");
                con= DriverManager.getConnection("jdbc:postgresql://localhost:5432/btp_construction","postgres", "feno12");
                //System.out.println("cvsdc");
            }
	}catch(ClassNotFoundException | SQLException e){ 
            System.out.println(e.getMessage());
            throw e;
        }
	return con;
    }
}
