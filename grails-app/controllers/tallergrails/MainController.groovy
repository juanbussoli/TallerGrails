package tallergrails

import grails.converters.JSON
import groovy.json.JsonSlurper
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.maps.GeoApiContext
import com.google.maps.GeocodingApi
import com.google.maps.model.GeocodingResult

class MainController {

    def index() {
        def urlMediosPago = new URL('https://api.mercadolibre.com/sites/MLA/payment_methods')
        def connection = (HttpURLConnection)urlMediosPago.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozzilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def lista = json.parse(connection.getInputStream())
        def lista2 = new ArrayList()
        def obj
        lista.each{
            if(it.payment_type_id == "ticket"){
                obj = [id:it.id, name: it.name]
                lista2.add(obj)
            }
        }
        render(view: "index", model: [lista: lista2])
    }

    def search(){
        String address = params.address
        def radio = params.radio
        def pago = params.pago
        def coord = getCoord(address)
        String url = 'https://api.mercadolibre.com/sites/MLA/payment_methods/'+pago+'/agencies?near_to='+coord.lat+','+coord.lng+','+radio+'&limit=3'
        searchAgencias(url, coord)
    }

    def searchAgencias(url, coord){
        def urlAgencias = new URL(url)
        def connection = (HttpURLConnection)urlAgencias.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozzilla/5.0")
        JsonSlurper json = new JsonSlurper()
        render(view: "listado", model: [listaAgencias: json.parse(connection.getInputStream()), lat: coord.lat, lng: coord.lng])

    }

    def getCoord(address){
        GeoApiContext context = new GeoApiContext.Builder()
                .apiKey("AIzaSyDPxFMnpbhNAwhi95m1m5OXWNP3NwxYiHw")
                .build()
        GeocodingResult[] results = GeocodingApi.geocode(context, address).await()
        Gson gson = new GsonBuilder().setPrettyPrinting().create()
        def lat = gson.toJson(results[0].geometry.location.lat).toString()
        def lng = gson.toJson(results[0].geometry.location.lng).toString()

        return [lat: lat, lng: lng]
    }
}