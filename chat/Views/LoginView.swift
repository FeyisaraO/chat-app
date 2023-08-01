//
//  LoginView.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State private var email:String = ""
    @State private var password:String = ""
    
    private var isFormValid: Bool{
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    private func login() async {
        
        do {
           let _ = try await Auth.auth().signIn(withEmail: email, password: password)
            //go to main screen
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    var body: some View {
        Form{
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            
            HStack{
                Spacer()
                
                Button("Login"){
                    Task{
                        await login()
                    }
                }
                .disabled(!isFormValid)
                .buttonStyle(.borderless)
                
                Button("Sign Up"){
                    //go to sign up
                }.buttonStyle(.borderless)
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
