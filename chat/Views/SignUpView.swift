//
//  SignUpView.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var displayName:String = ""
    @State private var errorMessage:String = ""
    
    @EnvironmentObject private var model: Model

    
    private var isFormValid: Bool{
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !displayName.isEmptyOrWhiteSpace
    }
    
    private func signUp() async {
        
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await model.UpdateDisplayName(for: result.user, displayName: displayName)
        } catch{
            errorMessage = error.localizedDescription
        }
        
    }

    
    var body: some View {
        Form{
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)
            TextField("Display name", text: $displayName)
            
            HStack{
                Spacer()
                
                Button("Sign Up"){
                    Task{
                        await signUp()
                    }
                }
                .disabled(!isFormValid)
                .buttonStyle(.borderless)
                
                Button("Login"){
                    //take to login screen
                }.buttonStyle(.borderless)
                
                Spacer()
            }
            
            Text(errorMessage)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(Model())
    }
}
