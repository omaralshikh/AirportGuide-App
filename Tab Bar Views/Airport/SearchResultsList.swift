//
//  SearchResultsList.swift
//  AirportGuide
//
//  Created by Omar on 12/8/20.
//

import SwiftUI

struct SearchResultsList: View {
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
   
    // ❎ CoreData FetchRequest returning filtered Song entities from the database
    @FetchRequest(fetchRequest: AirportE.filteredTravelFetchRequest(searchCategory: searchCategory, searchQuery: searchQuery)) var filteredContacts: FetchedResults<AirportE>
   
    var body: some View {
        if self.filteredContacts.isEmpty {
            SearchResultsEmpty()
        } else {
            List {
                /*
                 Each NSManagedObject has internally assigned unique ObjectIdentifier
                 used by ForEach to display the Songs in a dynamic scrollable list.
                 */
                ForEach(self.filteredContacts) { aContact in
                    NavigationLink(destination: SearchDetails(airport: aContact)) {
                        SearchItem(airport: aContact)
                    }
                }
               
            }   // End of List
            .navigationBarTitle(Text("Airports Found"), displayMode: .inline)
        }   // End of if
    }
}
 
struct SearchResultsList_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsList()
    }
}
 
