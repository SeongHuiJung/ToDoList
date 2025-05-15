//
//  ToDoList_SwiftUIApp.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/14/25.
//

import SwiftUI
import SwiftData

@main
struct ToDoList_SwiftUIApp: App {
    
    var modelContainer: ModelContainer = {
        let schema = Schema([TodoInfoModel.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("ModelContainer 생성 실패: \(error)")
        }
    }()
    
    @StateObject private var viewModel: TodoViewModel
    
    init() {
        let context = modelContainer.mainContext
        _viewModel = StateObject(wrappedValue: TodoViewModel(context: context))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .modelContainer(modelContainer)
        }
    }
}
