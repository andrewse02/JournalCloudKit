//
//  Date+String.swift
//  Journal-CK
//
//  Created by Andrew Elliott on 4/11/22.
//

import Foundation

extension Date {
    func asShortString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
