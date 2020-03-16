//
//  ToggleCompletedAction.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Delta

struct ToggleCompletedAction: ActionType {
    let todo: Todo

    func reduce(state: State) -> State {
        state.todos.value = state.todos.value.map { todo
            guard todo == self.todo else { return todo }
            return Todo(
                todoId: todo.todoId,
                name: todo.name,
                description: todo.description,
                notes: todo.notes,
                completed: !todo.completed,
                synced: !todo.synced,
                selected: todo.selected)
        }
        return state
    }
}
