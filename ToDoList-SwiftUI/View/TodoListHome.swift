//
//  TodoListHome.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/22/25.
//

import SwiftUI

struct TodoListHome: View {
    @StateObject var viewModel = TodoViewModel()
    
    var body: some View {
        VStack {
            List {
                
            }

            Button("할 일 추가") {
                // TODO : 할일 추가
                // viewModel.addTodo()
            }
        }
    }
}

#Preview {
    TodoListHome()
}
