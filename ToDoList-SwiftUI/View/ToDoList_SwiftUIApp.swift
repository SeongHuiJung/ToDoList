//
//  ToDoList_SwiftUIApp.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/14/25.
//

import SwiftUI

@main
struct ToDoList_SwiftUIApp: App {
    @StateObject var viewModel = TodoViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
