//
//  LoadTodoAction.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Delta

struct LoadTodoActin: ActionType {
    let todos: [Todo]

    func reduce(state: State) -> State {
        state.todos.value = state.todos.value + todos
        return state
    }
}
