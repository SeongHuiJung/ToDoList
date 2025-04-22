//
//  TodoInfoModel.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/22/25.
//

import Foundation

struct TodoInfoModel: Identifiable {
    let id: UUID = UUID()
    var title: String
    var isCompleted: Bool
}
