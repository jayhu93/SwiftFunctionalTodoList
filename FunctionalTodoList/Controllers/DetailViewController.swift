//
//  DetailViewController.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift

class DetailViewController: UIViewController {
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldDescription: UITextField!
    @IBOutlet weak var textFieldNotes: UITextField!
    @IBOutlet weak var switchCompleted: UISwitch!

    var viewModel = TodoViewModel(todo: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        store.selectedTodo.startWithValues { todos in
            let model = todos.first!
            self.textFieldName.text = model.name
            self.textFieldDescription.text = model.description
            self.textFieldNotes.text = model.notes
            self.switchCompleted.text = model.complteted
            self.viewModel = TodoViewModel(todo: model)
        }
        setupUpdateSignals()
    }

    func setupUpdateSignals() {
        textFieldName.reactive.continuousTextValues.observeValues { (values) in
            if let newName = values {
                let newTodo = todoNameLens.set(newName, self.viewModel.todo!)
                store.dispatch(UpdateTodoAction(todo: newTodo))
            }
        }

        textFieldDescription.reactive.continuousTextValues.observeValues { (values) in
            if let newDescription = values {
                let newTodo = todoDescriptionLens.set(newDescription, self.viewModel.todo!)
                store.dispatch(UpdateTodoAction(todo: newTodo))
            }
        }

        textFieldNotes.reactive.continuousTextValues.observeValues { (values) in
            if let newNotes = values {
                let newTodo = todoNotesLens.set(newNotes, self.viewModel.todo!)
                store.dispatch(UpdateTodoAction(todo: newTodo))
            }
        }

        switchCompleted.reactive.isOnValues.observeValues { (value) in
            let newTodo = todoCompletedLens.set(value, self.viewModel.todo!)
            store.dispatch(UpdateTodoAction(todo: newTodo))
        }
    }
}
