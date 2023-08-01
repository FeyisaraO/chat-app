//
//  GroupDetailView.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import SwiftUI
import FirebaseAuth

struct GroupDetailView: View {
    
    let group: Group
    @State private var chatText: String = ""
    @EnvironmentObject private var model: Model
    
    private func sendMessage() async throws {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let chatMessage = ChatMessage(text: chatText, uid: currentUser.uid, displayName: currentUser.displayName ?? "Guest")
        
        try await model.saveChatMessageToGroup(chatMessage: chatMessage, group: group)
    }
    
    var body: some View {
        VStack{
            ChatMessageListView(chatMessages: model.chatMessages)
            Spacer()
            TextField("Message", text: $chatText)
            
            Button("Send"){
                Task{
                    do{
                        try await sendMessage()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .padding()
        .onDisappear{
            model.detachFirebaseListener()
        }
        .onAppear{
            model.listenForChatMessages(in: group)
        }
    }
}

struct GroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailView(group: Group(subject: "Barbie Dream House"))
            .environmentObject(Model())
    }
}
