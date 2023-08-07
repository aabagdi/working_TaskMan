//
//  TaskView.swift
//  TaskMan
//
//  Created by Aadit Bagdi on 7/2/23.
//

import Foundation
import SwiftUI

struct TaskView : View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc

    @State var taskName : String = ""
    @State var taskDate : Date = Date()
    @State var taskTag : String = ""
    @State private var showingAlert = false

    
    var body: some View {
        VStack {
            List {
                TextField("Task name", text: $taskName)
                
                DatePicker(
                    "Task time",
                    selection: $taskDate,
                    in: Date.now...,
                    displayedComponents: [.date, .hourAndMinute])
                
                TextField("Tag (Optional)", text: $taskTag)
            }
            Button("Save Task") {
                if taskName != "" {
                    let newTask = Task(context: moc)
                    newTask.name = taskName
                    newTask.date = taskDate
                    newTask.tag = taskTag
                    newTask.id = UUID()
                    try? moc.save()
                    dismiss()
                }
                else {
                    showingAlert.toggle()
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Hey!"), message: Text("Your task is missing a name!"), dismissButton: .default(Text("Got it!")))
            }
        }
    }
}
