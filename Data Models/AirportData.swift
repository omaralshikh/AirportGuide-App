//
//  AirportData.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/6/20.
//

import SwiftUI
import CoreData
 
// Array of MusicAlbum structs for use only in this file
fileprivate var AirportStructList = [AirportStruct]()
 
/*
 ***********************************
 MARK: - Create Music Album Database
 ***********************************
 */
public func createAirportsDatabase() {
 
    AirportStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "AirportJson.json", fileLocation: "Main Bundle")
   
    populateDatabase()
}
 
/*
*********************************************
MARK: - Populate Database If Not Already Done
*********************************************
*/
func populateDatabase() {
   
    // ❎ Get object reference of CoreData managedObjectContext from the persistent container
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    //----------------------------
    // ❎ Define the Fetch Request
    //----------------------------
    let fetchRequest = NSFetchRequest<AirportE>(entityName: "AirportE")
    fetchRequest.sortDescriptors = [
        // Primary sort key: artistName
        NSSortDescriptor(key: "name", ascending: true),
        // Secondary sort key: songName
        NSSortDescriptor(key: "city", ascending: true)
    ]
   
    var listOfAllSongEntitiesInDatabase = [AirportE]()
   
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        listOfAllSongEntitiesInDatabase = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Populate Database Failed!")
        return
    }
   
    if listOfAllSongEntitiesInDatabase.count > 0 {
        // Database has already been populated
        print("Database has already been populated!")
        return
    }
   
    print("Database will be populated!")
   
    for cont in AirportStructList {
        /*
         =====================================================
         Create an instance of the contact entity and dress it up
         =====================================================
        */
       
        // ❎ Create an instance of the up entity in CoreData managedObjectContext
        let airportEntity = AirportE(context: managedObjectContext)
        
        airportEntity.city = cont.city
        airportEntity.country = cont.country
        airportEntity.name = cont.name
        airportEntity.state = cont.state
       
        // ❎ Dress it up by specifying its attributes
        
//        contactEntity.lastName = cont.lastName
//        contactEntity.firstName = cont.firstName
//        contactEntity.email = cont.email
//        contactEntity.phone = cont.phone
//        contactEntity.company = cont.company
//        contactEntity.addressCity = cont.addressCity
//        contactEntity.addressCountry = cont.addressCountry
//        contactEntity.addressLine1 = cont.addressLine1
//        contactEntity.addressLine2 = cont.addressLine2
//        contactEntity.addressState = cont.addressState
//        contactEntity.addressZipcode = cont.addressZipcode
//        contactEntity.url = cont.url
//        contactEntity.notes = cont.notes
//
        /*
         ======================================================
         Create an instance of the Photo Entity and dress it up
         ======================================================
         */
       
//        // ❎ Create an instance of the Photo Entity in CoreData managedObjectContext
        let mapEntity = MapE(context: managedObjectContext)
        var ele = mapEntity.elevation!.doubleValue
        var lati = mapEntity.lat!.doubleValue
        var loni = mapEntity.long!.doubleValue
        ele = cont.elevation
        mapEntity.elevation = NSNumber(value: ele)
        lati = cont.lat
        mapEntity.lat = NSNumber(value: lati)
        loni = cont.lon
        mapEntity.long = NSNumber(value: loni)
        mapEntity.tz = cont.tz

        

        /*
         ==============================
         Establish Entity Relationships
         ==============================
        */
       
        // ❎ Establish Relationship between entities contact and Photo
        //songEntity.photo
        airportEntity.map = mapEntity
        mapEntity.airport = airportEntity
       
        /*
         ==================================
         Save Changes to Core Data Database
         ==================================
        */
       
        // ❎ CoreData Save operation
        do {
            try managedObjectContext.save()
        } catch {
            return
        }
       
    }   // End of for loop
 
}
 
