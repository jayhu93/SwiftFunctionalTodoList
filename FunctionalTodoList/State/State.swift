//
//  State.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import ReactiveSwift

private let initialTodos: [Todo] = []

struct State {
    let todos = MutablProperty(initialTodos)
    let filter = MutableProperty(TodoFilter.all)
    let notSynced = MutableProerty(TodoFilter.noSyncedWithBackend)
    let selectedTodoItem = MutableProperty(TodoFilter.selected)
}
