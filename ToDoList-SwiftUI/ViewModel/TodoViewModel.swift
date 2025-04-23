//
//  TodoViewModel.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/22/25.
//

import Foundation
import SwiftUICore
import SwiftData

class TodoViewModel: ObservableObject {
    private let modelContext: ModelContext
    @Published private var allToDoData: [TodoInfoModel] = []
    
    init(context: ModelContext) {
        self.modelContext = context
        setAllToDoData()
    }

    // view 에 표기할 todo 데이터
    var sortedTodo: [TodoInfoModel] {
        do {
            var todoData = try modelContext.fetch(FetchDescriptor<TodoInfoModel>())
            todoData.sort { $0.registerTime > $1.registerTime }
            return todoData
        } catch {
            print("TodoInfoModel 데이터를 찾을 수 없습니다.")
            return []
        }
    }
    
    // 앱 실행시 한번 실행
    // @Published allToDoData 에 SwiftData 를 fetch
    func setAllToDoData() {
        do {
            let todoData = try modelContext.fetch(FetchDescriptor<TodoInfoModel>())
            
            allToDoData = todoData
            allToDoData.sort { $0.registerTime > $1.registerTime }
        } catch {
            print("TodoInfoModel 데이터를 찾을 수 없습니다.")
        }
    }
    
    // ToDo 추가 함수
    func addToDo(text: String) {
        let newTodo = TodoInfoModel(title: text)
        modelContext.insert(newTodo)
        allToDoData.append(newTodo)
    }
    
    // ToDo 완료/완료해제 함수
    func onOffToDo(id: UUID) {
        for i in 0..<allToDoData.count {
            if allToDoData[i].id == id {
                allToDoData[i].isCompleted = !allToDoData[i].isCompleted
                return
            }
        }
    }
    
    // ToDo 삭제 함수
    func deleteToDo(id: UUID) {
        for i in 0..<allToDoData.count {
            if allToDoData[i].id == id {
                let deleteData = allToDoData[i]
                modelContext.delete(deleteData)
                allToDoData.remove(at: i)
                return
            }
        }
    }
}
