//
//  AirportE.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/6/20.
//


import Foundation
import CoreData
 
/*
 🔴 Set Current Product Module:
    In xcdatamodeld editor, select Song, show Data Model Inspector, and
    select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
    In xcdatamodeld editor, select Song, show Data Model Inspector, and
    select Manual/None from Codegen menu.
*/
 
// ❎ CoreData Song entity public class
public class AirportE: NSManagedObject, Identifiable {
 
    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?

    @NSManaged public var map: MapE?
}
 
extension AirportE {
    /*
     ❎ CoreData @FetchRequest in SongsList.swift invokes this Song class method
        to fetch all of the Song entities from the database.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as Song.allSongsFetchRequest() in any .swift file in your project.
     */
    static func allTripsFetchRequest() -> NSFetchRequest<AirportE> {
       
        let request: NSFetchRequest<AirportE> = AirportE.fetchRequest() as! NSFetchRequest<AirportE>
        /*
         List the songs in alphabetical order with respect to artistName;
         If artistName is the same, then sort with respect to songName.
         */
        request.sortDescriptors = [
            // Primary sort key: artistName
            NSSortDescriptor(key: "name", ascending: true),
            // Secondary sort key: songName
            NSSortDescriptor(key: "state", ascending: true)
        ]
       
        return request
    }
   
    /*
     ❎ CoreData @FetchRequest in SearchDatabase.swift invokes this Song class method
        to fetch filtered Song entities from the database for the given search query.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as Song.filteredSongsFetchRequest() in any .swift file in your project.
     */
    static func filteredTravelFetchRequest(searchCategory: String, searchQuery: String) -> NSFetchRequest<AirportE> {
       
        let fetchRequest = NSFetchRequest<AirportE>(entityName: "AirportE") //Travel
       
        /*
         List the found songs in alphabetical order with respect to artistName;
         If artistName is the same, then sort with respect to songName.
         */
        fetchRequest.sortDescriptors = [
            // Primary sort key: artistName
            NSSortDescriptor(key: "name", ascending: true),
            // Secondary sort key: songName
            NSSortDescriptor(key: "state", ascending: true)
        ]
       
        // Case insensitive search [c] for searchQuery under each category
        switch searchCategory {
        case "Name":
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@", searchQuery)
        case "City":
            fetchRequest.predicate = NSPredicate(format: "city CONTAINS[c] %@", searchQuery)
        case "State":
            fetchRequest.predicate = NSPredicate(format: "state CONTAINS[c] %@", searchQuery)
        default:
            print("Search category is out of range")
        }
       
        return fetchRequest
    }
}

