//
//  SignUpView.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var displayName:String = ""
    
    private var isFormValid: Bool{
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !displayName.isEmptyOrWhiteSpace
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
                        
                    }
                }
                .disabled(!isFormValid)
                .buttonStyle(.borderless)
                
                Button("Login"){
                    //take to login screen
                }.buttonStyle(.borderless)
                
                Spacer()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
