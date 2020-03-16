//
//  TodoLens.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Foundation

struct Lens<Whole, Part> {
    let get: (Whole) -> Part
    let set: (Part, Whole) -> Whole
}

let todoNameLens: Lens<Todo, String> = Lens(
    get: { $0.name },
    set: {
        Todo(todoId: $1.todoId,
             name: $0,
             description: $1.description,
             notes: $1.notes,
             completed: $1.completed,
             synced: $1.synced,
             selected: $1.selected)
})

let todoDescriptionLens: Lens<Todo, String> = Lens(
    get: { $0.name },
    set: {
        Todo(todoId: $1.todoId,
             name: $1.name,
             description: $0,
             notes: $1.notes,
             completed: $1.completed,
             synced: $1.synced,
             selected: $1.selected)
})

let todoNotesLens: Lens<Todo, String> = Lens(
    get: { $0.name },
    set: {
        Todo(todoId: $1.todoId,
             name: $1.name,
             description: $1.description,
             notes: $0,
             completed: $1.completed,
             synced: $1.synced,
             selected: $1.selected)
})

let todoCompletedLens: Lens<Todo, String> = Lens(
    get: { $0.name },
    set: {
        Todo(todoId: $1.todoId,
             name: $1.name,
             description: $1.description,
             notes: $1.notes,
             completed: $0,
             synced: $1.synced,
             selected: $1.selected)
})

let todoSyncedLens: Lens<Todo, Bool> = Lens(
    get: { $0.name },
    set: {
        Todo(todoId: $1.todoId,
             name: $1.name,
             description: $1.description,
             notes: $1.notes,
             completed: $1.completed,
             synced: $0,
             selected: $1.selected)
})

let todoSelectedLens: Lens<Todo, Bool> = Lens(
    get: { $0.name },
    set: {
        Todo(todoId: $1.todoId,
             name: $1.name,
             description: $1.description,
             notes: $1.notes,
             completed: $1.completed,
             synced: $1.synced,
             selected: selected)
})
