//
//  TodosViewModel.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Foundation

struct TodosViewModel {
    let todos: [Todo]

    func todoForIndexPath(_ indexPath: IndexPath) -> Todo {
        return todos[indexPath.row]
    }
}
