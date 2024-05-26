<%-- 
    Document   : devis-details
    Created on : May 13, 2024, 9:43:05 AM
    Author     : fenor
--%>

<%@page import="model.Paiement"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.V_DetailDevisMaison"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@page pageEncoding="UTF-8" %>
<% 
    List<V_DetailDevisMaison> detailsdevis = (List<V_DetailDevisMaison>) request.getAttribute("detailsdevis");     
    List<Paiement> paiements = (List<Paiement>) request.getAttribute("paiements");
%>
 <% 
    DecimalFormat formatNumber = new DecimalFormat("#,##0.00"); 
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
%>
<!DOCTYPE html>
<html id="pdf" lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="${pageContext.request.contextPath}/assets/js/html2pdf.bundle.min.js" referrerpolicy="no-referrer"></script>
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
        #but{
            padding: 20px;
            margin: 20px 0px;
            background: #008289;
            color: white;
            border: none;
            font-size: 1rem;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div >
        <h2>Devis References : <% 
                if (detailsdevis.get(0).getIdDevis() > 0) {
                    out.print(detailsdevis.get(0).getIdDevis());
                } 
            %>

        </h2>
        <style>
            .right{
            text-align: right;
            }
            .left{
                text-align: left;
            }
            .center{
                text-align: center;
            }
        </style>
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
                                <td class="left"><%= details.getDescriptions() %></td>
                                <td class="center"><%= details.getUnite() %></td>
                                <td class="right"><%= formatNumber.format(details.getQuantite()) %></td>
                                <td class="right"><%= formatNumber.format(details.getPrixUnitaire()) %></td>
                                <td class="right"><%= formatNumber.format(details.getSousmontant()) %></td>
                            </tr>
                    <% } %>
                <% } %>
                <!-- -------------Donnee---------- -->

                <tr></tr>
                <td colspan="5" style="text-align:right;"  class="mini-titre">TOTAL</td>
                <td  class="mini-titre right"><%= formatNumber.format(total) %></td>
            </tr>
            </tbody>
        </table>
        <h1>Paiement</h1>
        <table>
            <thead>
                <tr>
                    <th>Devis</th>
                    <th>Montant</th>
                    <th>Date paiement</th>
                </tr>
            </thead>
            <tbody>
                <!-- -------------Donnee---------- -->
                <%  
                    double totalp = 0;
                    if(paiements!=null) { %>
                    <% for(int i = 0; i< paiements.size(); i++) { %>
                        <% Paiement paiement = (Paiement) paiements.get(i); 
                            totalp = totalp + paiement.getMontant();
                        %>

                        <tr>
                            <td><%= paiement.getIdDevis() %></td>
                            <td class="right"><%= dateFormat.format(paiement.getDatePaiement()) %></td>
                            <td class="right"><%= formatNumber.format(paiement.getMontant()) %></td>
                        </tr>

                    <% } %>
                <% } %>
                <!-- -------------Donnee---------- -->

                <tr>
                    <td colspan="2" style="text-align:right;"  class="mini-titre">TOTALY</td>
                    <td  class="mini-titre right"><%= formatNumber.format(totalp) %></td>
                </tr>

            </tr>
            </tbody>
        </table>   
    </div>
    <button id="but" onclick="exportPDF()">export to pdf</button>
    <script>
        function exportPDF()
        {
//            var element = document.getElementById('pdf');
//            var opt = {
//            margin:       [-2,0,0,0.1],
//            filename:     'myfile.pdf',
//            image:        { type: 'jpeg', quality: 0.98 },
//            html2canvas:  { scale: 2 },
//            jsPDF:        { unit: 'in', format: 'A4', orientation: 'portrait' }
//          };

          // New Promise-based usage:
//          html2pdf().set(opt).from(element).save();

          // Old monolithic-style usage:
//          html2pdf(element, opt);
            document.getElementById("but").hidden = true;
            window.print();
            document.getElementById("but").hidden = false;
        }
    </script>
</body>
</html>