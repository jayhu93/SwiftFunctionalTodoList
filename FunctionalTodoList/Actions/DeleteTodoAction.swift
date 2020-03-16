//
//  DeleteTodoAction.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Delta

struct DeleteTodoAction: ActionType {
    let todo: Todo

    func reduce(state: State) -> State {
        state.todos.value = state.todos.value.filter { $0 != self.todo }
        return state
    }
}
