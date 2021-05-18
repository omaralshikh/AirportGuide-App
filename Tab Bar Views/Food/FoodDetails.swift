//
//  FoodDetails.swift
//  AirportGuide
//
//  Created by Omar on 12/2/20.
//


import SwiftUI
import AVFoundation
import MapKit

 
struct FoodDetails: View {
   
    // Input Parameter passed by value
    let food: FoodStruct
    @EnvironmentObject var userData: UserData
    //@EnvironmentObject var audioPlayer: AudioPlayer
   
    var body: some View {
        Form {
            Section(header: Text("Restaurant Name")) {
                Text(food.name)
            }
            Section(header: Text("Feature Image")) {
                HStack {
                    //Image(food.featured_image)
                    getImageFromUrl(url: food.featured_image, defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100.0)
                }
            }
            Section(header: Text("Rating")) {
                Text(food.aggregate_rating.description)
            }
            Section(header: Text("Address")){
                Text(food.address)
            }
            Section(header: Text("Average Cost for two people")){
                Text("$" + food.average_cost_for_two.description)
            }
            Section(header: Text("Hours of Operation")) {
                Text(food.timings)
            }
            Section(header: Text("Phone Number")){
                HStack{
                    Image(systemName: "phone.circle")
                    Text(food.phone_numbers)
                }
            }
            Section(header: Text("Offered Cuisines")) {
                Text(food.cuisines)
            }
            Section(header: Text("Restaurant Menu Link")){
                NavigationLink(destination:
                                WebView(url: "\(food.menu_url)")
                                .navigationBarTitle(Text("Link"), displayMode: .inline)
                ){
                    HStack{
                        Image(systemName: "globe")
                            .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Restaurant Website")
                            .font(.system(size: 16))
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                }
                .navigationBarTitle(Text("Restaurant Details"), displayMode: .inline)
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
        Group {
            HStack{
            Section() {
                /*
                 share button
                 */
            Button(action: actionSheet) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
            }.padding(.trailing, 200.0)
            }
            Section() {
                /*
                 map directions from user's location to restaurant
                 */
            Button(action: navigate) {
                        Image(systemName: "car")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
                    }
            }
            }
        }
        .font(.system(size: 14))
        .navigationBarTitle(Text("\(food.name) Detail"), displayMode: .inline)
    }   // End of body
    func actionSheet() {
        guard let data = URL(string: food.menu_url) else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    /*
     navigates the user to the apple maps application in order to get directions to the restaurant
     the user from there can select many forms of transportation but the default is by car
     */
    func navigate() {
        let coordinate = CLLocationCoordinate2DMake(Double(food.latitude)!,Double(food.longitude)!)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    func returnLat () -> Double? {
        let lati = food.latitude
        //var long = food.longitude
        let doubLat = Double(lati)
        return doubLat
    }
    func returnLon () -> Double? {
        let long = food.longitude
        //var long = food.longitude
        let doubLon = Double(long)
        return doubLon
    }

    
        var placeLocationOnMap: some View {
                        
            return AnyView( MapView(mapType: MKMapType.standard, latitude: returnLat() ?? 0.0, longitude: returnLon() ?? 0.0, delta: 10.0, deltaUnit: "degrees", annotationTitle: food.name, annotationSubtitle: food.phone_numbers)
                                .navigationBarTitle(Text("\(food.name) Map"), displayMode: .inline)
                    .edgesIgnoringSafeArea(.all) )

            
        }
 
}
