//
//  TodoRow.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/22/25.
//

import SwiftUI

struct TodoRow: View {
    @Binding var todo: TodoInfoModel
    
    var body: some View {
        HStack {
            Text(todo.title)
            
            Spacer()
            
            if todo.isCompleted {
                Image(systemName: "checkmark.square.fill")
                    .foregroundStyle(.black)
            }
            else {
                Image(systemName: "square")
                    .foregroundStyle(.black)
            }
        }
    }
}
