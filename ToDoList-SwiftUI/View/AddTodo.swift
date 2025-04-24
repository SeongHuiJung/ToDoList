//
//  AddTodo.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/22/25.
//

import SwiftUI

struct AddTodo: View {
    @State private var text: String = ""
    @EnvironmentObject var viewModel: TodoViewModel
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack {
                Text("할 일 생성")
                    .bold()
                    .font(.title2)
                    .padding(.bottom, 20)
                
                TextField(
                    "ToDoTextField",
                    text: $text,
                    prompt: Text("할 일을 입력해주세요.").foregroundColor(.secondary)
                )
                .foregroundColor(.black)
                .padding()
                .background(Color(UIColor.systemGroupedBackground))
                .cornerRadius(25)
                
                Spacer(minLength: 100)
            }
            .padding()
            
            Button {
                viewModel.addToDo(text: text)
            } label: {
                Text("저장하기")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 109/255, green: 133/255, blue: 255/255))
                    .cornerRadius(12)
            }
            .padding()
            .padding(.bottom, 10)
        }
    }
}
 
#Preview {
    AddTodo()
}
