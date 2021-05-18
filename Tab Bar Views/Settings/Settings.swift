//
//  Settings.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/1/20.
//

import SwiftUI
struct Settings: View {
    
    @State private var passwordEntered = ""
    @State private var passwordVerified = ""
    @State private var answer = ""
    @State private var showPassword = false
    @State private var showUnmatchedPasswordAlert = false
    @State private var showPasswordSetAlert = false
    @State private var selectedIndexFrom = 0
    @State private var selectedIndex = 1
    let questionsList = ["In what city or town did your mother and father meet?", "In what city or town were you born?", "What did you want to be when you grew up?", "What do you remember most from your childhood?", "What is the name of the boy or girl that you frist kissed?", "What is the name of the first school you attended?", "What is the name of your favorite childhood friend?", "What is the name of your first pet?", "What is your mother's maiden name?", "What was your favorite place to visit as a child?"]
    
   
    var body: some View {
        NavigationView{
        Form{
            Section(header: Text("Show/Hide Entered Values")){
                HStack{
                    Toggle(isOn: $showPassword) {
                                    Text("Show Entered Values")
                                }
                }
            }
            Section(header: Text("Select a Security Question")){
                Picker("Selected:", selection: $selectedIndexFrom) {
                    ForEach(0 ..< questionsList.count, id: \.self) {
                        Text(questionsList[$0])
                    }
                    
                }
                .frame(minWidth: 300, maxWidth: 500)
                
            }
            Section(header: Text("Enter Answer To Selected Security Question")){
                HStack{
                    if self.showPassword{
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
            } // end Section
            Section(header: Text("Enter Password")){
                HStack{
                    if self.showPassword{
                    TextField("Enter Password", text: $passwordEntered)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    Button(action: {
                        self.passwordEntered = ""
                    }){
                        Image(systemName: "clear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                    }
                    else{
                        SecureField("Enter Password", text: $passwordEntered)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                        Button(action: {
                            self.passwordEntered = ""
                        }){
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                } // end HStack
            } // end Section
            Section(header: Text("Verify Password")){
                HStack{
                    if self.showPassword{
                    TextField("Verify Password", text: $passwordVerified)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    Button(action: {
                        self.passwordVerified = ""
                    }){
                        Image(systemName: "clear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                    }
                    else{
                        SecureField("Verify Password", text: $passwordVerified)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                        Button(action: {
                            self.passwordVerified = ""
                        }){
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                }
            }
            Section(header: Text("Set Password")){
                Button(action: {
                                    if !passwordEntered.isEmpty {
                                        if passwordEntered == passwordVerified {
                                            /*
                                             UserDefaults provides an interface to the user’s defaults database,
                                             where you store key-value pairs persistently across launches of your app.
                                             */
                                            // Store the password in the user’s defaults database under the key "Password"
                                            UserDefaults.standard.set(self.passwordEntered, forKey: "Password")
                                            UserDefaults.standard.set(self.questionsList[selectedIndex], forKey: "SecurityQuestion")
                                            UserDefaults.standard.set(self.answer, forKey: "Answer")
                                           
                                            self.passwordEntered = ""
                                            self.passwordVerified = ""
                                            self.showPasswordSetAlert = true
                                        } else {
                                            self.showUnmatchedPasswordAlert = true
                                        }
                                    }
                                }) {
                                    Text("Set Password to Unlock App")
                                        .frame(width: 300, height: 36, alignment: .center)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .strokeBorder(Color.black, lineWidth: 1)
                                        )
                                }
                                .alert(isPresented: $showUnmatchedPasswordAlert, content: { self.unmatchedPasswordAlert })
            }
            
        }
        .navigationBarTitle(Text("Settings"), displayMode: .inline)
        
    }   // End of var
    } // end NaviagtionView
    /*
     --------------------------
     MARK: - Password Set Alert
     --------------------------
     */
    var passwordSetAlert: Alert {
        Alert(title: Text("Password Set!"),
              message: Text("Password you entered is set to unlock the app!"),
              dismissButton: .default(Text("OK")) )
    }
   
    /*
     --------------------------------
     MARK: - Unmatched Password Alert
     --------------------------------
     */
    var unmatchedPasswordAlert: Alert {
        Alert(title: Text("Unmatched Password!"),
              message: Text("Two entries of the password must match!"),
              dismissButton: .default(Text("OK")) )
    }
 //end NaviagtionView
}
 
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
