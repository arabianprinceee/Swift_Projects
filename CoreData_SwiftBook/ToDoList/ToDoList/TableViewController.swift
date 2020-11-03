//
//  TableViewController.swift
//  ToDoList
//
//  Created by Анас Бен Мустафа on 11/2/20.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var tasks: [Task] = []
    
    @IBAction func SaveTask(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New task", message: "Add new task", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            let textfield = alertController.textFields?.first
            
            if let newTaskTitle = textfield?.text {
                self.saveTask(withTitle: newTaskTitle)
                self.tableView.reloadData()
            }
            
        }
        
        alertController.addTextField { _ in }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // Сохраняем данные в Core Data
    private func saveTask (withTitle: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext // Получение контекста
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            tasks.append(taskObject)
            tableView.reloadData()
            print(String(tasks.count) + "save")
        } catch let error as NSError {
            context.rollback()
            print(error.localizedDescription)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext // Получение контекста
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        // let sortDescriptor = NSSortDescriptor(key: "title", ascending: false) // сортировка в том или ином порядке
        
        do {
            tasks = try context.fetch(fetchRequest)
            print(String(tasks.count) + "get")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tasks.count)
        
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext // Получение контеста
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest() // Фетч реквест для получения данных
        
        if let objects = try? context.fetch(fetchRequest) {
            for obj in objects {
                context.delete(obj)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            context.rollback()
            print(error.localizedDescription)
        }
        */
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title

        return cell
    }

}
