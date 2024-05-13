/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import annotation.Colonne;
import annotation.NotPris;
import annotation.PrimaryKey;
import annotation.Table;
import connection.ConnectionDB;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Arrays;

/**
 *
 * @author fenor
 */
public class GenericDao {

    private static final String ZERO_STRING = "0";
    private static final String ZERO_FLOAT_STRING = "0.0";

    // =============== start fonction util sur l'insertion de donnée: =============== 
    // =============== Insert Generalised ===============
    public void save(Object object, Connection con) throws Exception {
        boolean shouldCloseConnection = false;
        if (con == null) {
            
            con = new ConnectionDB().getConnection("postgres");
            shouldCloseConnection = true;
        }
        PreparedStatement stmt = null;
        try {
            String query = prepareQueryInsertObject(object);
            System.out.println("-------------------------: query : "+query);
            stmt = con.prepareStatement(query);
            System.out.println(stmt.executeUpdate());
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (shouldCloseConnection) {
                GenericDao.closeAll(con, stmt, null);
            }
        }
    }

    //=============== Insert list object ===============   
    public void saveListObject(Object[] list) throws Exception{
        Connection con=null;
        try {
            con=new ConnectionDB().getConnection("postgres");
            for(int i=0;i<list.length;i++){
                this.save(list[i], con);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if(con!=null){con.close();}
        }
        
    }

    // =============== Preparation request ===============
    public String prepareQueryInsertObject(Object object) throws Exception {
        try {
            String tableName = getTableName(object);
            String columnNames = prepareRequestColumnName(object);
            String values = prepareRequestValue(object);
            return buildInsertQuery(tableName, columnNames, values);
        } catch (Exception ex) {
            throw ex;
        }
    }

    // =============== get table name ===============
    public String getTableName(Object object) {
        Class<?> objectClass = object.getClass();
        Table annotation = objectClass.getDeclaredAnnotation(Table.class);

        if (annotation != null) {
            return annotation.tableName();
        } else {
            return objectClass.getSimpleName();
        }
    }

    // =============== prepare request column name ===============
    public String prepareRequestColumnName(Object object) throws Exception {
        StringBuilder str = new StringBuilder();
        String[] atr = getAttributeName(object);
        for (int i = 0; i < atr.length; i++) {
            if (i < atr.length - 1) {
                str.append(atr[i]).append(",");
            } else {
                str.append(atr[i]);
            }
        }
        return str.toString();
    }
    
    // =============== prepare request all values ===============
    public String prepareRequestValue(Object object) throws Exception {
        StringBuilder result = new StringBuilder();
        List<?> vect = this.getValeur(object);
        try {
            for (int n = 0; n < vect.size(); n++) {
                Object value = vect.get(n);
                if (value instanceof Number) {
                    result.append(value);
                } else {
                    result.append("'").append(escapeStringValue(value.toString())).append("'");
                }
                if (n < vect.size() - 1) {
                    result.append(",");
                }
            }
        } catch (Exception ex) {
            System.out.println("Error in prepareRequestValue(): " + ex.getMessage());
            throw ex;
        }
        return result.toString();
    }

    // =============== get valeur dans (getters) ===============
    public List<?> getValeur(Object object) throws Exception {
        List result = new ArrayList();
        List<Method> fx = getGetterSetterMethods(object);
        for (Method method : fx) {
            try {
                Object value = method.invoke(object);
                result.add(value);
            } catch (Exception ignored) {
                throw ignored;
            }
        }
        return result;
    }

    // =============== query insert ===============
    private String buildInsertQuery(String tableName, String columnNames, String values) {
        return "INSERT INTO " + tableName + "(" + columnNames + ") VALUES (" + values + ")";
    }

    // =============== get name attribute ===============
    public String[] getAttributeName(Object object) throws Exception {
        List<String> names = new ArrayList<>();
        List<Method> methods = getGetterSetterMethods(object);
        for (Method method : methods) {
            String methodName = method.getName();
            if (methodName.startsWith("get")) {
                String attributeName = methodName.substring(3);
                Field field = object.getClass().getDeclaredField(toMinuscule(attributeName));
                Colonne annotation = field.getAnnotation(Colonne.class);
                String columnName = (annotation == null) ? toMinuscule(attributeName) : annotation.colonneName();
                names.add(columnName);
            }
        }
        return names.toArray(new String[0]);
    }

    // =============== get method (setters and getters) in object ===============
    public List<Method> getGetterSetterMethods(Object object) throws Exception {
        List<Method> methods = new ArrayList<>();
        String[] methodNames = getGetterSetterMethodNames(object, "get");
        for (String methodName : methodNames) {
            Method method = object.getClass().getDeclaredMethod(methodName);
            Object value = method.invoke(object);
            if (value != null && !"".equals(value.toString()) && testObject(value)
                    && !ZERO_STRING.equals(value.toString()) && !ZERO_FLOAT_STRING.equals(value.toString())) {
                methods.add(method);
            }
        }
        return methods;
    }
    

    // =============== get method names (setters and getters)in object ===============
    public String[] getGetterSetterMethodNames(Object object, String prefix) {
        List<String[]> attributeNames = getAttributeNames(object);
        String[] methodNames = new String[attributeNames.size()];
        for (int i = 0; i < attributeNames.size(); i++) {
            String[] attribute = attributeNames.get(i);
            methodNames[i] = prefix + toMajuscule(attribute[0]);
        }
        return methodNames;
    }

    // =============== end fonction util sur l'insertion de donnée: ===============

    // =============== start fonction util sur la mise à jour de donnée: ===============
    
    // =============== update Generalised ===============
    public void update(Object object, Connection con) throws Exception {
        boolean shouldCloseConnection = false;
        if (con == null) {
            con = new ConnectionDB().getConnection("postgres");
            shouldCloseConnection = true;
        }
        PreparedStatement stmt = null;
        try {
            String query = prepareQueryUpdate(object);
            stmt = con.prepareStatement(query);
            Method primaryKeyMethod = this.getMethodPrimaryKey(object);
            Object primaryKeyValue = primaryKeyMethod.invoke(object);
            stmt.setObject(1, primaryKeyValue);
            System.out.println(query);
            stmt.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (shouldCloseConnection) {
                GenericDao.closeAll(con, stmt, null);
            }
        }
    }

    // =============== prepare query for update generalised ===============
    public String prepareQueryUpdate(Object object) throws Exception {
        Method primaryKeyMethod = this.getMethodPrimaryKey(object);
        String primaryKeyColumnName = this.getAttributeNamePrimaryKey(object, primaryKeyMethod);
        String tableName = this.getTableName(object);
        String valueUpdate = this.prepareValueUpdate(object);
        
        StringBuilder result = new StringBuilder();
        result.append("UPDATE ")
              .append(tableName)
              .append(" SET ")
              .append(valueUpdate)
              .append(" WHERE ")
              .append(primaryKeyColumnName)
              .append("=?");
    
        return result.toString();
    }

    // =============== get method recuperer PRIMARY KEY ===============  
    public Method getMethodPrimaryKey(Object object) throws Exception {
        for (Field field : object.getClass().getDeclaredFields()) {
            PrimaryKey primaryKeyAnnotation = field.getAnnotation(PrimaryKey.class);
            if (primaryKeyAnnotation != null) {
                String fieldName = field.getName();
                String methodName = "get" + toMajuscule(fieldName);
                try {
                    return object.getClass().getDeclaredMethod(methodName);
                } catch (NoSuchMethodException ex) {
                    throw new Exception("Error finding getter method for primary key: " + fieldName, ex);
                }
            }
        }
        return null;
    }

    // ==================   GET Attribute ID PRIMARY KEY ========================================
    public String getAttributeNamePrimaryKey(Object object, Method method) throws Exception {
        String attributeName = "";
        try {
            String methodName = method.getName();
            String attributeNameFromMethod = toMinuscule(deleteGet(methodName));
            Field field = object.getClass().getDeclaredField(attributeNameFromMethod);
            Colonne colonneAnnotation = field.getAnnotation(Colonne.class);
            attributeName = (colonneAnnotation != null) ? colonneAnnotation.colonneName() : attributeNameFromMethod;
        } catch (Exception ex) {
            throw new Exception("Error getting attribute name for primary key", ex);
        }
        return attributeName;
    }

    // =============== prepare UPDATE string ===============
    public String prepareValueUpdate(Object object) throws Exception {
        List<?> values = this.getValeur(object);
        String[] attributeNames = this.getAttributeName(object);
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < attributeNames.length; i++) {
            String attributeName = attributeNames[i];
            Object value = values.get(i);
            result.append(attributeName).append("='");
            result.append(value instanceof String ? escapeStringValue((String) value) : value);
            result.append("'");
            if (i < attributeNames.length - 1) {
                result.append(",");
            }
        }
        return result.toString();
    }




    
    // =============== end fonction util sur la mise à jour de donnée: ===============
    
    // =============== start another method util for generalization: ===============
    
    // =============== close Valeur ===============
    public static void closeAll(Connection con, PreparedStatement stmt, ResultSet res) throws SQLException {
        if (res != null) {
            res.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (con != null) {
            con.close();
        }
    }

    // =============== preparation colonne name ===============
    public String prepareColumnNames(Object object) throws Exception {
        String[] attributeNames = this.getAttributeName(object);
        StringBuilder columnNamesBuilder = new StringBuilder();
        for (int i = 0; i < attributeNames.length; i++) {
            columnNamesBuilder.append(attributeNames[i]);
            if (i < attributeNames.length - 1) {
                columnNamesBuilder.append(",");
            }
        }
        return columnNamesBuilder.toString();
    }
    
    // =============== suppression "get" colonne name ===============
    public String deleteGet(String str) {
        if (str.length() < 4) {
            throw new IllegalArgumentException("Input string must be at least 4 characters long");
        }
        StringBuilder result = new StringBuilder(str.length() - 3);
        for (int i = 3; i < str.length(); i++) {
            result.append(str.charAt(i));
        }
        return result.toString();
    }
    
    // =============== convert into miniscule ===============
    public String toMinuscule(String str) {
        if (str.isEmpty()) {
            return str;
        }
        StringBuilder result = new StringBuilder(str);
        result.setCharAt(0, Character.toLowerCase(result.charAt(0)));
        return result.toString();
    }

    // =============== convert into majuscule ===============
    public static String toMajuscule(String str) {
        if (str.isEmpty()) {
            return str;
        }
        StringBuilder result = new StringBuilder(str);
        result.setCharAt(0, Character.toUpperCase(result.charAt(0)));
        return result.toString();
    }

    // =============== test object ===============
    public boolean testObject(Object obj) {
        Set<Class<?>> supportedTypes = new HashSet<>();
        supportedTypes.add(String.class);
        supportedTypes.add(Integer.class);
        supportedTypes.add(Double.class);
        supportedTypes.add(Float.class);
        supportedTypes.add(BigDecimal.class);
        supportedTypes.add(Date.class);
        supportedTypes.add(Timestamp.class);
        supportedTypes.add(Time.class);
        supportedTypes.add(Boolean.class);
        return supportedTypes.contains(obj.getClass());
    }

    // =============== get all attribute names in object ===============
    public List<String[]> getAttributeNames(Object object) {

        List<String[]> attributeNames = new ArrayList<>();
        Field[] fields = object.getClass().getDeclaredFields();
        int nbrAttribut = GenericDao.getNbrAttributNotAnnotation(object.getClass());
        for (Field field : fields) {
            if (attributeNames.size() >= nbrAttribut) {
                break;
            }
            if (field.getAnnotation(NotPris.class) == null) {
                String[] attributeName = new String[2];
                attributeName[0] = field.getName();
                attributeName[1] = (field.getAnnotation(Colonne.class) != null && field.getAnnotation(Colonne.class).colonneName() != "") ? field.getAnnotation(Colonne.class).colonneName() : field.getName();
                attributeNames.add(attributeName);
            }
        }
        return attributeNames;
    }

    // =============== get nombre attribut annotation noun annotation ===============
    public static int getNbrAttributNotAnnotation(Class<?> cl) {
        int nbr = 0;
        Field[] fields = cl.getDeclaredFields();
        for (Field field : fields) {
            if (field.getAnnotation(NotPris.class) == null) {
                nbr++;
            }
        }
        return nbr;
    }

    // =============== GET name method (getters and setters) ===============
    public String[] getNameMethod(Object object) throws Exception {
        List<Method> methods = getGetterSetterMethods(object);
        String[] names = new String[methods.size()];
        for (int i = 0; i < methods.size(); i++) {
            Method method = methods.get(i);
            if (method != null) {
                names[i] = method.getName();
            }
        }
        return names;
    }

    // =============== escape string sql ===============
    private String escapeStringValue(String value) {
        return value.replace("'", "''");
    }
    
    // =============== get method setters in object ===============
    public Method[] getAllSetters(Object object, String prefixMethod) throws NoSuchMethodException {
        String[] nomFX = this.getGetterSetterMethodNames(object, prefixMethod);
        Method[] fonction = new Method[nomFX.length];
        for (int i = 0; i < nomFX.length; i++) {
            try {
                fonction[i] = this.getClass().getDeclaredMethod(nomFX[i]);
            } catch (NoSuchMethodException ex) {
                continue;
            }
        }
        return fonction;
    }

    // =============== prepare requete for select generalized ===============
    public String prepareQuerySelect(Object object) throws Exception {
        String tableName = this.getTableName(object);
        String queryWithCriteria = prepareQueryWithCriteria(object);
        return "SELECT * FROM " + tableName + " WHERE 1=1" + queryWithCriteria;
    }

    // =============== Requete Select with criteria ===============
    public String prepareQueryWithCriteria(Object object) throws Exception {
        StringBuilder str = new StringBuilder();
        String[] attributeNames = this.getAttributeName(object);
        List<?> values = this.getValeur(object);
        for (int i = 0; i < values.size(); i++) {
            if(values.get(i).toString() == null || values.get(i).toString() == ""){
                str.append(" AND ").append(1).append("=").append(1);
            }else{
                str.append(" AND ").append(attributeNames[i]).append("='").append(escapeStringValue(values.get(i).toString())).append("'");
            }
        }
        return str.toString();
    }

    // =============== get type of the attribute or Field ===============
    public Class<?>[] getClassField(Object object) {
        Class[] classField=null;
        try {
            classField = new Class[this.getAttributeName(object).length];
        } catch (Exception ex) {
            ex.printStackTrace();
            //Logger.getLogger(GeneriqueDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        for (int n = 0; n < classField.length; n++) {
            classField[n] = object.getClass().getDeclaredFields()[n].getDeclaringClass();
        }
        return classField;
    }

    // =============== create object via resultSet ===============
    public ArrayList<Object> createObjects(Object object, ResultSet res) throws Exception {
        ArrayList<Object> objectsList = new ArrayList<>();
        String[] nameMethodSetters = this.getGetterSetterMethodNames(object, "set");
        String[] nameMethodGetters = this.getGetterSetterMethodNames(object, "get");
        List<String[]> attributeNames = this.getAttributeNames(object);
    
        while (res.next()) {
            Object obj = object.getClass().getDeclaredConstructor().newInstance();
            for (int i = 0; i < nameMethodSetters.length; i++) {
                Class<?> returnType = object.getClass().getDeclaredMethod(nameMethodGetters[i]).getReturnType();
                String attributeName = attributeNames.get(i)[1];
                Object attributeValue = null;
    
                if (returnType.equals(String.class)) {
                    attributeValue = res.getString(attributeName);
                } else if (returnType.equals(Integer.class) || returnType.equals(int.class)) {
                    attributeValue = res.getInt(attributeName);
                } else if (returnType.equals(Double.class) || returnType.equals(double.class)) {
                    attributeValue = res.getDouble(attributeName);
                } else if (returnType.equals(Float.class) || returnType.equals(float.class)) {
                    attributeValue = res.getFloat(attributeName);
                } else if (returnType.equals(BigDecimal.class)) {
                    attributeValue = res.getBigDecimal(attributeName);
                } else if (returnType.equals(Date.class)) {
                    attributeValue = res.getDate(attributeName);
                } else if (returnType.equals(Timestamp.class)) {
                    attributeValue = res.getTimestamp(attributeName);
                } else if (returnType.equals(Time.class)) {
                    attributeValue = res.getTime(attributeName);
                } else if (returnType.equals(Boolean.class) || returnType.equals(boolean.class)) {
                    attributeValue = res.getBoolean(attributeName);
                }
//                System.out.println(nameMethodSetters[i]+" type: "+ returnType + " attributeName: "+attributeName + " value: "+attributeValue);
                
                object.getClass().getDeclaredMethod(nameMethodSetters[i], returnType).invoke(obj, attributeValue);
            }
            objectsList.add(obj);
        }
        return objectsList;
    }

    // ===============
    public ArrayList<?> find(Object object, Connection con) throws NoSuchMethodException, Exception {
        ArrayList<?> vect = new ArrayList();
        boolean connectionWasNull = (con == null);
        if (connectionWasNull) {
            con = new ConnectionDB().getConnection("postgres");
        }
        PreparedStatement stmt = null;
        ResultSet res = null;
        try {
            String req = this.prepareQuerySelect(object);
            System.out.println(req);
            stmt = con.prepareStatement(req);
            res = stmt.executeQuery();
            vect = this.createObjects(object, res);
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (connectionWasNull) {
                GenericDao.closeAll(con, stmt, res);
            }
        }
        return vect;
    }

    // =============== Execute ALL REQUETE ===============
    
    public ArrayList<?> executeQueryGeneral(Object obj,String req,Connection con) throws Exception{
        PreparedStatement stmt=null;
        ResultSet res=null;
        ArrayList<?> result=null;
        if(con==null){
            try{
                con = new ConnectionDB().getConnection("postgres");
            }catch(Exception ex){throw ex;}
        }try{
            stmt=con.prepareStatement(req);
            res=stmt.executeQuery();
            result=this.createObjects(obj,res);
            
            return result;
        }catch(Exception e){throw e;}
    }
//    ============================================= insertion via query return boolean =====================================
        public boolean insertQueryGeneral(String req, Connection con) throws Exception{
        PreparedStatement stmt=null;
        boolean test = false;
        if(con==null){
            try{
                con = new ConnectionDB().getConnection("postgres");
            }catch(Exception ex){throw ex;}
        }try{
            stmt=con.prepareStatement(req);
            test = stmt.execute();
            System.out.println("insert ok : "+test);
        }catch(Exception e){throw e;}
        return test;
    }

    ///===============================DELETE GENERALISER =====================================================
    
    public int delete(Object object, Connection con) throws Exception {
        int rowsDeleted = 0;
        boolean shouldCloseConnection = false;
        PreparedStatement stmt = null;
        try {
            if (con == null) {
                con = new ConnectionDB().getConnection("postgres");
                shouldCloseConnection = true;
            }
            String str = this.prepareQueryDelete(object);
            stmt = con.prepareStatement(str);
            Method primaryKeyMethod = this.getMethodPrimaryKey(object);
            Object primaryKeyValue = primaryKeyMethod.invoke(object);
            if (primaryKeyValue instanceof Integer) {
                stmt.setInt(1, (Integer) primaryKeyValue);
            } else if (primaryKeyValue instanceof String) {
                stmt.setString(1, (String) primaryKeyValue);
            } else {
                throw new Exception("type of the primairy key is not manage: " + primaryKeyValue.getClass().getSimpleName());
            }
            rowsDeleted = stmt.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (shouldCloseConnection) {
                GenericDao.closeAll(con, stmt, null);
            }
        }
        return rowsDeleted;
    }
    

    ///==================== REQUETE UPDATE Delete ===============================================================
    
    public String prepareQueryDelete(Object object) throws Exception {
        String tableName = this.getTableName(object);
        String primaryKeyColumnName = this.getAttributeNamePrimaryKey(object, this.getMethodPrimaryKey(object));
        return "DELETE FROM " + tableName + " WHERE " + primaryKeyColumnName + " = ?";
    }
    
    
    // =============== end another method util for generalization: ===============

    
// ========================== Generalised data for excel ou csv via table ou view ===============================================================

public List<List<String>> tableToListString(String nameTable, Connection con) throws Exception {
    PreparedStatement stmt=null;
    ResultSet resultSet=null;
   
    List<List<String>> data = new ArrayList<>();
    if(con==null) {
        try {
            con = new ConnectionDB().getConnection("postgres");
        }catch(Exception ex){throw ex;}
    } try {
        stmt = con.prepareStatement("select * from " + nameTable);
        System.out.println("select * from " + nameTable);
        resultSet = stmt.executeQuery();
        
        ResultSetMetaData metaData = resultSet.getMetaData();
        int columnCount = metaData.getColumnCount();

        System.out.println("countline data ------- "+columnCount);
        while(resultSet.next()){
            // resultSet.getObject(columnCount);
            List<String> rowData = new ArrayList<>();
            for(int i=1;i<= columnCount;i++) {
                rowData.add(resultSet.getObject(i).toString());
                System.out.println(resultSet.getObject(i).toString());
            }
            data.add(rowData);
        }
        return data;
    }catch(Exception e){throw e;}
}
//    =========================================================================================================================================

   public boolean saveListIntoBDD(List<List<String>> dataList, String tableName, Connection con) throws Exception {
        ResultSet resultSet=null;
        ResultSetMetaData metaData = null;

        if(con==null){
            try{
                con = new ConnectionDB().getConnection("postgres");
            }catch(Exception ex){throw ex;}
        }
       
        resultSet = con.getMetaData().getColumns(null, null, tableName, null);
        
        StringBuilder queryBuilder = new StringBuilder("INSERT INTO ").append(tableName).append(" (");
        
        Statement statement = con.createStatement();
        resultSet = statement.executeQuery("SELECT * FROM " + tableName + " WHERE 1=0"); // WHERE 1=0 pour éviter de récupérer les données, juste les métadonnées
        metaData = resultSet.getMetaData();
        
        int columnCount = metaData.getColumnCount();
        System.out.println("fonction save: "+columnCount);
        // prepare anle colonne name
        for(int i = 1; i<= columnCount; i++) {
           queryBuilder.append(metaData.getColumnName(i));
            if (i < columnCount) {
                queryBuilder.append(", ");
            }
        }
        

        // prepara anle data value 
        queryBuilder.append(") VALUES ");
        for(int g = 0; g < dataList.size(); g++ ) {
            if (g == dataList.size()-1) {

                queryBuilder.append("(");
                for (int i = 1; i <= columnCount; i++) {
                    // queryBuilder.append("?");
                    queryBuilder.append("'"+dataList.get(g).get(i-1)+"'");
                    if (i < columnCount) {
                        queryBuilder.append(", ");
                    }
                }
                queryBuilder.append(")");

            } else {
                queryBuilder.append("(");
                for (int i = 1; i <= columnCount; i++) {
                    queryBuilder.append("'"+dataList.get(g).get(i-1)+"'");
                    // queryBuilder.append("?");
                    if (i < columnCount) {
                        queryBuilder.append(", ");
                    }
                }
                queryBuilder.append("),");
            }
        }
        System.out.println("sql :"+queryBuilder.toString());
        
            
        return statement.execute(queryBuilder.toString());
        
   }
}


