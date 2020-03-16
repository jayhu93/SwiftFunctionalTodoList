//
//  TodoRequest.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Foundation

struct TodoRequest: RequestProtocol {
    let todoId: Int
    let name: String
    let description: String
    let note: String
    let completed: Bool
    let synced: Bool

    subscript(key: String) -> (String?, String?) {
        get {
            switch key {
            case "todoId": return (String(todoId), "todoId")
            case "name": return (name, "name")
            case "description": return (description, "description")
            case "note": return (note, "note")
            case "completed": return (String(completed), "completed")
            case "synced": return (String(synced), "synced")
            default: return ("Cooie", "test=123")
            }
        }
    }
}

struct RequestModel: RequestProtocol {
    subscript(key: String) -> (String?, String?) {
        get {
            switch key {
            default: return ("Cookie", "test=123")
            }
        }
    }
}
