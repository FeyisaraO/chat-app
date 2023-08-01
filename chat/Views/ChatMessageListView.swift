//
//  ChatMessageListView.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import SwiftUI

struct ChatMessageListView: View {
    
    let chatMessages: [ChatMessage]
    
    var body: some View {
        List(chatMessages){ chatMessage in
            Text(chatMessage.text)
        }
    }
}

struct ChatMessageListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageListView(chatMessages: [])
    }
}
