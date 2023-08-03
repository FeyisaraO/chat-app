//
//  image+Extension.swift
//  chat
//
//  Created by Feyisara Odukoya on 02/08/2023.
//

import Foundation
import SwiftUI

extension Image {
    
    func rounded(width: CGFloat = 100, height: CGFloat = 100) -> some View {
        return self.resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
    
}
