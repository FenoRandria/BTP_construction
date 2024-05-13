<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="model.*"%>
<%@page import="java.sql.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
        Dashboard[] totalMontant =  (Dashboard[])request.getAttribute("totalMontant");
        Dashboard[] ontantdevisannee =  (Dashboard[])request.getAttribute("devisannee");
        Dashboard[] ontantdevismois =  (Dashboard[])request.getAttribute("devismois");

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
                <div class="iocn-link">
                    <a href="listDevisAdmin">
                        <i class='bx bx-book-alt'></i>
                        <span class="link_name">Devis En Cours</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="listDevisAdmin">Devis En Cours</a></li>
                    <li><a href="#">Web Design</a></li>
                    <li><a href="#">Login Form</a></li>
                    <li><a href="#">Card Design</a></li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class='bx bx-pie-chart-alt-2'></i>
                    <span class="link_name">Analytics</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Analytics</a></li>
                </ul>
            </li>
            <li>
                <a href="admin">
                    <i class='bx bx-line-chart'></i>
                    <span class="link_name">Chart</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="admin">Chart</a></li>
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
                    <div class="logo">
                        <img src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" />
                    </div>
                    <nav>
                        <div class="menuNav">
                            <%-- <ul>
                                <li><a href="#" class="">Home</a></li>
                                <li><a href=".Client/tableau.html" class="">tableau</a></li>
                                <li><a href=".Client/list.html" class="">List</a></li>
                                <li><a href="#" class="actif">Chart</a></li>
                                <li><a href="save.html" class="">Formulaire</a></li>
                            </ul> --%>
                        </div>
                       
                        <div class="profilOUt">
                            <div class="profil">
                                <div class="imageProfile">
                                    <img src="${pageContext.request.contextPath}/assets/img/our.jpeg" alt="">
                                </div>
                                <div class="infoProfile">
                                    <h3>Admin</h3>
                                    <p>4.674.00 Point</p>
                                </div>
                            </div>
                            <div class="logOut">
                                <div class="texte">
                                    <a href="logOut">Log Out</a>
                                </div>
                                <div class="img">
                                    <img src="${pageContext.request.contextPath}/assets/img/logOut.png" alt="">
                                </div>
                            </div>
                        </div>
                    </nav>
                </header>
                <h3 class="title ">Chart</h3>
                <section class="chart">
                    <div class="chartCheese">
                        <div class="Total">
                            <h3>montant total des devis:</h3>
                            <h1>
                                <%= totalMontant[0].getSommemontant() %> Ariary
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
                                    backgroundColor: 'orange',
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
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>

</html>