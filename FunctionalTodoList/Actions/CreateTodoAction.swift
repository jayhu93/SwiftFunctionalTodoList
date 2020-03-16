//
//  CreateTodoAction.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Delta

struct CreateTodoAction: ActionType {
    let todoId: Int
    let name: String
    let description: String
    let notes: String

    var todo: Todo {
        return Todo(todoId: todoId,
                    name: name,
                    description: description,
                    notes: notes,
                    completed: false,
                    synced: false,
                    selected: false)
    }
}
