//
//  LoginView.swift
//  AirportGuide
//
//  Created by Ubair Nasir on 12/1/20.
//
import LocalAuthentication
import SwiftUI
 
struct LoginView : View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    @State private var isUnlocked = false
   
    @State private var enteredPassword = ""
    @State private var showInvalidPasswordAlert = false
    @State private var showValue = false
   
    var body: some View {
        NavigationView{
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                if self.isUnlocked{
                }
                else {
                    VStack {
                        Image("Welcome")
                            .padding(.top, 30)
                       
                        Text("Airport Guide")
                            .font(.headline)
                            .padding()
                       
                        Image("DataProtection")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 300, maxWidth: 600)
                            .padding()
                       
                        SecureField("Password", text: $enteredPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: 36)
                            .padding()
                        HStack{
                        Button(action: {
                            /*
                             UserDefaults provides an interface to the user’s defaults database,
                             where you store key-value pairs persistently across launches of your app.
                             */
                            // Retrieve the password from the user’s defaults database under the key "Password"
                            let validPassword = UserDefaults.standard.string(forKey: "Password")
                           
                            /*
                             If the user has not yet set a password, validPassword = nil
                             In this case, allow the user to login.
                             */
                           
                            if validPassword == nil || self.enteredPassword == validPassword {
                                userData.userAuthenticated = true
                                self.showInvalidPasswordAlert = false
                            } else {
                                self.showInvalidPasswordAlert = true
                            }
                           
                        }) {
                            Text("Login")
                                .frame(width: 150, height: 36, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(Color.black, lineWidth: 1)
                                )
                        }
                        
                        if(UserDefaults.standard.string(forKey: "SecurityQuestion") != nil){
                            NavigationLink(destination: PasswordReset()){
                                Text("Forgot Password")
                                    .frame(width: 200, height: 36, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .strokeBorder(Color.black, lineWidth: 1)
                                    )
                            }
                            .padding()
                        }
                        
                   
                        }
                        .alert(isPresented: $showInvalidPasswordAlert, content: { self.invalidPasswordAlert })
                    }
                    //Text("Didn't work")
                }
            }
            .onAppear(perform: authenticate)

        }   // End of ScrollView
        }   // End of ZStack
        }
    }   // End of var
    

   
    /*
     ------------------------------
     MARK: - Invalid Password Alert
     ------------------------------
     */
    var invalidPasswordAlert: Alert {
        Alert(title: Text("Invalid Password!"),
              message: Text("Please enter a valid password to unlock the app!"),
              dismissButton: .default(Text("OK")) )
       
        // Tapping OK resets @State var showInvalidPasswordAlert to false.
    }
   
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        // authenticated successfully
                        self.isUnlocked = true
                        userData.userAuthenticated = true
                    } else {
                        // there was a problem
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}
 
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
