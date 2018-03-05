<!doctype html>
<html>
<head>
    <title>Agencias</title>

    <asset:javascript src="application.js"/>
    <asset:stylesheet src="application.css"/>
    %{--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>--}%
    <script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
</head>
<body>
<h2 id="agencia">Listado de Agencias:</h2>
<table width="50%" border="1" align="center">
    <tr>
        <th>Agencia</th>
        <th>Distancia</th>
    </tr>
    <g:each in="${listaAgencias.results}" var="p">
        <tr class="agencia" name="${p.description}">
            <td>${p.description}</td>
            <td>${p.distance}</td>
        </tr>
    </g:each>
</table>
<div id="map"></div>

<script>

    function initMap() {

        var map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: ${lat}, lng: ${lng}},
            zoom: 15
        });

        var marker = new google.maps.Marker({
            position: {lat: ${lat}, lng: ${lng}},
            icon:"http://maps.google.com/mapfiles/ms/icons/blue-dot.png",
            map: map
        });

        <g:each var="agency" in="${listaAgencias}">
        var position = {lat: ${lat}, lng: ${lng}};

        var marker = new google.maps.Marker({

            position: {lat: ${agency.lat}, lng: ${agency.lng}},
            icon:"http://maps.google.com/mapfiles/ms/icons/red-dot.png",
            map: map
        });
        </g:each>
    }
</script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAD_6zTNUbHKdXntfCmiSSQXd-N7Wm53Sw&callback=initMap">
</script>

<script>
    $( document ).ready(function() {
        $("tr").on("click", function(){
            var contenido = $(this).attr("name");
            console.log(contenido);
            <g:each in="${listaAgencias.results}" var="p">
                if("${p.description}"==contenido){
                    alert("Direccion: ${p.address.address_line}\nPais: ${p.address.country}\nCiudad: ${p.address.city}\nCódigo Postal: ${p.address.zip_code}");
                }
            </g:each>
        });
    });
</script>
</body>
</html>