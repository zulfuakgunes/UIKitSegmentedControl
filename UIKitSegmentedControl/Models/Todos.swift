//
//  Todos.swift
//  UIKitSegmentedControl
//
//  Created by Zülfü Akgüneş on 13.02.2024.
//

import Foundation

struct Todos: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
