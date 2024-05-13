<%-- 
    Document   : devis-details
    Created on : May 13, 2024, 9:43:05 AM
    Author     : fenor
--%>

<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.V_DetailDevisMaison"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<% 
    List<V_DetailDevisMaison> detailsdevis = (List<V_DetailDevisMaison>) request.getAttribute("detailsdevis");     
    
%>
 <% 
    DecimalFormat formatNumber = new DecimalFormat("#,##0.00"); 
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <link rel="stylesheet" href="../../assets/css/list.css"> -->
    <title>Devis-Details</title>
    <style>
        body {
            font-family: 'Urbanist';
            margin: 20px;
        }

        h2 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        tfoot td {
            font-weight: bold;
        }
        .mini-titre{
            font-weight: 700;
        }
    </style>
</head>
<body>
    <h2>Devis References : <% 
            if (detailsdevis.get(0).getIdDevis() > 0) {
                out.print(detailsdevis.get(0).getIdDevis());
            } 
        %>

    </h2>
    <table>
        <thead>
            <tr>
                <th>N°</th>
                <th>DESIGNATIONS</th>
                <th>U</th>
                <th>Q</th>
                <th>PU</th>
                <th>TOTAL</th>
            </tr>
        </thead>
        <tbody>
            <!-- -------------Donnee---------- -->
            <%  
                double total = 0.0;
                if(detailsdevis!=null) { %>
                <% for(int i = 0; i< detailsdevis.size(); i++) { %>
                    <% V_DetailDevisMaison details = (V_DetailDevisMaison) detailsdevis.get(i); 
                        total = details.getMontant();
                    %>
                        <tr>
                            <td><%= details.getIdDetail() %></td>
                            <td><%= details.getDescriptions() %></td>
                            <td><%= details.getUnite() %></td>
                            <td><%= formatNumber.format(details.getQuantite()) %></td>
                            <td><%= formatNumber.format(details.getPrixUnitaire()) %></td>
                            <td><%= formatNumber.format(details.getSousmontant()) %></td>
                        </tr>
                <% } %>
            <% } %>
            <!-- -------------Donnee---------- -->
            
            <tr></tr>
            <td colspan="5" style="text-align:right;"  class="mini-titre">TOTAL</td>
            <td  class="mini-titre"><%= formatNumber.format(total) %></td>
        </tr>
        </tbody>
    </table>
    <button id="but" onclick="exportPDF()">export to pdf</button>
    <script>
        function exportPDF()
        {
            document.getElementById("but").hidden = true;
            window.print();
            document.getElementById("but").hidden = false;
        }
    </script>
</body>
</html>