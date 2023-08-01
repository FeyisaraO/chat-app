//
//  AppState.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import Foundation

enum Route: Hashable {
    case main
    case login
    case signup
}

class AppState: ObservableObject {
    
    @Published var routes: [Route] = []
    
}
