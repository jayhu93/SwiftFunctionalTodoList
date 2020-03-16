//
//  RequestProtocol.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    subscript(key: String) -> (String?, String?) { get }
}

extension RequestProtocol {
    func getPropertyName() -> [String] {
        return Mirror(reflecting: self).children.filter { $0.label != nil }.map { $0.label! }
    }
}
