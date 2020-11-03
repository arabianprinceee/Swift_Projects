//
//  TableViewController.swift
//  EmojiReader
//
//  Created by Анас Бен Мустафа on 02.09.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var objects = [
        Emoji(emoji: "😷", name: "Coronavirus", description: "1.5m distance", isFavorite: false),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emoji Dictionary"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveSegue" else { return }
        let sourceVC = segue.source as! AddEmojiTableViewController
        let emoji = sourceVC.emoji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: objects.count , section: 0)
            objects.append(emoji) // Добавляем элемент в массив
            // Обновляем данные в таблице
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "EditEmoji" else { return }
        
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        
        let NavigationVC = segue.destination as! UINavigationController
        let newEmojiVC = NavigationVC.topViewController as! AddEmojiTableViewController
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete  implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! CustomEmojiTableViewCell

        let object = objects[indexPath.row]
        cell.EmojiLabel.text = object.emoji
        cell.EmojiNameLabel.text = object.name
        cell.EmojiDiscriptionLabel.text = object.description

        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade )
        }
    }
    
    // Разрешение на передвижение элементов в таблице
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Передвигаем элементы в таблице
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData() 
    }
    
    // Организация свайпа влево
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [FlagAction(at: indexPath), DoubleEmoji(at: indexPath)])
    }
    
    @IBOutlet weak var AddEmojiButton: UIButton!
    
    func DoubleEmoji(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            self.objects.insert(self.objects[indexPath.row], at: indexPath.row + 1)
            self.tableView.reloadData()
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "plus.circle")
        return action
    }
    
    func FlagAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
            object.isFavorite = !object.isFavorite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavorite ? .systemPink : .systemGray
        action.image = UIImage(systemName: "hand.thumbsup")
        return action
    }
}
