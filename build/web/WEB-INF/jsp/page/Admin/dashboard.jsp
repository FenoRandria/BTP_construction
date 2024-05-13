
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<% 
        User user = (User) session.getAttribute("user");
    
        List<String> labels = Arrays.asList("Janvier", "Fevrier", "Mars", "Avril", "Mail", "Juin");
        List<Integer> data = Arrays.asList(20, 30, 25, 150, 10, 13);
        
        String labelsArray = Arrays.toString(labels.toArray());
        labelsArray = labelsArray.substring(1, labelsArray.length() - 1); // Supprimer les crochets
        
        labelsArray = "['" + labelsArray.replaceAll(", ", "','") + "']";
        String dataArray = Arrays.toString(data.toArray());
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleSidebar.css">
    <link href='${pageContext.request.contextPath}/assets/css/boxicons.min.css' rel='stylesheet'>
    <title>Chart-statistic</title>
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
                <a href="#">
                    <i class='bx bx-grid-alt'></i>
                    <span class="link_name">Dashboard</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Category</a></li>
                </ul>
            </li>
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-collection'></i>
                        <span class="link_name">Category</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="#">Category</a></li>
                    <li><a href="#">HTML & CSS</a></li>
                    <li><a href="#">JavaScript</a></li>
                    <li><a href="#">PHP & MySQL</a></li>
                </ul>
            </li>
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-book-alt'></i>
                        <span class="link_name">Auth</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="#">Auth</a></li>
                    <li><a href="auth/admin">Login Admin</a></li>
                    <li><a href="auth/user">Login User</a></li>
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
                <a href="#">
                    <i class='bx bx-line-chart'></i>
                    <span class="link_name">Chart</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Chart</a></li>
                </ul>
            </li>
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-plug'></i>
                        <span class="link_name">Plugins</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="#">Plugins</a></li>
                    <li><a href="#">UI Face</a></li>
                    <li><a href="#">Pigments</a></li>
                    <li><a href="#">Box Icons</a></li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class='bx bx-compass'></i>
                    <span class="link_name">Explore</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Explore</a></li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class='bx bx-history'></i>
                    <span class="link_name">History</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">History</a></li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class='bx bx-cog'></i>
                    <span class="link_name">Setting</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Setting</a></li>
                </ul>
            </li>
            <li>
                <div class="profile-details">
                    <div class="profile-content">
                        <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="profileImg">
                    </div>
                    <div class="name-job">
                        <div class="profile_name">Feno Randria</div>
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
                            <ul>
                                <li><a href="#" class="">Home</a></li>
                                <li><a href="tableau" class="">tableau</a></li>
                                <li><a href="list" class="">List</a></li>
                                <li><a href="#" class="actif">Chart</a></li>
                                <li><a href="formulaire" class="">Formulaire</a></li>
                            </ul>
                        </div>
                        <div class="recherche">
                            <form action="../page/resultatRecherche.html" method="get">
                                <input type="text" name="" id="search" placeholder="Votre Recherche" />
                                <button>
                                    <img src="${pageContext.request.contextPath}/assets/img/btnSearchnoneFOnd.png" alt="">
                                </button>
                            </form>
                        </div>
                        <div class="profilOUt">
                            <div class="profil">
                                <div class="imageProfile">
                                    <img src="${pageContext.request.contextPath}/assets/img/me.jpeg" alt="">
                                </div>
                                <div class="infoProfile">
                                    <h3>
                                       <% if(user!=null) out.print(user.getNom()); %>
                                    </h3>
                                    <p>4.674.00 Point</p>
                                </div>
                            </div>
                            <div class="logOut">
                                <div class="texte">
                                    <a href="#">Log Out</a>
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
                        <canvas id="pieChart" width="400" height="400"></canvas>
                        <script src="${pageContext.request.contextPath}/assets/js/chart.min.js"></script>
                        <script>
                            var ctx = document.getElementById('pieChart').getContext('2d');
                            var pieChart = new Chart(ctx, {
                                type: 'pie',
                                data: {
//                                    labels: ['Janvier', 'Fevrier', 'Mars', 'Avril', 'Mai', 'Juin'],
                                    labels: <%= labelsArray %>,
                                    datasets: [{
//                                        data: [20, 30, 25, 15, 10, 13],
                                        data: <%= dataArray %>,
                                        backgroundColor: ['red', 'green', 'blue', 'yellow', 'orange', 'violet']
                                    }]
                                }
                            });
                        </script>
                    </div>
                    <div class="chartBatton">
                        <canvas id="barChart" width="400" height="400"></canvas>
                        <script src="${pageContext.request.contextPath}/assets/js/chart.min.js"></script>
                        <script>
                            var ctx = document.getElementById('barChart').getContext('2d');
                            var barChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['A', 'B', 'C', 'D', 'E'],
                                    datasets: [{
                                        label: 'Scores',
                                        data: [70, 85, 60, 90, 75],
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
//                                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                                      labels: <%= labelsArray %>,
                                    datasets: [{
                                        label: 'Sales',
//                                        data: [100, 150, 200, 250, 300, 350],
                                          data: <%= dataArray %>,
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