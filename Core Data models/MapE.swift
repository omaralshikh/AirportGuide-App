//
//  MapE.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/6/20.
//

import Foundation
import CoreData
 
/*
 🔴 Set Current Product Module:
    In xcdatamodeld editor, select Photo, show Data Model Inspector, and
    select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
    In xcdatamodeld editor, select Photo, show Data Model Inspector, and
    select Manual/None from Codegen menu.
*/
 
// ❎ CoreData Photo entity public class
public class MapE: NSManagedObject, Identifiable {
 
    @NSManaged public var elevation: NSNumber?
    @NSManaged public var lat: NSNumber?
    @NSManaged public var long: NSNumber?
    @NSManaged public var tz: String?
    @NSManaged public var airport: AirportE?
}


