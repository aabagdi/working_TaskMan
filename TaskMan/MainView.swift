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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var taskArray: FetchedResults<Task>
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
                    TaskRow(task: task)
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
        .searchable(text: query)
    }
}

struct TaskRow: View {
    let task: FetchedResults<Task>.Element
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        HStack {
            Image(systemName: "square")
                .onTapGesture {
                    delete(task: task)
                }
            VStack(alignment: .leading) {
                Text(task.viewName)
                Text(task.viewDate.formatted())
                    .font(.caption)
            }
            .fontWeight(.bold)
            Spacer()
            Text(task.viewTag)
                .font(.caption)
        }
    }
    
    private func delete(task: FetchedResults<Task>.Element) {
        moc.delete(task)
        try? moc.save()
    }
}
