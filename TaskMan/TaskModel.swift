//
//  TaskModel.swift
//  TaskMan
//
//  Created by Aadit Bagdi on 8/6/23.
//

import Foundation
import SwiftUI

extension TaskView {
    @MainActor class TaskModel : ObservableObject {
        @Environment(\.dismiss) var dismiss
        @Environment(\.managedObjectContext) var moc

        @Published var taskName : String = ""
        @Published var taskDate : Date = Date()
        @Published var taskTag : String = ""
        @Published var showingAlert = false
        
        func saveTask() {
            if taskName != "" {
                let newTask = Task(context: moc)
                newTask.name = taskName
                newTask.date = taskDate
                newTask.tag = taskTag
                try? moc.save()
                dismiss()
            }
            else {
                showingAlert.toggle()
            }
        }
    }
}
