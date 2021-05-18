//
//  Food.swift
//  AirportGuide
//
//  Created by Omar on 12/2/20.
//

import SwiftUI

struct Food: View {
    @State private var searchFieldValue = ""
    @State private var showMissingInputDataAlert = false
    @State private var searchCompleted = false
    @State private var showProgressView = false

    
    var body: some View {
        NavigationView {
                    ZStack {
                        Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                    Form {
                        Section(header: Text("nearby food")) {
                            HStack {
                                TextField("Enter Radius in meters", text: $searchFieldValue)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.default)
                                    .autocapitalization(.words)
                                    .disableAutocorrection(true)
                               
                                // Button to clear the text field
                                Button(action: {
                                    self.searchFieldValue = ""
                                    self.showMissingInputDataAlert = false
                                    self.searchCompleted = false
                                }) {
                                    Image(systemName: "clear")
                                        .imageScale(.medium)
                                        .font(Font.title.weight(.regular))
                                }
                            }   // End of HStack
                                .frame(minWidth: 300, maxWidth: 500)
                                .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })
                           
                        }   // End of Section
                                            
                        Section(header: Text("Search ")) {
                            HStack {
                                Button(action: {
                                    if self.inputDataValidated() {
                                        self.showProgressView = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            /*
                                             Execute the following code after 0.1 second of delay
                                             so that they are not executed during the view update.
                                             */
                                            self.searchApi()
                                            self.showProgressView = false

                                            self.searchCompleted = true
                                        }
                                    } else {
                                        self.showMissingInputDataAlert = true
                                    }
                                }) {
                                    Text(self.searchCompleted ? "Search Completed" : "Search")
                                }
                                .frame(width: 240, height: 36, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(Color.black, lineWidth: 1)
                                )
                            }   // End of HStack
                        }
                        HStack{
                        Section(){
                            Spacer()
                            Image("Emoji_Round_2_monks")
                                .resizable()
                                .frame(width: 300, height: 300)
                            Spacer()
                        }
                        }
                        if showProgressView {
                                           Section {
                                               ProgressView()
                                                   // Style defined in ProgressViewStyle.swift
                                                   .progressViewStyle(DarkBlueShadowProgressViewStyle())
                                           }
                                       }
                       
                        if searchCompleted {
                            Section(header: Text("obtain food places")) {
                                NavigationLink(destination: showSearchResults) {
                                    HStack {
                                        Image(systemName: "gear")
                                            .imageScale(.medium)
                                            .font(Font.title.weight(.regular))
                                            .foregroundColor(.blue)
                                        Text("Obtain food places")
                                            .font(.system(size: 16))
                                    }
                                }
                                .frame(minWidth: 300, maxWidth: 500)
                            }
                        }
                       
                    }   // End of Form
                        .navigationBarTitle(Text("Food Search"), displayMode: .inline)
                        .onAppear() {
                            self.searchCompleted = false
                        }
                       
                    }   // End of ZStack
                   
                }   // End of NavigationView

               
            }   // End of body
           
            /*
            ------------------
            MARK: - Search API
            ------------------
            */
            func searchApi() {
//                // Remove spaces, if any, at the beginning and at the end of the entered search query string
                let parkNameTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
//
//                // public function getApiDataByNationalParkName is given in SearchByNameApiData.swift
//                getApiDataBycityName(parkName: parkNameTrimmed)
                getNutritionDataFromApi(upc: parkNameTrimmed)
                
            }
           
            /*
            ---------------------------
            MARK: - Show Search Results
            ---------------------------
            */
            var showSearchResults: some View {
               
                // Global variable nationalParkFound is given in SearchByNameApiData.swift
                if foodFoundArray.isEmpty {
                    return AnyView(notFoundMessage)
                }

                return AnyView(FoodLists(food: foodFoundArray))
            }
           
            /*
            ------------------------------
            MARK: - Park Not Found Message
            ------------------------------
            */
            var notFoundMessage: some View {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .imageScale(.large)
                        .font(Font.title.weight(.medium))
                        .foregroundColor(.red)
                        .padding()
                    Text("No Food data Found!\n\nThe API did not return a Food place under the entered radius \(self.searchFieldValue). Please try to increase the radius as required by the API.")
                        .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color(red: 1.0, green: 1.0, blue: 240/255))     // Ivory color
            }
           
            /*
             --------------------------------
             MARK: - Missing Input Data Alert
             --------------------------------
             */
            var missingInputDataAlert: Alert {
                Alert(title: Text("The Search Field is Empty!"),
                      message: Text("Please enter a food name to search for!"),
                      dismissButton: .default(Text("OK")))
                /*
                 Tapping OK resets @State var showMissingInputDataAlert to false.
                 */
            }
           
            /*
             -----------------------------
             MARK: - Input Data Validation
             -----------------------------
             */
            func inputDataValidated() -> Bool {
               
                // Remove spaces, if any, at the beginning and at the end of the entered search query string
                let queryTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
               
                if queryTrimmed.isEmpty {
                    return false
                }
                return true
            }
           
        }
