//
//  AirportDetails.swift
//  AirportGuide
//
//  Created by Omar on 12/2/20.
//

import SwiftUI
import MapKit
import CoreData



struct AirportDetails: View {
    let airport: AirportE
    //let map: MapE
    
    // ❎ CoreData FetchRequest returning all Contact entities in the database
    @FetchRequest(fetchRequest: AirportE.allTripsFetchRequest()) var allContacts: FetchedResults<AirportE>
   
    // ❎ Refresh tcontact: his view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all Contact entities with all the changes.
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        //Text("helo")
        
    Form {
     
        Section(header: Text("Airport Name")) {
            Text(airport.name ?? "")
        }
        Section(header: Text("Airport City")) {
            Text(airport.city ?? "")
        }
        Section(header: Text("Airport State")) {
            Text(airport.state ?? "")
        }
        Section(header: Text("Airport country")) {
            Text(airport.country ?? "")
        }
        Section(header: Text("Airport elevation")) {
            let elevationNSNumber = airport.map?.elevation ?? 0.0
            let elevationG = String(elevationNSNumber as! Int)
            Text(elevationG)
        }
        Section(header: Text("Aiport timezone")) {
            Text(airport.map?.tz ?? "")
        }
        Section(header: Text("show location map")) {
        NavigationLink(destination: placeLocationOnMap) {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .imageScale(.medium)
                    .font(Font.title.weight(.regular))
                Text("Show Location on Map")
                    .font(.system(size: 16))
            }
            .foregroundColor(.blue)
        }
        .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
    }

    }   // End of Form
    .navigationBarTitle(Text(airport.name ?? ""), displayMode: .inline)
        .font(.system(size: 14))
        
}
    
    var placeLocationOnMap: some View {
        return AnyView(MapView(mapType: MKMapType.standard, latitude: latfunc(), longitude: longfunc(), delta: 10.0, deltaUnit: "degrees", annotationTitle: airport.name ?? "", annotationSubtitle: airport.city ?? ""))
            .navigationBarTitle(Text("\(airport.name ?? "") Map"), displayMode: .inline)
            .edgesIgnoringSafeArea(.all)
    }
    
    func latfunc() -> Double {
        var lati = airport.map!.lat!.doubleValue ?? 0.0
        return lati
    }
    
    func longfunc() -> Double {
        var longi = airport.map!.long!.doubleValue ?? 0.0
        return longi
    }
    
    
}

