//
//  Store.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import Delta

struct Store: StoreType {
    var state: ObservableProperty<State>

    init(state: State) {
        self.state = ObservableProperty(state)
    }
}

var store = Store(state: State())
