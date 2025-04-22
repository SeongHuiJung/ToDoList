//
//  TodoViewModel.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/22/25.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published private var allToDoData: [TodoInfoModel] = []
    
    // get ToDo 데이터 
    var toDoData: [TodoInfoModel] {
        return allToDoData.reversed() // reversed 로 최신순 정렬
    }
    
    // ToDo 추가 함수
    func addToDo(text: String) {
        allToDoData.append(TodoInfoModel(title: text))
    }
}
