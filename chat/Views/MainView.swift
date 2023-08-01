//
//  MainView.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            GroupListContainerView()
                .tabItem {
                    Label("Chats", systemImage: "message.fill")
                }
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
