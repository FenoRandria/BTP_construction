
<%@page import="model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Place"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>


<% 

    User user = (User) session.getAttribute("user");
    List<Place> placeList = null;
    if(request.getAttribute("dataplace")!=null){
        placeList = (ArrayList<Place>) request.getAttribute("dataplace");
    } else {
        out.println("<h1>"+"tsy misy azo"+"</h1>");
    }

%>

<% 
    DecimalFormatSymbols symbols = new DecimalFormatSymbols();
    symbols.setGroupingSeparator(' '); 
    DecimalFormat formatNumber = new DecimalFormat("#,###.##", symbols); 
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
    double nombre = 0.0;
    if ((nombre % 1) == 0) { 
        formatNumber = new DecimalFormat("#,###.##", symbols);
    } else {
        formatNumber = new DecimalFormat("#,##0.00", symbols);
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tableau.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleSidebar.css">
    <link rel='stylesheet' href='${pageContext.request.contextPath}/assets/css/boxicons.min.css'>
    <title>Tableau</title>
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
                    <i class='bx bx-grid-alt'></i>
                    <span class="link_name">Dashboard</span>
                </a>
                <ul class="sub-menu blank">
                    <li><a class="link_name" href="#">Place</a></li>
                </ul>
            </li>
            <li>
                <div class="iocn-link">
                    <a href="#">
                        <i class='bx bx-collection'></i>
                        <span class="link_name">Place</span>
                    </a>
                    <i class='bx bxs-chevron-down arrow'></i>
                </div>
                <ul class="sub-menu">
                    <li><a class="link_name" href="gestion-places">List-Place</a></li>
                    <li><a href="ajout-place">Ajout Place</a></li>
                    <li><a href="gestion-places">Modifier Place</a></li>
                    <li><a href="gestion-places">Supprimer Place</a></li>
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
                        <div class="profile_name"><% if(user!=null) out.print(user.getNom()); %></div>
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
                        <!-- <img src="${pageContext.request.contextPath}/assets/img/logoWhite.png" alt="" /> -->
                    </div>
                    <nav>
                        <div class="menuNav">
                            <ul>
                                <li><a href="" class="">Home</a></li>
                                <li><a href="#" class="actif">tableau</a></li>
                                <li><a href="list" class="">List</a></li>
                                <li><a href="chart" class="">Chart</a></li>
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
                                    <img src="${pageContext.request.contextPath}/assets/img/our.png" alt="">
                                </div>
                                <div class="infoProfile">
                                    <h3><% if(user!=null) out.print(user.getNom()); %></h3>
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
                <div class="generateProd">
                    <h1 class="textTitre">Insertion <span>Place</span></h1>
                    <div class="insertionProduit">
                        <div class="gestionProduit">
<!-- *********************** ****************Insertion**************** ***************************************************************-->
                            <div id="formularInsertProduit">
                                <h1>Add <span>Place</span></h1>
                                <form id="formData">
                                    <select name="idParking">
                                        <option value="1">Parking 1</option>
                                    </select>
                                    <input type="text" name="numero" id="" placeholder="Numero Place" required>
                                    <input type="submit" value="Inserer">
                                </form>
<!-- *********************** ****************Insertion**************** ***************************************************************-->                  
                                <h1>Import World!</h1>
                                <form action="importation" method="post" enctype="multipart/form-data">
                                    <input type="file" name="file">
                                    <input type="submit" value="Import">
                                </form>

                                <h1>Export World!</h1>
                                <form action="exportation" method="post" enctype="multipart/form-data">
                                    <input type="text" name="filename" placeholder="enter file name">
                                    <select name="typefile">
                                        <option value=".xlsx">xlsx</option>                
                                        <option value=".csv">csv</option>
                                    </select>
                                    <input type="submit" value="Export to file">
                                </form>
                                
                            </div>

                            <!------------------Tablau Place ---------------------->
                            <div class="listProduit">

                                <h1>List <span> Place </span></h1>
                                <table border=1>
                                    <tr>
                                        <th>Numero Place</th>
                                        <th>--</th>
                                        <th>--</th>
                                        <th>--</th>
                                    </tr>
                                    <%
                                        if(placeList!=null) {
                                            for(int i = 0; i< placeList.size(); i++) { %>
                                                <% Place place = (Place) placeList.get(i); %>
                                                <tr id="<%= place.getId()%>">
                                                    <td class="texteFormat"><%= place.getNumero() %></td>                                                   
                                                    <td><a class="modifier"  onclick="modif(<%= place.getId()%>)">Modifier</a></td>
                                                    <td><a href="" class="show">Show</a></td>
                                                    <td><a href="" class="delete">Delete</a></td>
                                                </tr>
                                            <% } %>                                            
                                        <% } %>
                                </table>
                                        
                            </div>
                    </div>
                </div>
                <!-- -----------------PopUp ------------------------->
                <div class="popup" id="myPopup">
                    <div class="popup-content">
                        <!-- -----------------Tsy azo Esorina------------------------->
                        <span class="close" id="closePopUp">&times;</span>
                        <!-- -----------------/Tsy azo Esorina ------------------------->
                        <div class="production">
                            <div class="modificationProduit">
                                <h1>Modification <span> Place </span></h1>
                                <form action="#" method="get">
                                    <input type="text" name="Numero" value="" id="Numero" placeholder="Numero Place"  required>
                                    <input type="hidden" name="id" id="id" value="">
                                    <input type="submit" value="Valider" id="validationPopUp">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="popup" id="myPopupValidation">
                    <div class="popup-content">
                        <!-- -----------------Tsy azo Esorina------------------------->
                        <span class="close" id="closePopUpValidation">&times;</span>
                        <!-- -----------------/Tsy azo Esorina ------------------------->
                        <h1>Tena hosolina ve? </h1>
                        <a href="" class="show">Oui</a>
                        <a href="" class="delete">Non</a>
                    </div>
                </div>
                <!-- ----------------------Code taloha------------------------- -->
            </div>
    </section>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>

</html>
<style>
    @keyframes anamimationproductionup {
        from {
            transform: translateY(0px);
            opacity: 1;
        }

        to {
            opacity: 0;
            transform: translateY(-100px);
        }
    }
</style>


<script src="${pageContext.request.contextPath}/assets/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

        $(document).ready(function() {
        $('#loginForm').submit(function(event) {
            event.preventDefault();
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    console.log(this.responseText);

                    let data = this.responseText.split(";");
                    console.log("message: ",data[0]);
                    if(data[0].toString() === 'error'){
                        document.getElementById("errorMsg").innerHTML = data[1];
                    } else if(data[0].toString()=== 'success') {
                        console.log('http://localhost:8084/promo13_parking'+data[1]);
                        window.location.href = 'http://localhost:8084/promo13_parking'+data[1];
                    }
                }
            };
            let  mail = $('#email').val();
            let mdp = $('#motdepasse').val();

            var params = "mail=" + encodeURIComponent(mail) + "&mdp=" + encodeURIComponent(mdp);
            xmlhttp.open("POST", "user-login", true);
            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp.send(params);
        });
    });

</script>


<script>
    var production = document.querySelector(".production");
    function closer(params) {
        production.classList.add("");
    }

    function modif(id) {
        production.style.display = "flex";
        var trElement = document.getElementById(id);
        var tdElements = trElement.getElementsByTagName("td");
        document.getElementById('Numero').value = tdElements[0].textContent;
        var id = document.getElementById('id').value = id;
        document.getElementById("myPopup").style.display = "block";
    }


    document.getElementById("closePopUp").addEventListener("click", function () {
        console.log("Tu as clicker");
        document.getElementById("myPopup").style.display = "none";
    });


    //Pop Up Validation
    document.getElementById("validationPopUp").addEventListener("click", function () {
        document.getElementById("myPopupValidation").style.display = "block";
        console.log(document.getElementById("myPopupValidation"));
    });

    document.getElementById("closePopUpValidation").addEventListener("click", function () {
        document.getElementById("myPopupValidation").style.display = "none";
    });
</script>