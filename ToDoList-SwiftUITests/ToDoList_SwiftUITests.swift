//
//  ToDoList_SwiftUITests.swift
//  ToDoList-SwiftUITests
//
//  Created by 정성희 on 4/23/25.
//

import XCTest
@testable import ToDoList_SwiftUI
import SwiftData
import SwiftUICore

final class ToDoList_SwiftUITests: XCTestCase {
    
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    var viewModel: TodoViewModel!
    
    override func setUp() async throws {
        let schema = Schema([TodoInfoModel.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        modelContainer = try ModelContainer(for: schema, configurations: [config])
        modelContext = await MainActor.run { modelContainer.mainContext }
        
        // 더미 데이터 추가
        await MainActor.run {
            let todo1 = TodoInfoModel(title: "더미 데이터1")
            let todo2 = TodoInfoModel(title: "더미 데이터2")
            modelContext.insert(todo1)
            modelContext.insert(todo2)
        }
        viewModel = await MainActor.run { TodoViewModel(context: modelContext) }
    }
    
    override func tearDown() async throws {
        viewModel = nil
        modelContext = nil
        modelContainer = nil
    }
    
    // 할 일 추가 검증
    // [할 일 추가 전 + 1]과 [할 일 추가 후] 의 개수가 같아야 함
    func test_AddToDo() async {
        let beforeCount = await MainActor.run { viewModel.toDoData.count }
        await MainActor.run { viewModel.addToDo(text: "할 일") }
        let afterCount = await MainActor.run { viewModel.toDoData.count }
        
        XCTAssertEqual(beforeCount + 1, afterCount, "할 일 추가가 안 됐습니다.")
    }
    
    // SwiftData 영속화 검증
    // SwiftData 에 저장한 더미데이터 2개가 toDoData 에 잘 fetch 되었는지 확인
    func test_fetchToDoData() {
        let todoDummyData = viewModel.toDoData
        XCTAssertEqual(todoDummyData.count, 2, "삽입된 더미 데이터가 fetch되지 않았습니다.")
        
        let titles = todoDummyData.map { $0.title }
        XCTAssertTrue(titles.contains("더미 데이터1"))
        XCTAssertTrue(titles.contains("더미 데이터2"))
    }
    
    // 할 일 완료/완료해제 검증
    // 더미데이터 1개에 대해 할일 off -> on 과 on -> off 를 확인
    func test_onOffToDo() {
        let todoDummyDataID = viewModel.toDoData[0].id
        viewModel.onOffToDo(id: todoDummyDataID)
        XCTAssertTrue(viewModel.toDoData[0].isCompleted, "할 일 Off -> On 작업에 실패했습니다")
        
        viewModel.onOffToDo(id: todoDummyDataID)
        XCTAssertFalse(viewModel.toDoData[0].isCompleted, "할 일 On -> Off 작업에 실패했습니다")
    }
    
    // 할 일 삭제 검증
    // 더미데이터 2개 중 1개 삭제 후 남은 더미데이터는 1개 이어야함
    func test_deleteToDo() async {
        let todoDummyDataID = viewModel.toDoData[0].id
        await MainActor.run { viewModel.deleteToDo(id: todoDummyDataID) }
        
        XCTAssertEqual(viewModel.toDoData.count, 1, "할 일이 삭제되지 않았습니다")
    }
}
