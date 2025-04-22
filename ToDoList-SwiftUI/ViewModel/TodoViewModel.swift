//
//  TodoViewModel.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/22/25.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published private var allToDoData: [TodoInfoModel] = []
    
    @Published var name: String?
    
    var toDoData: [TodoInfoModel] {
        return allToDoData
    }
    
    func addToDo() {
        allToDoData.append(TodoInfoModel(title: "test", isCompleted: false))
        name = "test"
    }
}
