 //
//  AddEmojiTableViewController.swift
//  EmojiReader
//
//  Created by Анас Бен Мустафа on 04.09.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class AddEmojiTableViewController: UITableViewController {

    var emoji = Emoji(emoji: "", name: "", description: "", isFavorite: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateSabeButtonState()
        updateUI()
    }
    
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var EmojiTF: UITextField!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var DescriptyionTF: UITextField!
     
    // Функция, которая отслеживает заполненность всех текстфилдов
    private func UpdateSabeButtonState() {
        let emojitext = EmojiTF.text ?? ""
        let nametext = NameTF.text ?? ""
        let desctext = DescriptyionTF.text ?? ""
        // Если все заполнены, тогда isEnabled - true 
        SaveButton.isEnabled = !nametext.isEmpty && !emojitext.isEmpty && !desctext.isEmpty
    }
    
    private func updateUI() {
        EmojiTF.text = emoji.emoji
        NameTF.text = emoji.name
        DescriptyionTF.text = emoji.description
    }
    
    @IBAction func TextChanged(_ sender: UITextField) {
        UpdateSabeButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "SaveSegue" else { return }
        
        self.emoji = Emoji(emoji: EmojiTF.text ?? "", name: NameTF.text ?? "", description: DescriptyionTF.text ?? "", isFavorite: self.emoji.isFavorite)
    }
    
}
