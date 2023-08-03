//
//  AppState.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import Foundation

enum LoadingState: Hashable, Identifiable {
    case idle
    case loading(String)
    
    var id: Self {
        return self
    }
}

enum Route: Hashable {
    case main
    case login
    case signup
}

class AppState: ObservableObject {
    
    @Published var loadingState: LoadingState = .idle
    @Published var routes: [Route] = []

}
