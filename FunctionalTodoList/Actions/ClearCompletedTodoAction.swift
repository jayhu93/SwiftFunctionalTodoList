//
//  ClearCompletedTodoAction.swift
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
            return Todo(todoId: todo.id,
                        name: todo.name,
                        description: todo.description,
                        notes: todo.notes,
                        completed: todo.completed,
                        synced: !todo.synced,
                        selected: todo.selected)
        }
        return state
    }
}
