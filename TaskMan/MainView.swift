//
//  ContentView.swift
//  TaskMan
//
//  Created by Aadit Bagdi on 7/1/23.
//

import SwiftUI

struct MainView: View {
    //@State var taskArray : [Task] = []
    @State var showTask = false
    @FetchRequest(sortDescriptors: []) var taskArray: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        VStack {
                List(taskArray) { task in
                    HStack {
                        Image(systemName: "square")
                            .onTapGesture {
                                moc.delete(task)
                                try? moc.save()
                            }
                        VStack(alignment: .leading) {
                            Text("**\(task.name ?? "error")**")
                            Text("**\(task.date!.reformat())**")
                                .font(.caption)
                        }
                        Spacer()
                        Text(task.tag ?? "")
                            .font(.caption)
                    }
                }
                    
                    Button("Add a new task") {
                        showTask.toggle()
                    }
                    .sheet(isPresented: $showTask) {
                        TaskView()
                            .presentationDetents([.fraction(0.305)])
                            .presentationDragIndicator(.hidden)
                    }
                    .navigationTitle("Your tasks")
                    .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
        }
    }
}
