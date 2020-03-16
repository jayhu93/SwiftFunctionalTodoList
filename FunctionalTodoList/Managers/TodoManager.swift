//
//  TodoManager.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Alamofire
import Argo

func addTodo(_ completion: @escaping (_ responseData: [Todo]?, _ error: Error?) -> Void) {
    let newRequest = TodoRequest(todoId: 1,
                                 name: "Saturday Grocery",
                                 description: "Bananas, Pineapple, Beer, Orange juice, ...",
                                 note: "Check expiration date of orange juice",
                                 completed: false,
                                 synced: true)

    sendRequest(Urls.postTodo, request: newRequest) { (response, error) in
        if error == nil {
            let todos: [Todo]? = decode(response!)
            completion(todos, nil)
            print("request was successful: \(todos)")
        } else {
            completion(nil, error)
            print("Error: \(error?.localizedDescription)")
        }
    }
}

func listTodos(_ completion: @escaping (_ responseData: [Todo]?, _ error: Error?) -> Void) {
    sendRequest(Urls.getTodos, request: RequestModel()) { (response, error) in
        if error == nil {
            let todos: [Todo]? = decode(response!)
            completion(todos, nil)
            print("request was successful: \(todos)")
        } else {
            completion(nil, error)
            print("Error: \(error?.localizedDescription)")
        }
    }
}

func addOrUpdateTodo(_ todo: [Todo]?, completion: @escaping (_ responseData: [Todo]?, _ error: Error?) -> Void) {
    if let todoItem = todo?.first {
        let newRequest = TodoRequest(todoId: todoItem.todoId,
                                     name: todoItem.name,
                                     description: todoItem.description,
                                     note: todoItem.notes,
                                     completed: todoItem.completed,
                                     synced: true)
        sendRequest(Urls.postTodo, request: newRequest) { (response, error) in
            if error == nil {
                let todos: [Todo]? = decode(response!)
                let newTodo = todoSyncedLens.set(true, todoItem)
                store.dispatch(UpdateTodoAction(todo: newTodo))
                completion("request was successful: \(todos)")
            } else {
                completion(nil, error)
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
}

func updateTodo(_ todo: [Todo]?, completion: @escaping (_ responseData: [Todo]?, _ error: Error?) -> Void) {
    if let todoItem = todo?.first {
        let newRequest = TodoRequest(todoId: todoItem.todoId,
                                     name: todoItem.name,
                                     description: todoItem.description,
                                     note: todoItem.notes,
                                     completed: todoItem.completed,
                                     synced: true)

        sendRequest(Urls.update, request: newRequest) { (response, error) in
            if error == nil {
                let todos: [Todo]? = decode(response!)
                let newTodo = todoSyncedLens.set(true, todoItem)
                store.dispatch(UpdateTodoAction(todo: newTodo))
                completion("request was successful: \(todos)")
            } else {
                completion(nil, error)
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
}
