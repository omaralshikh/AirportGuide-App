//
//  AirportList.swift
//  AirportGuide
//
//  Created by Omar on 12/2/20.
//

import SwiftUI
import CoreData

struct AirportList: View {
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
   
    // ❎ CoreData FetchRequest returning all Contact entities in the database
    @FetchRequest(fetchRequest: AirportE.allTripsFetchRequest()) var allContacts: FetchedResults<AirportE>
   
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all Song entities with all the changes.
    @EnvironmentObject var userData: UserData
    
    //let airport: AirportStruct
    
    var body: some View {
        NavigationView {
            List {
                /*
                 Each NSManagedObject has internally assigned unique ObjectIdentifier
                 used by ForEach to display the Songs in a dynamic scrollable list.
                 */
                ForEach(self.allContacts) { aAirport in
                    NavigationLink(destination: AirportDetails(airport: aAirport)) {
                        AirportItem(airport: aAirport)
                    }
                }
                .onDelete(perform: delete)
               
            }   // End of List
            .navigationBarTitle(Text("Airports"), displayMode: .inline)
           
            // Place the Edit button on left and Add (+) button on right of the navigation bar
            .navigationBarItems(leading: EditButton(), trailing:
                NavigationLink(destination: Search()) {
                    Image(systemName: "magnifyingglass.circle.fill")
                })
           
        }   // End of NavigationView
            // Use single column navigation view for iPhone and iPad
            .navigationViewStyle(StackNavigationViewStyle())
    }
   
    /*
     ----------------------------
     MARK: - Delete Selected Song
     ----------------------------
     */
    func delete(at offsets: IndexSet) {
       
        let songToDelete = self.allContacts[offsets.first!]
       
        // ❎ CoreData Delete operation
        self.managedObjectContext.delete(songToDelete)
 
        // ❎ CoreData Save operation
        do {
          try self.managedObjectContext.save()
        } catch {
          print("Unable to delete selected song!")
        }
    }
 
}
