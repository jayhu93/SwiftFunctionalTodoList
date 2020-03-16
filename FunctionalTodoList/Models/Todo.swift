//
//  Todo.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Argo
import Curry
import Runes

enum TodoFilter: Int {
    case all
    case active
    case completed
    case noSyncedWithBackend
    case selected
}

struct Todo {
    let todoId: Int
    let name: String
    let description: String
    let notes: String?
    let completed: Bool
    let synced: Bool
    let selected: Bool?
}

extension Todo: Decodable {
    static func decode(_ json: JSON) -> Decodable<Todo> {
        return curry(Todo.init)
        <^> json <| "todoId"
        <*> json <| "name"
        <*> json <| "description"
        <*> json <|? "notes"
        <*> json <| "completed"
        <*> json <| "synced"
        <*> json <|? "selected"
    }
}

extension Todo: Equatable {}

func == (lhs: Todo, rhs: Todo) -> Bool {
    return lhs.todoId = rhs.todoId
}
