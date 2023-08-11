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
    @State private var searchText = ""
    @FetchRequest(sortDescriptors: []) var taskArray: FetchedResults<Task>
    @Environment(\.managedObjectContext) var moc
    var query: Binding<String> {
            Binding {
                searchText
            } set: { newValue in
                searchText = newValue
                taskArray.nsPredicate = newValue.isEmpty
                               ? nil
                               : NSPredicate(format: "tag CONTAINS %@", newValue)
            }
        }
    

    var body: some View {
        NavigationStack {
            VStack {
                List(taskArray) { task in
                    HStack {
                        Image(systemName: "square")
                            .onTapGesture {
                                moc.delete(task)
                                try? moc.save()
                            }
                        VStack(alignment: .leading) {
                            Text("**\(task.viewName)**")
                            Text("**\(task.viewDate.reformat())**")
                                .font(.caption)
                        }
                        Spacer()
                        Text(task.viewTag)
                            .font(.caption)
                    }
                }
                .searchable(text: query)
                
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
}
