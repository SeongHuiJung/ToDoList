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
    @Published var toDoData: [TodoInfoModel] = [] // 화면에 표기할 todo 데이터
    
    init(context: ModelContext) {
        self.modelContext = context
        fetchToDoData()
    }
    
    // 앱 실행시 한번 실행
    // @Published toDoData 에 SwiftData 를 fetch
    private func fetchToDoData() {
        do {
            let todoData = try modelContext.fetch(FetchDescriptor<TodoInfoModel>())
            
            toDoData = todoData
            toDoData.sort { $0.registerTime > $1.registerTime }
        } catch {
            print("TodoInfoModel 데이터를 찾을 수 없습니다.")
        }
    }
    
    // ToDo 추가 함수
    func addToDo(text: String) {
        let newTodo = TodoInfoModel(title: text)
        modelContext.insert(newTodo)
        toDoData.insert(newTodo, at: 0)
    }
    
    // ToDo 완료/완료해제 함수
    func onOffToDo(id: UUID) {
        let idx = findIndex(list: toDoData, id: id)
        
        toDoData[idx].isCompleted = !toDoData[idx].isCompleted
        return
    }
    
    // ToDo 삭제 함수
    func deleteToDo(id: UUID) {
        let idx = findIndex(list: toDoData, id: id)
        
        let deleteData = toDoData[idx]
        modelContext.delete(deleteData)
        toDoData.remove(at: idx)
        return
    }
    
    // 원하는 UUID를 가진 index를 찾는 함수
    private func findIndex(list: [TodoInfoModel], id: UUID) -> Int {
        guard let idx = list.firstIndex(where: { $0.id == id }) else { return 0 }
        return idx
    }
}
