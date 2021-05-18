//
//  WeatherApiData.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/8/20.
//


import Foundation
 

fileprivate let appKey = "5b2acd570ee44a28b5314390d3406970"
//var foundWeather = WeatherStruct(id: UUID(), timezone: "", ob_time)
var foundWeather = WeatherStruct(id: UUID(), timezone: "", ob_time: "", country_code: "", clouds: 0, wind_spd: 0.0, app_temp: 0.0, temp: 0.0, state_code: "", icon: "", description: "", city_name: "", sunrise: "", sunset: "", lat: "", lon: "", pod: "")
var appendingPapa = [WeatherStruct]()
var completedbyName2 = false

 
fileprivate var previousUPC = ""
fileprivate var newState = ""
 
/*
 =================================================================
 Get Nutrition Data from the API for the Food Item with UPC.
 Universal Product Code (UPC) is a barcode symbology consisting of
 12 numeric digits that are uniquely assigned to a trade item.
 =================================================================
 */
public func getWeatherDataFromApi(city: String, state: String) {
    completedbyName2 = false
   
    // Avoid executing this function if already done for the same UPC
    if city == previousUPC {
        return
    } else {
        previousUPC = city
        newState = state
    }
    
    
    let currentGeoLocation = currentLocation()
    let curLat = currentGeoLocation.latitude
    let curLon = currentGeoLocation.longitude
   
   
    /*
     {
                    "data":[
                       {
                          "wind_cdir":"NE",
                          "rh":59,
                          "pod":"d",
                          "lon":"-78.63861",
                          "pres":1006.6,
                          "timezone":"America\/New_York",
                          "ob_time":"2017-08-28 16:45",
                          "country_code":"US",
                          "clouds":75,
                          "vis":10,
                          "wind_spd":6.17,
                          "wind_cdir_full":"northeast",
                          "app_temp":24.25,
                          "state_code":"NC",
                          "ts":1503936000,
                          "h_angle":0,
                          "dewpt":15.65,
                          "weather":{
                             "icon":"c03d",
                             "code": 803,
                             "description":"Broken clouds"
                          },
                          "uv":2,
                          "aqi":45,
                          "station":"CMVN7",
                          "wind_dir":50,
                          "elev_angle":63,
                          "datetime":"2017-08-28:17",
                          "precip":0,
                          "ghi":444.4,
                          "dni":500,
                          "dhi":120,
                          "solar_rad":350,
                          "city_name":"Raleigh",
                          "sunrise":"10:44",
                          "sunset":"23:47",
                          "temp":24.19,
                          "lat":"35.7721",
                          "slp":1022.2
                       }
                    ],
                    "count":1
                 }
     */
 
    /*
    *********************************************
    *   Obtaining API Search Query URL Struct   *
    *********************************************
    */
   
    var apiQueryUrlStruct: URL?
   //https://api.weatherbit.io/v2.0/current?city=Raleigh,NC&key=API_KEY
    //&city=Raleigh,NC
     if let urlStruct = URL(string: "https://api.weatherbit.io/v2.0/current?&city=\(previousUPC),\(newState)&key=\(appKey)") {
         apiQueryUrlStruct = urlStruct
     } else {
         // foodItem will have the initial values set as above
         return
     }
   
    /*
    *******************************
    *   HTTP GET Request Set Up   *
    *******************************
    */
 
    let headers = [
   
        "accept": "application/json",
        "user-key": appKey,
        "host": "api.weatherbit.io"
    ]
   
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
   
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
   
    /*
    *********************************************************************
    *  Setting Up a URL Session to Fetch the JSON File from the API     *
    *  in an Asynchronous Manner and Processing the Received JSON File  *
    *********************************************************************
    */
   
    /*
     Create a semaphore to control getting and processing API data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
   
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the JSON file from the API is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */
       
        // Process input parameter 'error'
        guard error == nil else {
            semaphore.signal()
            return
        }
       
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }
       
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            semaphore.signal()
            return
        }
 
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
            Foundation framework’s JSONSerialization class is used to convert JSON data
            into Swift data types such as Dictionary, Array, String, Number, or Bool.
            */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                              options: JSONSerialization.ReadingOptions.mutableContainers)
 
            /*
             JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
             Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
             where Dictionary Key type is String and Value type is Any (instance of any type)
             */
            var jsonDataDictionary = Dictionary<String, Any>()
            
            if let jsonObject = jsonResponse as? [String: Any] {
                jsonDataDictionary = jsonObject
            } else {
                semaphore.signal()
                return
            }
           
            //------------------------
            // Obtain Foods JSON Array
            //------------------------
           
            var foodsJsonArray = [Any]()
            if let jArray = jsonDataDictionary["data"] as? [Any] {
                foodsJsonArray = jArray
            } else {
                semaphore.signal()
                return
            }
               
            //-------------------------
            // Obtain Foods JSON Object
            //-------------------------
           
            var foodsJsonObject = [String: Any]()
            if let jObject = foodsJsonArray[0] as? [String: Any] {
                foodsJsonObject = jObject
            } else {
                semaphore.signal()
                return
            }
           
            //----------------
            // Initializations
            //----------------
            /*
             public var id: UUID
             var timezone: String
             var ob_time: String
             var country_code: String
             var clouds: Int // percentage coverage
             var wind_spd: Double // miles per sec
             var app_temp: Double // feels like
             var temp: Double
             var state_code: String
             var icon: String
             var description: String
             var city_name: String
             var sunrise: String
             var sunset: String
             var lat: String
             var lon: String
             */
            var timezone = "", ob_time = "", country_code = "", clouds = 0
            var wind_spd = 0.0, app_temp = 0.0, temp = 0.0, state_code = ""
            var icon = "", description = "", city_name = "", sunrise = ""
            var sunset = "", lat = "", lon = "", pod = ""
 
            //------------------
            // Obtain Brand Name
            //------------------
 
            if let nameOfBrand = foodsJsonObject["timezone"] as? String {
                timezone = nameOfBrand
            }
            
            if let nameOfBrand1 = foodsJsonObject["pod"] as? String {
                pod = nameOfBrand1
            }
           
            //-----------------
            // Obtain Food Name
            //-----------------
           
            if let nameOfFood = foodsJsonObject["ob_time"] as? String {
                ob_time = nameOfFood
            } else {
                semaphore.signal()
                // Skip the food item if it does not have a name
                return
            }
           
            //---------------------------------
            // Obtain Food Item Photo Image URL
            //---------------------------------
           
            /*
             photo = {
                 highres = "<null>";
                 "is_user_uploaded" = 0;
                 thumb = "https://d1r9wva3zcpswd.cloudfront.net/5c8b546e4e2286f47884266f.jpeg";
             };
             */
            if let photoJsonObject = foodsJsonObject["weather"] as? [String: Any] {
                if let thumbUrl = photoJsonObject["icon"] as? String {
                    icon = thumbUrl
                }
                if let thumbUrl1 = photoJsonObject["description"] as? String {
                    description = thumbUrl1
                }
            }
               
            //-------------------
            // Obtain Ingredients
            //-------------------
            
            if let nf_ingredient_statement = foodsJsonObject["country_code"] as? String {
                country_code = nf_ingredient_statement
            }
           
            //----------------
            // Obtain Calories
            //----------------
            
            if let nf_calories = foodsJsonObject["clouds"] as? Int {
                clouds = nf_calories
            }
           
            //---------------------
            // Obtain Dietary Fiber
            //---------------------
            
            if let nf_dietary_fiber = foodsJsonObject["wind_spd"] as? Double {
                wind_spd = nf_dietary_fiber
            }
           
            //----------------------
            // Obtain Protein Amount
            //----------------------
            
            if let nf_protein = foodsJsonObject["app_temp"] as? Double {
                app_temp = nf_protein
            }
           
            //---------------------
            // Obtain Saturated Fat
            //---------------------
            
            if let nf_saturated_fat = foodsJsonObject["temp"] as? Double {
                temp = nf_saturated_fat
            }
               
            //---------------------
            // Obtain Sodium Amount
            //---------------------
            
            if let nf_sodium = foodsJsonObject["state_code"] as? String {
                state_code = nf_sodium
            }
           
            //--------------------
            // Obtain Sugar Amount
            //--------------------
            
            if let nf_sugars = foodsJsonObject["city_name"] as? String {
                city_name = nf_sugars
            }
           
            //--------------------------
            // Obtain Total Carbohydrate
            //--------------------------
            
            if let nf_total_carbohydrate = foodsJsonObject["sunrise"] as? String {
                sunrise = nf_total_carbohydrate
            }
           
            //------------------------
            // Obtain Total Fat Amount
            //------------------------
            
            if let nf_total_fat = foodsJsonObject["sunset"] as? String {
                sunset = nf_total_fat
            }
           
            //------------------------
            // Obtain Serving Quantity
            //------------------------
            
            if let serving_qty = foodsJsonObject["lat"] as? String {
                lat = serving_qty
            }
               
            //--------------------
            // Obtain Serving Unit
            //--------------------
            
            if let unitOfServing = foodsJsonObject["lon"] as? String {
                lon = unitOfServing
            }
           
            //----------------------
            // Obtain Serving Weight
            //----------------------
            
            
               
            /*
             It is good practice to print out the values obtained from the
             JSON file during the app development to validate their accuracy.
             */
//                    print("brand_name = \(brand_name)")
//                    print("food_name = \(food_name)")
//                    print("photo_url = \(photo_url)")
//                    print("ingredient_statement = \(ingredient_statement)")
//                    print("caloriesAmount = \(caloriesAmount)")
//                    print("dietary_fiber = \(dietary_fiber)")
//                    print("proteinAmount = \(proteinAmount)")
//                    print("saturated_fat = \(saturated_fat)")
//                    print("sodiumAmount = \(sodiumAmount)")
//                    print("sugarAmount = \(sugarAmount)")
//                    print("total_carbohydrate = \(total_carbohydrate)")
//                    print("total_fat = \(total_fat)")
//                    print("serving_quantity = \(serving_quantity)")
//                    print("serving_unit = \(serving_unit)")
//                    print("serving_weight = \(serving_weight)")
               
            /*
             Create an instance of FoodStruct, dress it up with the values obtained from the API,
             and set its id to the global variable foodItem
             */
//            foodItem = FoodStruct(brandName: brand_name, foodName: food_name, imageUrl: photo_url, ingredients: ingredient_statement, calories: caloriesAmount, dietaryFiber: dietary_fiber, protein: proteinAmount, saturatedFat: saturated_fat, sodium: sodiumAmount, sugars: sugarAmount, totalCarbohydrate: total_carbohydrate, totalFat: total_fat, servingQuantity: serving_quantity, servingUnit: serving_unit, servingWeight: serving_weight)
            foundWeather = WeatherStruct(id: UUID(), timezone: timezone, ob_time: ob_time, country_code: country_code, clouds: clouds, wind_spd: wind_spd, app_temp: app_temp, temp: temp, state_code: state_code, icon: icon, description: description, city_name: city_name, sunrise: sunrise, sunset: sunset, lat: lat, lon: lon, pod: pod)
            appendingPapa.append(foundWeather)
            completedbyName2 = true

               
        } catch {
            semaphore.signal()
            return
        }
       
        semaphore.signal()
    }).resume()
   
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
    
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 10 seconds expires.
    */
 
    _ = semaphore.wait(timeout: .now() + 10)
       
}
 



/*
import SwiftUI

struct WeatherApiData: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WeatherApiData_Previews: PreviewProvider {
    static var previews: some View {
        WeatherApiData()
    }
}
*/
