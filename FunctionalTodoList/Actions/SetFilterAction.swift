//
//  SetFilterAction.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Delta

struct SetFilterAction: ActionType {
    let filter: TodoFilter

    func reduce(state: State) -> State {
        state.filter.value = filter
        return state
    }
}
