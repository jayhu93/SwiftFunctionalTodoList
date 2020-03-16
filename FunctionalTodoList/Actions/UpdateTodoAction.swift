//
//  UpdateTodoAction.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Delta

struct UpdateTodoAction: ActionType {
    let todo: Todo

    func reduce(state: State) -> State {
        state.todos.value = state.todos.value.map { todo in
            guard todo == self.todo else { return todo }
            return Todo(
                todoId: todo.todoId,
                name: self.todo.name,
                description: self.todo.description,
                notes: self.todo.notes,
                completed: self.todo.notes,
                synced: !todo.synced,
                selected: todo.selected)
        }
        return state
    }
}
