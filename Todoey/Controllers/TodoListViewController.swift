//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Позвонить Маме", "Купить хлеб", "Заправить машину"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
    // MARK: -  TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    // MARK: -  TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        // ставим галочку напротив строки, если ее нет, и наоборот
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // убирает выделение строки после нажатия
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: -  Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // создаем переменную textField в области видимости кнопки
        var textField = UITextField()
        let alert = UIAlertController(title: "One More Item", message: "", preferredStyle: .alert)
        
        //выполнение кода после нажатия кнопки "Enter" в Alert
        let action = UIAlertAction(title: "just do it", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            // print(textField.text as Any)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //обновляет отображение экрана с таблицей
            self.tableView.reloadData()
        }
        
        // alert.addTextField()
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Right here"
            textField = alertTextField
            //print(textField.text)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

