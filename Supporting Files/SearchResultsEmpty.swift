//
//  SearchResultsEmpty.swift
//  MyContacts
//
//  Created by Omar on 12/7/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI
 
struct SearchResultsEmpty: View {
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 1.0, blue: 240/255) // Ivory color)
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
                .padding()
            Text("Database Search Produced No Results!\n\nDatabase search did not return any value for the given query!")
                .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                .multilineTextAlignment(.center)
                .padding()
        }
        }
        
    }
}
 
struct SearchResultsEmpty_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsEmpty()
    }
}
 
