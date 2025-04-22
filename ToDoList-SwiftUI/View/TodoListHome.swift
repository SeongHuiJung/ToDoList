//
//  TodoListHome.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/22/25.
//

import SwiftUI

struct TodoListHome: View {
    @EnvironmentObject var viewModel: TodoViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("To Do List")
                            .bold()
                            .font(.title)
                    }
                    .padding()
                    
                    Spacer()
                    
                    if viewModel.toDoData.isEmpty {
                        Text("할 일을 추가해 주세요!")
                    } else {
                        List {
                            ForEach(viewModel.toDoData) { data in
                                TodoRow(todo: data)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: AddTodo()) {
                        Text("할 일 추가")
                    }
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                }
            }
        }
    }
}

#Preview {
    TodoListHome()
        .environmentObject(TodoViewModel())
}
