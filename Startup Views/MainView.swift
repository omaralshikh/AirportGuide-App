//
//  MainView.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/1/20.
//

import SwiftUI
 
struct MainView: View {
    @State private var selectedBgColor = Color.gray.opacity(0.1)
    var body: some View {
        //TabView {
            ZStack{
            
            selectedBgColor
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    ColorPicker("", selection: $selectedBgColor)
                    .padding()
                }
            }
            TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            AirportList()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Airports")
                }
                
            Food()
                .tabItem {
                    Image(systemName: "flame")
                    Text("Food")
                }
                
            Weather()
                .tabItem {
                    Image(systemName: "cloud.sun")
                    Text("Weather")
                }
 
            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
 
           
        }   
    }
    }
}
 
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
