//
//  Extensions.swift
//  TaskMan
//
//  Created by Aadit Bagdi on 8/6/23.
//

import Foundation

extension Date {
    func reformat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, MMM dd, yyyy"
        return formatter.string(from: self)
    }
}

extension Task {
    var viewName: String {
        name ?? "No task name"
    }

    var viewDate: Date {
        date ?? Date()
    }

    var viewTag: String {
        tag ?? ""
    }
}
