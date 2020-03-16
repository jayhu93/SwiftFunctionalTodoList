//
//  MasterViewController.swift
//  FunctionalTodoList
//
//  Created by Yupin Hu on 3/15/20.
//  Copyright © 2020 Jay. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!

    var viewModel = TodosViewModel(todos: []) {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        listTodos() { (response, error) in
            if error == nil {
                store.dispatch(LoadTodoActin(todos: response!))
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }

        filterSegmentedControl
            .addTarget(self, action: #selector(MasterViewController.filterValueChanged), for: .valueChanged)

        store.activeFilter.producer.startWithValues { filter in
            self.filterSegmentedControl.selectedSegmentIndex = filter.rawValue
        }

        store.activeTodos.startWithValues { todos in
            self.viewModel = TodoViewModel(todo: todos)
        }

        store.notSyncedWithBackend.startWithValues { todos in
            addOrUpdateTodo(todos) { (response, error) in
                if error == nil {
                    print("Success")
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
    }
}

// MARK: - Actions
extension MasterViewController {
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Create",
                                                message: "Create a new todo item",
                                                preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Id"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Description"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Note"
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let id = alertController.textFields?[0].text,
            let name = alertController.textFields?[1].text,
            let description = alertController.textFields?[2].text,
            let notes = alertController.textFields?[3].text
            else { return }

            store.dispatch(CreateTodoAction(todoId: Int(id)!, name: name, description: description, notes: notes))
        }))

        present(alertController, animated: true, completion: nil)
    }

    func filterValueChanged() {
        guard let newFilter = TodoFilter(rawValue: filterSegmentedControl.selectedSegmentIndex) else { return }
        store.dispatch(SetFilterAction(filter: newFilter))
    }
}

// MARK: UITableViewController
extension MasterViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        let todo = viewModel.todoForIndexPath(indexPath)
        cell.cofigure(todo)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = viewModel.todoForIndexPath(indexPath)
        store.dispatch(ToggleCompletedAction(todo: todo))
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, index) in
            let todo = self.viewModel.todoForIndexPath(indexPath)
            store.dispatch(DeleteTodoAction(todo: todo))
        }
        delete.backgroundColor = .red

        let details = UITableViewRowAction(style: .normal, title: "Details") { (action, index) in
            let todo = self.viewModel.todoForIndexPath(indexPath)
            store.dispatch(DetailsTodoAction(todo: todo))

            self.performSegue(withIdentifier: "segueShowDetails", sender: self)
        }
        details.backgroundColor = .orange
        return [details, delete]
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
