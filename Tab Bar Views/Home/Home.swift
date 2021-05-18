//
//  Home.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/1/20.
//

import SwiftUI
 
struct Home: View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    let captions = ["Hartsfield–Jackson Atlanta International Airport", "Los Angeles International Airport", "O'Hare International Airport", "Dallas/Fort Worth International Airport", "Denver International Airport", "John F. Kennedy International Airport", "San Francisco International Airport", "Seattle–Tacoma International Airport", "McCarran International Airport"]
   
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Image("Welcome")
                    .padding(.top, 50)
               
                Image("photo\(userData.imageNumber + 1)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.frame(minWidth: 500, maxWidth: 500, alignment: .center)
                    .frame(width: 400, height: 300, alignment: .center)
                    .padding(.top, 30)
                    .padding(.bottom, 5)
                    .padding(.horizontal)
               
                Text("\(self.captions[userData.imageNumber])")
                    .font(.subheadline)
                    .padding(.bottom, 5)
                    .multilineTextAlignment(.center)
               
                HStack {
                    Button(action: {    // Button 1
                        self.userData.imageNumber = 0
                    }) {
                        self.imageForButton(buttonNumber: 0)
                    }
                    Button(action: {    // Button 2
                        self.userData.imageNumber = 1
                    }) {
                        self.imageForButton(buttonNumber: 1)
                    }
                    Button(action: {    // Button 3
                        self.userData.imageNumber = 2
                    }) {
                        self.imageForButton(buttonNumber: 2)
                    }
                    Button(action: {    // Button 4
                        self.userData.imageNumber = 3
                    }) {
                        self.imageForButton(buttonNumber: 3)
                    }
                    Button(action: {    // Button 5
                        self.userData.imageNumber = 4
                    }) {
                        self.imageForButton(buttonNumber: 4)
                    }
                    Button(action: {    // Button 6
                        self.userData.imageNumber = 5
                    }) {
                        self.imageForButton(buttonNumber: 5)
                    }
                    Button(action: {    // Button 7
                        self.userData.imageNumber = 6
                    }) {
                        self.imageForButton(buttonNumber: 6)
                    }
                    Button(action: {    // Button 8
                        self.userData.imageNumber = 7
                    }) {
                        self.imageForButton(buttonNumber: 7)
                    }
                    Button(action: {    // Button 9
                        self.userData.imageNumber = 8
                    }) {
                        self.imageForButton(buttonNumber: 8)
                    }
                    
                }   // End of HStack
                    .imageScale(.medium)
                    .font(Font.title.weight(.regular))
                    .padding(.bottom, 30)
               
                // Show National Park Service API provider's website in default web browser
                //https://rapidapi.com/AirportGuide/api/airport-guide-aviation-info
                VStack{
                Link(destination: URL(string: "https://weatherbit.io/api")!) {
                    HStack {
                        Image("WeatherbitImage")
                            .resizable()
                            .frame(width: 100, height: 70)
                    }
                }
                .padding()
                Link(destination: URL(string: "https://developers.zomato.com/api")!) {
                    HStack {
                        Image("ZomatoImage")
                            .resizable()
                            .frame(width: 200, height: 70)
                    }
                }
                }
                .padding(.bottom, 100)
               
            }   // End of VStack
           
        }   // End of ScrollView
            .onAppear() {
                self.userData.startTimer()
            }
            .onDisappear() {
                self.userData.stopTimer()
            }
           
        }   // End of ZStack
    }
   
    func imageForButton(buttonNumber: Int) -> Image {
       
        if self.userData.imageNumber == buttonNumber {
            return Image(systemName: "\(buttonNumber+1).circle.fill")
        } else {
            return Image(systemName: "\(buttonNumber+1).circle")
        }
    }
   
}
 
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
