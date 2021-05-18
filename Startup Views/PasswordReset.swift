//
//  PasswordReset.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/1/20.
//

import SwiftUI

struct PasswordReset: View {
    @State private var answer = ""
    @State private var showValue = false
    var body: some View {
        Form{
            Section(header: Text("Show/Hide Entered Values")){
                HStack{
                    Toggle(isOn: $showValue) {
                                    Text("Show Entered Values")
                                }
                }
            }
            Section(header: Text("Security Question")){
                Text(question())
            }
            Section(header: Text("Enter Answer To Selected Security Question")){
                HStack{
                    if(showValue){
                    TextField("Enter Answer", text: $answer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Button(action: {
                        self.answer = ""
                    }){
                        Image(systemName: "clear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                }
                    else{
                        SecureField("Enter Answer", text: $answer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                        Button(action: {
                            self.answer = ""
                        }){
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                } // end HStack
            }
            if(answer == UserDefaults.standard.string(forKey: "Answer")){
                Section(header: Text("Go to Settings to Reset Password")){
                    NavigationLink(destination: AnyView(Settings())){
                        HStack{
                            Image(systemName: "gear")
                                .foregroundColor(.blue)
                                .font(Font.title.weight(.regular))
                                .imageScale(.medium)
                            Text("Show Settings")
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 500)
                }
            }
            else{
            Section(header: Text("Incorrect Answer")){
                Text("Answer to the Security Question is Incorrect!")
            }
            }
        }
    }
    func question() -> String{
        return UserDefaults.standard.string(forKey: "SecurityQuestion") ?? "Not Available"
    }
}

struct PasswordReset_Previews: PreviewProvider {
    static var previews: some View {
        PasswordReset()
    }
}
