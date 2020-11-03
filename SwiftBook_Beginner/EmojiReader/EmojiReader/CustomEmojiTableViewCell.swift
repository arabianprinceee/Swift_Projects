//
//  CustomEmojiTableViewCell.swift
//  EmojiReader
//
//  Created by Анас Бен Мустафа on 02.09.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class CustomEmojiTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var EmojiLabel: UILabel!
    @IBOutlet weak var EmojiNameLabel: UILabel!
    @IBOutlet weak var EmojiDiscriptionLabel: UILabel!
    
}
