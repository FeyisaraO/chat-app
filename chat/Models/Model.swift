//
//  Model.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import Foundation
import FirebaseAuth

class Model: ObservableObject {
    
    func UpdateDisplayName(for user: User, displayName: String) async throws{
        //create user profile request,pass in new name, commit changes
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        try await request.commitChanges()
    }
    
}
