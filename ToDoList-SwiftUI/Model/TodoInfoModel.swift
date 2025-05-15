//
//  TodoInfoModel.swift
//  ToDoList-SwiftUI
//
//  Created by 정성희 on 4/22/25.
//

import Foundation
import SwiftData

@Model
class TodoInfoModel: Identifiable {
    var title: String
    @Attribute(.unique) var id: UUID = UUID()
    var isCompleted: Bool = false
    var registerTime: Date = Date()
    
    init(title: String) {
        self.title = title
    }
}
