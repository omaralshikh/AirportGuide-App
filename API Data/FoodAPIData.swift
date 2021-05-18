//
//  FoodAPIData.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 11/24/20.
//


import Foundation
 
/*
 Nutrition data are obtained from Nutritionix API, https://www.nutritionix.com/business/api
 Version 2 API Documentation: https://developer.nutritionix.com/docs/v2
 To use this API, sign up at above URL and get your own appID and appKey.
 */
//fileprivate let appID  = "Get Your Own App ID"
fileprivate let appKey = "4f82f97fe4c4b73d050e0221538f4a21"

// Declare foodItem as a global mutable variable accessible in all Swift files
//var foodItem = FoodStruct(brandName: "", foodName: "", imageUrl: "", ingredients: "", calories: "", dietaryFiber: "", protein: "", saturatedFat: "", sodium: "", sugars: "", totalCarbohydrate: "", totalFat: "", servingQuantity: "", servingUnit: "", servingWeight: "")

var foodFoundArray = [FoodStruct]()
 
fileprivate var previousUPC = ""
 
/*
 =================================================================
 Get Nutrition Data from the API for the Food Item with UPC.
 Universal Product Code (UPC) is a barcode symbology consisting of
 12 numeric digits that are uniquely assigned to a trade item.
 =================================================================
 */
public func getNutritionDataFromApi(upc: String) {
   
    // Avoid executing this function if already done for the same UPC
    /*
    if upc == previousUPC {
        return
    } else {
        previousUPC = upc
    }
   */
    previousUPC = upc
    /*
     Create an empty instance of FoodStruct defined in FoodStruct.swift
     Assign its unique id to the global variable foodItem
     */
    //foodItem = FoodStruct(brandName: "", foodName: "", imageUrl: "", ingredients: "", calories: "", dietaryFiber: "", protein: "", saturatedFat: "", sodium: "", sugars: "", totalCarbohydrate: "", totalFat: "", servingQuantity: "", servingUnit: "", servingWeight: "")

    
    let currentGeoLocation = currentLocation()
    let curLat = currentGeoLocation.latitude
    let curLon = currentGeoLocation.longitude
   
    /*
     *************************
     *   API Documentation   *
     *************************
    
     
    
     */
    /*
     {
       "results_found": 42693,
       "results_start": 0,
       "results_shown": 20,
       "restaurants": [
         {
           "restaurant": {
             "R": {
               "res_id": 16769546,
               "is_grocery_store": false,
               "has_menu_status": {
                 "delivery": -1,
                 "takeaway": -1
               }
             },
             "apikey": "4f82f97fe4c4b73d050e0221538f4a21",
             "id": "16769546",
             "name": "Katz's Delicatessen",
             "url": "https://www.zomato.com/new-york-city/katzs-delicatessen-lower-east-side?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1",
             "location": {
               "address": "205 East Houston Street, New York 10002",
               "locality": "Lower East Side",
               "city": "New York City",
               "city_id": 280,
               "latitude": "40.7223277778",
               "longitude": "-73.9873500000",
               "zipcode": "10002",
               "country_id": 216,
               "locality_verbose": "Lower East Side"
             },
             "switch_to_order_menu": 0,
             "cuisines": "Sandwich",
             "timings": "8 AM to 10:30 PM (Mon, Tue, Wed, Sun), 8 AM to 2:30 AM (Thu),24 Hours (Fri-Sat)",
             "average_cost_for_two": 30,
             "price_range": 2,
             "currency": "$",
             "highlights": [
               "Lunch",
               "Serves Alcohol",
               "Cash",
               "Takeaway Available",
               "Breakfast",
               "Dinner",
               "Credit Card",
               "Kosher",
               "Wine",
               "Indoor Seating",
               "Beer"
             ],
             "offers": [],
             "opentable_support": 0,
             "is_zomato_book_res": 0,
             "mezzo_provider": "OTHER",
             "is_book_form_web_view": 0,
             "book_form_web_view_url": "",
             "book_again_url": "",
             "thumb": "https://b.zmtcdn.com/data/pictures/6/16769546/48ab9901ddf191d13ade07221b43ba93.jpg?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
             "user_rating": {
               "aggregate_rating": "4.5",
               "rating_text": "Excellent",
               "rating_color": "3F7E00",
               "rating_obj": {
                 "title": {
                   "text": "4.5"
                 },
                 "bg_color": {
                   "type": "lime",
                   "tint": "700"
                 }
               },
               "votes": 2465
             },
             "all_reviews_count": 538,
             "photos_url": "https://www.zomato.com/new-york-city/katzs-delicatessen-lower-east-side/photos?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1#tabtop",
             "photo_count": 9323,
             "menu_url": "https://www.zomato.com/new-york-city/katzs-delicatessen-lower-east-side/menu?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1&openSwipeBox=menu&showMinimal=1#tabtop",
             "featured_image": "https://b.zmtcdn.com/data/pictures/6/16769546/48ab9901ddf191d13ade07221b43ba93.jpg?output-format=webp",
             "medio_provider": false,
             "has_online_delivery": 0,
             "is_delivering_now": 0,
             "store_type": "",
             "include_bogo_offers": true,
             "deeplink": "zomato://restaurant/16769546",
             "is_table_reservation_supported": 0,
             "has_table_booking": 0,
             "events_url": "https://www.zomato.com/new-york-city/katzs-delicatessen-lower-east-side/events#tabtop?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1",
             "phone_numbers": "(212) 254-2246",
             "all_reviews": {
               "reviews": [
                 {
                   "review": []
                 },
                 {
                   "review": []
                 },
                 {
                   "review": []
                 },
                 {
                   "review": []
                 },
                 {
                   "review": []
                 }
               ]
             },
             "establishment": [
               "Deli"
             ],
             "establishment_types": []
           }
         },
     */
 
    /*
    *********************************************
    *   Obtaining API Search Query URL Struct   *
    *********************************************
    */
   
    var apiQueryUrlStruct: URL?
   //https://developers.zomato.com/api/v2.1/search?lat=40.732013&lon=-73.996155&radius=100000000
    //https://trackapi.nutritionix.com/v2/search/item?upc=\(upc)
     if let urlStruct = URL(string: "https://developers.zomato.com/api/v2.1/search?lat=\(curLat)&lon=\(curLon)&radius=\(upc)") {
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
        "host": "developers.zomato.com"
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
            if let jArray = jsonDataDictionary["restaurants"] as? [Any] {
                foodsJsonArray = jArray
            } else {
                semaphore.signal()
                return
            }
               
            //-------------------------
            // Obtain Foods JSON Object
            //-------------------------
            
            if (foodsJsonArray.count != 0) {
                
            loop: for i in 0...(foodsJsonArray.count-1){
                
            
            var foodsJsonObject = [String: Any]()
            if let jObject = foodsJsonArray[i] as? [String: Any] {
                foodsJsonObject = jObject
            } else {
                semaphore.signal()
                return
            }
            
            //----------------
            // Initializations
            //----------------
             
            var getName = "", getUrl = "", getAddress = "", getLat = "", getLon = ""
            var getCuisines = "", getTime = "", getCost = 0.0, getRat = ""
            var getMenuUrl = "", getFImage = "", getPhone = ""
           
 
            //------------------
            // Obtain Brand Name
            //------------------
            if let photoJsonObject1 = foodsJsonObject["restaurant"] as? [String: Any] {
                if let thumbUrl = photoJsonObject1["name"] as? String {
                    getName = thumbUrl
                }
                if let UrlG = photoJsonObject1["url"] as? String {
                    getUrl = UrlG
                }
                
                if let photoJsonObject2 = photoJsonObject1["location"] as? [String: Any] { // inside "restaurant"
                    if let addressG = photoJsonObject2["address"] as? String {
                        getAddress = addressG
                    }
                    if let latG = photoJsonObject2["latitude"] as? String {
                        getLat = latG
                    }
                    if let lonG = photoJsonObject2["longitude"] as? String {
                        getLon = lonG
                    }
                }
                
                if let cuiG = photoJsonObject1["cuisines"] as? String {
                    getCuisines = cuiG
                }
                if let timeG = photoJsonObject1["timings"] as? String {
                    getTime = timeG
                }
                if let costG = photoJsonObject1["average_cost_for_two"] as? Double {
                    getCost = costG
                }
             
            if let photoJsonObject2 = photoJsonObject1["user_rating"] as? [String: Any] { // inside "location"
                    // might need to change photoJsonObject2 name
                if let rateG = photoJsonObject2["aggregate_rating"] as? String {
                    getRat = rateG
                }
                
            } // end of user Rating
                if let menuUrlG = photoJsonObject1["menu_url"] as? String {
                    getMenuUrl = menuUrlG
                }
                if let menuFImG = photoJsonObject1["featured_image"] as? String {
                    getFImage = menuFImG
                }
                if let phoneG = photoJsonObject1["phone_numbers"] as? String {
                    getPhone = phoneG
                }
            }
           
            let foodFound = FoodStruct(id: UUID(), name: getName, url: getUrl, address: getAddress, latitude: getLat, longitude: getLon, cuisines: getCuisines, timings: getTime, average_cost_for_two: getCost, aggregate_rating: getRat, menu_url: getMenuUrl, featured_image: getFImage, phone_numbers: getPhone)
                
            
                foodFoundArray.append(foodFound)
                
                //Cut off at index 20
                if(i == 19){
                    break loop
                }
                
            }
        }
               
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
