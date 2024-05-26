<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="model.*"%>
<%@page import="java.sql.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
        Dashboard[] totalMontant =  (Dashboard[])request.getAttribute("totalMontant");
        Dashboard[] ontantdevisannee =  (Dashboard[])request.getAttribute("devisannee");
        Dashboard[] ontantdevismois =  (Dashboard[])request.getAttribute("devismois");
        int[] yearExistant =  (int[]) request.getAttribute("yearExistant");

        // Créer des tableaux pour stocker les labels et les données
        String[] labels = new String[ontantdevismois.length];
        double[] data = new double[ontantdevismois.length];
        
        double[] labelsAnnee = new double[ontantdevisannee.length];
        double[] dataAnnee = new double[ontantdevisannee.length];
        
        // Boucle à travers le tableau d'objets
        for (int i = 0; i < ontantdevismois.length; i++) {
            // Ajouter le month_name à labels
            labels[i] = ontantdevismois[i].getMonthName();
            // Ajouter le montanttotal à data
            data[i] = ontantdevismois[i].getMontantTotal();
        }
        // Boucle à travers le tableau d'objets
        for (int i = 0; i < ontantdevisannee.length; i++) {
            // Ajouter le month_name à labels
            labelsAnnee[i] = ontantdevisannee[i].getYear();
            // Ajouter le montanttotal à data
            dataAnnee[i] = ontantdevisannee[i].getMontantTotal();
        }
        double paiementTotal = new Dashboard().getTotalMontantPaiement();
        
        
        
        

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
    <title>Suggest words</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleSidebar.css">
    <link href='${pageContext.request.contextPath}/assets/css/boxicons.min.css' rel='stylesheet'>
    <title>Tableau De bord</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/chart.css">
</head>

<body>
    <div class="sidebar close">
        <div class="logo-details" style="padding-top:20px;">
            <img width="50px" height="50px" src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" srcset="">
            <span class="logo_name">Evaluation</span>
        </div>
        <ul class="nav-links">

            <li>
                <a href="dashboard">
                    <i class='bx bx-line-chart'></i>
                    <span class="link_name">Dashboard</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="dashboard">Dashboard</a></li>
                </ul>
            </li>
            
            <li>
                <a href="devis-encours">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Devis En Cours</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="devis-encours">Devis En Cours</a></li>
                </ul>
            </li>
            
          
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-book-alt'></i>
                        <span class="link_name">Import Data</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="#">Import Data</a></li>
                    <li><a href="import-data-file">Maison-Travaux</a></li>
                    <li><a href="import-paiement">Paiement</a></li>
                </ul>
            </li>
           
            <li>
                <a href="travaux">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Gestion Travaux</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="travaux">Gestion Travaux</a></li>
                </ul>
            </li>
            
            <li>
                <a href="finition">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Gestion Finition</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="finition">Gestion Finition</a></li>
                </ul>
            </li>
            
            <li>
                <div class="profile-details">
                    <div class="profile-content">
                        <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="profileImg">
                    </div>
                    <div class="name-job">
                        <div class="profile_name">Admin </div>
                        <div class="job">Developper</div>
                    </div>
                    <i class='bx bx-log-out'></i>
                </div>
            </li>
        </ul>
    </div>
    <section class="home-section">
        <div class="home-content">
            <i class='bx bx-menu'></i>
            <div id="page">
                <!-- ----------------------Code taloha------------------------- -->
                <header>

                </header>
                <a style="color:white" href="refresh-table">refresh base</a>
                <h3 class="title ">Chart</h3>
                <section class="chart">
                    <div class="chartCheese">
                        
                         <!-- todo jour 2 -->  
                        <!-- **********************************************************************-->

                        <form action="adminYears" method="post">
                            <% if(request.getAttribute("yartCheck") != null) { %>
                                <span><label for="year">Annee selected: <%= request.getAttribute("yartCheck") %></label></span>
                            <% }else{ %>
                                <span><label for="year">Choisir annee: </label></span>
                            <% } %>
                            <span>
                                <select name="years" id="year">
                                    <option value="2024">2024</option>                                    
                                    <option value="2023">2023</option>
                                    
                                    <% 
                                        if(yearExistant!=null) {
                                        for(int i=0; i< yearExistant.length ; i++) { %>
                                        <option value="<%= yearExistant[i] %>"><%= yearExistant[i] %> </option>
                                    <% } } %>
                                </select>
                                <input type="submit" value="Submit">
                            </span>
                        </form>

                        <!-- **********************************************************************-->
                        <div class="Total">
                            <h3>Montant total des devis:</h3>
                            <h1 style="text-align: right">
                                <%= formatNumber.format(totalMontant[0].getSommemontant()) %>
                                 Ariary
                            </h1>
                        </div>
                                 
                        <div class="Total">
                            <h3>Montant total des paiement effectués</h3>
                            <h1 style="text-align: right">
                                Ariary   
                                <%= formatNumber.format(paiementTotal) %>
                                 
                            </h1>
                        </div>
                                
                    </div>
                    <div class="chartBatton">
                        <canvas id="barChart" width="400" height="400"></canvas>
                        <script src="${pageContext.request.contextPath}/assets/js/chart.min.js"></script>
                        <script>
                         var ctx = document.getElementById('barChart').getContext('2d');
                        var barChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: [<% for (int i = 0; i < labels.length; i++) { %>'<%= labels[i] %>'<% if (i < labels.length - 1) { %>,<% } %> <% } %>],
                                datasets: [{
                                    label: 'Devis Mois',
                                    data: [<% for (int i = 0; i < data.length; i++) { %><%= data[i] %><% if (i < data.length - 1) { %>,<% } %> <% } %>],
                                    backgroundColor: 'blue',
                                    borderColor: 'black',
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true
                                    }
                                }
                            }
                        });

                        </script>
                    </div>
                    <div class="chartCourbe">
                        
                     
                        
                        
                        <canvas id="lineChart" width="400" height="400"></canvas>
                        <script src="${pageContext.request.contextPath}/assets/js/chart.min.js"></script>
                        <script>
                            var ctx = document.getElementById('lineChart').getContext('2d');
                            var lineChart = new Chart(ctx, {
                                type: 'line',
                                data: {
                                labels: [<% for (int i = 0; i < labelsAnnee.length; i++) { %>'<%= labelsAnnee[i] %>'<% if (i < labelsAnnee.length - 1) { %>,<% } %> <% } %>],
                                datasets: [{
                                    label: 'Devis Annee',
                                    data: [<% for (int i = 0; i < dataAnnee.length; i++) { %><%= dataAnnee[i] %><% if (i < dataAnnee.length - 1) { %>,<% } %> <% } %>],
                                        borderColor: 'blue',
                                        borderWidth: 1
                                    }]
                                },
                                options: {
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        </script>
                    </div>
                </section>
                <!-- ----------------------Code taloha------------------------- -->
                
                
            </div>
        </div>
    </section>
    <style>

        form {
            width: 100%;
            display: flex;
            text-wrap: nowrap;
            gap: 10px;
            color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            flex-direction: column;
            align-items: flex-start;
        }

        label {
           display: block;
            font-size: 1rem;
            margin: 0;
            font-weight: 100;
            margin-bottom: -11px;
        }

        select {
              width: 90%;
            background: #ffffff14;
            padding: 11px;
            border: 1px solid #ccccccbf;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 15px;
            color: white;
        }
        option{
            color:black;
        }
        input[type="submit"] {
            background-color: #ffa73f1f;
            color: #ffa73f;
            border: 1px solid #ffa73f;
            padding: 9px 27px;
            border-radius: 4px;
            width: 97%;
            cursor: pointer;
            font-size: 16px;
            transition:0.4s ease-in-out;
        }

        input[type="submit"]:hover {
            background-color: #ffa73f;
            color:white;
        }
    </style>
                                   
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>

</html>