//
//  FoodLists.swift
//  AirportGuide
//
//  Created by Omar on 12/2/20.
//

import SwiftUI
 
struct FoodLists: View {
      
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    let food: [FoodStruct]
  
    var body: some View {
        NavigationView {
            List {
                ForEach(food) { aVoiceMemo in
                    NavigationLink(destination: FoodDetails(food: aVoiceMemo)) {
                        FoodItems(food: aVoiceMemo)
                    }
                }
                //.onDelete(perform: delete)
                //.onMove(perform: move)
              
            }   // End of List
            .navigationBarTitle(Text("Food Nearby"), displayMode: .inline)
          
            // Place the Edit button on left and Add (+) button on right of the navigation bar
            
          
        }   // End of NavigationView
        // Use single column navigation view for iPhone and iPad
        .navigationViewStyle(StackNavigationViewStyle())
    }
  
    
}
