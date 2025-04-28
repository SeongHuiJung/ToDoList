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
    
    /// SwiftData 데이터 fetch
    ///
    /// 앱 실행시 한번만 실행되며, Published 된 toDoData 에 SwiftData 를 fetch 합니다.
    private func fetchToDoData() {
        do {
            let todoData = try modelContext.fetch(FetchDescriptor<TodoInfoModel>())
            
            toDoData = todoData
            toDoData.sort { $0.registerTime > $1.registerTime }
        } catch {
            print("TodoInfoModel 데이터를 찾을 수 없습니다.")
        }
    }
    
    /// ToDo 데이터 추가
    ///
    /// SwiftData 와 메모리 상의 toDoData 에 TodoInfoModel 데이터를 추가합니다.
    ///
    /// - Parameters:
    ///     - text: ToDo 데이터로 추가할 할 일 내용
    func addToDo(text: String) {
        let newTodo = TodoInfoModel(title: text)
        modelContext.insert(newTodo)
        toDoData.insert(newTodo, at: 0)
    }
    
    /// ToDo 데이터 완료 및 완료해제
    ///
    /// 메모리 상의 toDoData 의 isCompleted 값을 수정합니다. isCompleted 가 true 이면 false로, false 이면 true 로 변경합니다.
    ///
    /// SwiftData는 @Model 객체의 속성을 수정하기만 해도 자동으로 변경을 감지하고 저장하기때문에 modelContext 관련 작업을 해주지 않아도 괜찮습니다.
    ///
    /// - Parameters:
    ///     - id: 값을 변경할 ToDo 데이터의 UUID
    func onOffToDo(id: UUID) {
        let idx = findIndex(list: toDoData, id: id)
        
        toDoData[idx].isCompleted = !toDoData[idx].isCompleted
        return
    }
    
    /// ToDo 데이터 삭제
    ///
    /// SwiftData 와 메모리 상의 toDoData 에서 ToDo 데이터를 삭제합니다.
    ///
    /// - Parameters:
    ///     - id: 삭제할 ToDo 데이터의 UUID
    func deleteToDo(id: UUID) {
        let idx = findIndex(list: toDoData, id: id)
        
        let deleteData = toDoData[idx]
        modelContext.delete(deleteData)
        toDoData.remove(at: idx)
        return
    }
    
    /// ToDo 리스트에서 원하는 UUID를 가진 index를 반환
    ///
    /// - Parameters:
    ///     - list: TodoInfoModel 리스트
    ///     - id: 찾으려고 하는 item 의 UUID
    /// - Returns: 찾은 item 의 index 반환
    private func findIndex(list: [TodoInfoModel], id: UUID) -> Int {
        guard let idx = list.firstIndex(where: { $0.id == id }) else { return 0 }
        return idx
    }
}
