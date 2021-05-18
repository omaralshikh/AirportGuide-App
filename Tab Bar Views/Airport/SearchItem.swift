//
//  SearchItem.swift
//  AirportGuide
//
//  Created by Omar on 12/8/20.
//

import SwiftUI

struct SearchItem: View {
    let airport: AirportE
    
    // ❎ CoreData FetchRequest returning all Contact entities in the database
    @FetchRequest(fetchRequest: AirportE.allTripsFetchRequest()) var allContacts: FetchedResults<AirportE>
   
    // ❎ Refresh tcontact: his view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all Contact entities with all the changes.
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        VStack{
        HStack {
            /*
            ?? is called nil coalescing operator.
            IF song.artistName is not nil THEN
                unwrap it and return its value
            ELSE return ""
            */
            Spacer()
            Image("AirportLogo")
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            }
            VStack{
                HStack{
                    Text("Airport:")
                    Text(airport.name ?? "")
                }
                HStack{
                    Text("City:")
                    Text(airport.city ?? "")
                }
                HStack{
                    Text("Country:")
                    Text(airport.country ?? "")
                }
            
            }
    }
        .font(.system(size: 14))
    }
}


