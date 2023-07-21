//
//  ContentView.swift
//  TaskMan
//
//  Created by Aadit Bagdi on 7/1/23.
//

import SwiftUI

struct MainView: View {
    @State var taskArray : [Task] = []
    @State var showTask = false
    @State var currentTime : Date = Date.now

    
    var body: some View {
        VStack {
            NavigationStack {
                List($taskArray) { $task in
                    HStack {
                        Image(systemName: task.isComplete ? "checkmark.square" : "square")
                            .onTapGesture {
                                task.isComplete.toggle()
                                let newTasks = taskArray.filter { $0.id != task.id }
                                taskArray = newTasks
                            }
                        Text(task.name)
                        Spacer()
                        Text(task.tag)
                            .font(.caption)
                    }
                }
                    
                    Button("Add a new task") {
                        showTask.toggle()
                    }
                    .sheet(isPresented: $showTask) {
                        TaskView(taskArray: $taskArray)
                            .presentationDetents([.fraction(0.305)])
                            .presentationDragIndicator(.hidden)
                    }
                    .navigationTitle("Your tasks")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .ignoresSafeArea()
        }
    }
}
