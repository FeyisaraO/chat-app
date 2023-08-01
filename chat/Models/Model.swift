//
//  Model.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class Model: ObservableObject {
    
    @Published var groups: [Group] = []
    
    func UpdateDisplayName(for user: User, displayName: String) async throws{
        //create user profile request,pass in new name, commit changes
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        try await request.commitChanges()
    }
    
    func populateGroups() async throws {
        let db = Firestore.firestore()
        let snapshot = try await db.collection("groups")
            .getDocuments()
        
        groups = snapshot.documents.compactMap { snapshot in
            //get a group based on snapshot
            Group.fromSnapshot(snapshot:snapshot)
        }
    }
    
    func saveGroup(group: Group, completion: @escaping(Error?) -> Void){
        //get access to db and name collection
        let db = Firestore.firestore()
        var docRef: DocumentReference? = nil
        docRef = db.collection("groups")
            .addDocument(data: group.toDictionary()) { [weak self] error in
                if error != nil{
                    completion(error)
                } else {
                    //add group to groups array
                    if let docRef {
                        var newGroup = group
                        newGroup.documentId = docRef.documentID
                        self?.groups.append(newGroup)
                        completion(nil)
                    } else {
                        completion(nil)
                    }
                }
            }
    }
    
}
