//
//  Search.swift
//  AirportGuide
//
//  Created by Omar on 12/8/20.
//

import SwiftUI
import CoreData
var searchCategory = ""
var searchQuery = ""

struct Search: View {
    
    let searchCategoriesList = ["Name", "City", "State"]
    
    @State private var selectedSearchCategoryIndex = 1
    @State private var searchFieldValue = ""
    @State private var genreSearchQuery = ""
    @State private var ratingSearchQuery = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    HStack{
                        Spacer()
                    Image("SearchDatabase")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:100)
                        Spacer()
                    }
                }
                Section(header: Text("Select a Search Category")) {
                  
                    Picker("", selection: $selectedSearchCategoryIndex) {
                        ForEach(0 ..< searchCategoriesList.count, id: \.self) {
                            Text(self.searchCategoriesList[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                   
                }
                    Section(header: Text("Search Query under Selected Category")) {
                        HStack {
                            TextField("Enter Search Query", text: $searchFieldValue)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .autocapitalization(.words)
                                .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                          
                            // Button to clear the text field
                            Button(action: {
                                self.searchFieldValue = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }   // End of HStack
                        .padding(.horizontal)
                    }
                   
                Section(header: Text("Show Search Results")) {
                    NavigationLink(destination: showSearchResults()) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Show Search Results")
                                .font(.headline)
                        }
                    }
                }
           
            }   // End of Form
            .navigationBarTitle(Text("Search"), displayMode: .inline)
            
        }   // End of NavigationView
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
    }
   
    func showSearchResults() -> some View {
            let queryTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
            if (queryTrimmed.isEmpty) {
                return AnyView(missingSearchQueryMessage)
            }
            searchCategory = self.searchCategoriesList[self.selectedSearchCategoryIndex]
            searchQuery = self.searchFieldValue
       
        return AnyView(SearchResultsList())
    }
   
    var missingSearchQueryMessage: some View {
        ZStack {
            Color(red: 1.0, green: 1.0, blue: 240/255) // Ivory color)
        
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
                .padding()
            Text("Search Query Missing!\nPlease enter a search query to be able to search the database!")
                .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
   
    }
    }
 
}
 
 
