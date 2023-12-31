//
//  PreviewImageView.swift
//  chat
//
//  Created by Feyisara Odukoya on 03/08/2023.
//

import SwiftUI

struct PreviewImageView: View {
    
    let selectedImage: UIImage
    var onCancel: () -> Void
    
    var body: some View {
        ZStack {
            Image(uiImage: selectedImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }.overlay(alignment: .top) {
            Button {
                onCancel()
            } label: {
                Image(systemName: "multiply.circle.fill")
                    .padding([.top], 10)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
        }
    }
}

