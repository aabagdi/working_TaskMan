//
//  TaskStruct.swift
//  TaskMan
//
//  Created by Aadit Bagdi on 7/2/23.
//

import Foundation
import SwiftUI


struct Task : Hashable, Identifiable {
    let name : String
    let date : Date
    let tag : String
    var isComplete : Bool =  false
    let id = UUID()
}


