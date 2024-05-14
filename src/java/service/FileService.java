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
import connection.ConnectionDB;
import dao.GenericDao;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileService {

    // Importer les données
    public boolean importData(File file) {
        FileInputStream inputStream = null;
        Workbook workbook = null;
        boolean success = false; // Définir initialement sur false
    
        try {
            inputStream = new FileInputStream(file);
            workbook = new XSSFWorkbook(inputStream);
    
            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> iterator = sheet.iterator();
    
            while (iterator.hasNext()) {
                Row currentRow = iterator.next();
                Iterator<Cell> cellIterator = currentRow.iterator();
                List<String> rowData = new ArrayList<>();
    
                while (cellIterator.hasNext()) {
                    Cell currentCell = cellIterator.next();
                    rowData.add(currentCell.getStringCellValue());
                    System.out.println(currentCell.getStringCellValue());
                }
    
                // Insérer les données dans la base de données
                // Ici, vous inséreriez les données dans votre base de données
                // Utilisez rowData pour insérer les données individuelles dans chaque ligne
            }
    
            success = true; // Mettre à true si l'importation est réussie
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (workbook != null) {
                    workbook.close();
                }
                if (inputStream != null) {
                    inputStream.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    
        return success;
    }
    

//    // importer les données avec multipartfile
    public boolean importDataExcel(MultipartFile multipartFile) {
        boolean success = false;
        Workbook workbook = null;
        try {
            // Créez un fichier temporaire
            File tempFile = File.createTempFile("temp", null);
            // Copiez les données du MultipartFile dans le fichier temporaire
            FileCopyUtils.copy(multipartFile.getInputStream(), new FileOutputStream(tempFile));

            // Utilisez le fichier temporaire pour importer les données
            FileInputStream inputStream = new FileInputStream(tempFile);
            workbook = new XSSFWorkbook(inputStream);

            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> iterator = sheet.iterator();
            
            // recuparation data en list list
            List<List<String>> dataB = new ArrayList<>();
            
            while (iterator.hasNext()) {
                Row currentRow = iterator.next();
                Iterator<Cell> cellIterator = currentRow.iterator();
                List<String> rowData = new ArrayList<>();

                while (cellIterator.hasNext()) {
                    Cell currentCell = cellIterator.next();
                    rowData.add(currentCell.getStringCellValue());
                    System.out.println(currentCell.getStringCellValue());
                }
                dataB.add(rowData);
                // Insérer les données dans la base de données
                // Ici, vous inséreriez les données dans votre base de données
                // Utilisez rowData pour insérer les données individuelles dans chaque ligne
            }
            
            success = true;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (workbook != null) {
                    workbook.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return success;
    }

    public boolean importData(MultipartFile multipartFile, boolean isDevis) 
    {
        boolean success = false;
        String extension = this.getFileExtension(multipartFile.getOriginalFilename());
        System.out.println(extension);
        if(extension.equals("csv")) {
            BufferedReader reader = null;
            try {
                // Créez un fichier temporaire
                File tempFile = File.createTempFile("temp", null);
                // Copiez les données du MultipartFile dans le fichier temporaire
                FileCopyUtils.copy(multipartFile.getInputStream(), new FileOutputStream(tempFile));

                // Utilisez le fichier temporaire pour importer les données
                reader = new BufferedReader(new FileReader(tempFile));
                String line;

                // recuparation data en list list
                List<List<String>> dataB = new ArrayList<>();
                GenericDao gen = new GenericDao();
                Connection con = new ConnectionDB().getConnection("postgres");
                String maison_travaux = "Import_maison_travaux";                    
                String import_devis = "Import_devis";
                
                while ((line = reader.readLine()) != null) {
                    
                    // Séparez chaque ligne en valeurs individuelles en utilisant une virgule comme séparateur
                    String[] values = line.split(",");
                    line.replace("%", "");  

                    System.out.println("-- ligne -- : "+line); 


                    List<String> rowData = Arrays.asList(values);
                    System.out.println(rowData);
                   
                    
                            
                    dataB.add(rowData);
                    
                    
                }
                if(isDevis) {
                        gen.saveListIntoBDD(dataB, import_devis, con);
                    }
                gen.saveListIntoBDD(dataB, maison_travaux, con);
                success = true;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (reader != null) {
                        reader.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } 
        else if(extension.equals("xlsx")){
            success = this.importDataExcel(multipartFile);
        }
        return success;
    }

    
    // Exporter les données
    public boolean exportData(List<List<String>> data, String fileName) throws Exception {
        Workbook workbook = null;
        FileOutputStream outputStream = null;
        boolean success = false;
    
        try {
            workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Clients");

            int rowNum = 0;
            for (List<String> rowData : data) {
                Row row = sheet.createRow(rowNum++);
                int colNum = 0;
                for (String cellData : rowData) {
                    Cell cell = row.createCell(colNum++);
                    cell.setCellValue(cellData);
                }
            }
    
            outputStream = new FileOutputStream(fileName);
            workbook.write(outputStream);
            success = true;
        } catch (IOException e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                if (workbook != null) {
                    workbook.close();
                }
                if (outputStream != null) {
                    outputStream.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
                throw e;
            }
        }
    
        return success;
    }
    
//    get file extension 
    public String getFileExtension(String filename) {
        if (filename == null) {
            return null;
        }
        int lastDotIndex = filename.lastIndexOf('.');
        if (lastDotIndex == -1) {
            return ""; // Aucune extension trouvée
        }
        return filename.substring(lastDotIndex + 1);
    }
    
//   test valide ligne en csv ou excel
    private boolean isValidLine(String line) {
        String regex = "[a-zA-Z0-9,]*";
        Pattern pattern = Pattern.compile(regex);
        return pattern.matcher(line).matches();
    }


}