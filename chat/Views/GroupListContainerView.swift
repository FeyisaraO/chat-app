//
//  GroupListContainerView.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import SwiftUI

struct GroupListContainerView: View {
    
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: Model
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button("New Group"){
                    isPresented = true
                }
            }
            
            GroupListView(groups: model.groups)
            
            Spacer()
        }
        .task{
            do{
                try await model.populateGroups()
            } catch {
                print(error)
            }
        }
        .padding()
        .sheet(isPresented: $isPresented) {
           AddNewGroupView()
        }
    }
}

struct GroupListContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListContainerView()
            .environmentObject(Model())
    }
}
