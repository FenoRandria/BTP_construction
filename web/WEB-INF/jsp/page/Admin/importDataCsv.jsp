<%-- 
    Document   : importDataCsv
    Created on : May 14, 2024, 9:52:03 AM
    Author     : fenor
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Import Data File</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleSidebar.css">
        <link href='${pageContext.request.contextPath}/assets/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/save.css">
    </head>
    <body>
        <div class="page" id="page">
                  
            <section class="save">
                <form id="formData" method="POST" action="upload-file-data" enctype="multipart/form-data" >
                    <h1>Import Donnée de Maison Travaux</h1>
                    <style>  
                         @keyframes error {
                                0% {
                                    transform: translateX(0px);
                                }
                                50% {
                                    transform: translateX(50px);
                                }
                                100% {
                                    transform: translateX(0px);
                                }
                            }

                            #error {
                                color: red;
                                animation: error .8s ease-in infinite;
                            }
                    </style>

                    <p id="error"> </p>
                    <!-- Email -->
                    <div class="drop-zone-section">
                        <label for="images" class="drop-container" id="dropcontainer">
                        <span class="drop-title">Drag file Maison Travaux</span>
                        or
                        <input type="file" multiple id="images" name="maisonTravaux" accept=".csv" required>
                        </label>
                    </div>
                    
                    <div class="drop-zone-section">
                        <label for="images" class="drop-container" id="dropcontainer">
                        <span class="drop-title">Drag file Devis</span>
                        or
                        <input type="file" multiple id="images" name="devis" accept=".csv" required>
                        </label>
                    </div>
                    <input type="submit" value="Upload">
                </form>
            </section>
        </div>
    </body>
    <script>
        //drag file
        const dropContainer = document.getElementById("dropcontainer");
        const fileInput = document.getElementById("images");
        document.getElementById("delete-button").onclick = ()=>{
            document.getElementById("popup-section").style.display = "block";
        }
        dropContainer.addEventListener("dragover", (e) => {
        e.preventDefault()
        }, false);

        dropContainer.addEventListener("dragenter", () => {
        dropContainer.classList.add("drag-active")
        });

        dropContainer.addEventListener("dragleave", () => {
        dropContainer.classList.remove("drag-active")
        });

        dropContainer.addEventListener("drop", (e) => {
        e.preventDefault()
        dropContainer.classList.remove("drag-active")
        fileInput.files = e.dataTransfer.files
        });
    </script>
    
</html>
