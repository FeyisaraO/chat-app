//
//  String+Extensions.swift
//  chat
//
//  Created by Feyisara Odukoya on 01/08/2023.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
