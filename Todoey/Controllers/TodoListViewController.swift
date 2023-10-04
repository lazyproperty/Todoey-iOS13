//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        
    //"let defaults = UserDefaults.standard
    
    
    // MARK: -  Override ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Позвонить Маме"
        itemArray.append(newItem)
        
        /*
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        */
        
    }
    
    // MARK: -  TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
     
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    // MARK: -  TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
    
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
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
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(self.itemArray)
                try data.write(to: self.dataFilePath!)
            } catch  {
                print("Error encoding item array, \(error)")
            }
            
            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Right here"
            textField = alertTextField
            //print(textField.text)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

