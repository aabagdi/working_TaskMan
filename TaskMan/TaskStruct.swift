//
//  TaskStruct.swift
//  TaskMan
//
//  Created by Aadit Bagdi on 7/2/23.
//

import Foundation
import SwiftUI


struct TaskOld : Hashable, Identifiable {
    let name : String
    let date : Date
    let tag : String
    let id = UUID()
    
    func returnDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        return formatter.string(from: self.date)
    }
}


