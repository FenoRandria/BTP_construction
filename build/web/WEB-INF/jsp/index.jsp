<%-- 
    Document   : login
    Created on : May 2, 2024, 1:32:04 PM
    Author     : fenor
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <link rel="stylesheet" href="../../assets/css/list.css"> -->
    <title>Devis</title>
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
    <h2>Devis</h2>
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
            <!-- -------------Mini-titre---------- -->
            <tr>
                <td>000</td>
                <td class="mini-titre">TRAVAUX PREPARATOIRE</td>
            </tr>
            <!-- -------------Mini-titre---------- -->
            <!-- -------------Donnee---------- -->
            <tr>
                <td>001</td>
                <td>mur de soutenement et demi Cloture ht 1m m3</td>
                <td>26,98</td>
                <td>5 126 200,00</td>
                <td>5 126 200,00</td>
                <td>190 000,00</td>
            </tr>
            <!-- -------------Donnee---------- -->
            <tr></tr>
                <td colspan="5" style="text-align:right;"  class="mini-titre">TOTAL</td>
                <td  class="mini-titre">10 115 666,98</td>
            </tr>
             <!-- -------------Mini-titre---------- -->
             <tr>
                <td>000</td>
                <td class="mini-titre">TRAVAUX PREPARATOIRE</td>
            </tr>
            <!-- -------------Mini-titre---------- -->
               <!-- -------------Donnee---------- -->
               <tr>
                <td>001</td>
                <td>mur de soutenement et demi Cloture ht 1m m3</td>
                <td>26,98</td>
                <td>5 126 200,00</td>
                <td>5 126 200,00</td>
                <td>190 000,00</td>
            </tr>
            <!-- -------------Donnee---------- -->   <!-- -------------Donnee---------- -->
            <tr>
                <td>001</td>
                <td>mur de soutenement et demi Cloture ht 1m m3</td>
                <td>26,98</td>
                <td>5 126 200,00</td>
                <td>5 126 200,00</td>
                <td>190 000,00</td>
            </tr>
            <!-- -------------Donnee---------- -->   <!-- -------------Donnee---------- -->
            <tr>
                <td>001</td>
                <td>mur de soutenement et demi Cloture ht 1m m3</td>
                <td>26,98</td>
                <td>5 126 200,00</td>
                <td>5 126 200,00</td>
                <td>190 000,00</td>
            </tr>
            <!-- -------------Donnee---------- -->
            <tr></tr>
            <td colspan="5" style="text-align:right;"  class="mini-titre">TOTAL</td>
            <td  class="mini-titre">10 115 666,98</td>
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