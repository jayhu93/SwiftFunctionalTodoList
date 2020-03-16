//
//  StoreExtension.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import Result

extension Store {
    var todos: MutableProperty<[Todo]> {
        return state.value.todos
    }

    var activeFilter: MutableProperty<TodoFilter> {
        return state.value.filter
    }

    var selectedTodoItem: MutableProperty<TodoFilter> {
        return state.value.selectedTodoItem
    }
}

extension Store {
    var activeTodos: SignalProducer<[Todo], Never> {
        return activeFilter.producer.flatMap(.latest) { filter -> SignalProducer<[Todo], Never> in
            switch filter {
            case .all: return self.todos.producer
            case .active: return self.incompleteTodos
            case .completed: return self.completedTodos
            case .noSyncedWithBackend: return self.notSyncedWithBackend
            case .selected: return self.selectedTodo
            }
        }
    }

    var completedTodos: SignalProducer<[Todo], Never> {
        return todos.producer.map { todos in
            return todos.filter { $0.completed }
        }
    }

    var incompletedTodos: SignalProducer<[Todo], Never> {
        return todos.producer.map { todos in
            return todos.filter { !$0.completed }
        }
    }

    var incompleteTodosCount: SignalProducer<Int, Never> {
        return incompletedTodos.map { $0.count }
    }

    var allTodosCount: SignalProducer<Int, Never> {
        return todos.producer.map { $0.count }
    }

    var todoStats: SignalProducer<(Int, Int), Never> {
        return allTodosCount.zip(with: incompleteTodosCount)
    }

    var notSyncedWithBackend: SignalProducer<[Todo], Never> {
        return todos.producer.map { todos in
            return todos.filter { !$0.synced }
        }
    }

    var selectedTodo: SignalProducer<[Todo], Never> {
        return todos.producer.map { todos in
            return todos.filter { todo in
                if let selected = todo.selected {
                    return true
                } else {
                    return false
                }
            }
        }
    }

    func producerForTodo(_ todo: Todo) -> SignalProducer<Todo, Never> {
        return store.todos.producer.map { todos in
            return todos.filter { $0 == todo }.first
        }
        .skipNil()
    }
}
