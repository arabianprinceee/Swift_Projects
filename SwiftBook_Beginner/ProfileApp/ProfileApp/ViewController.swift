//
//  ViewController.swift
//  ProfileApp
//
//  Created by Анас Бен Мустафа on 18.08.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Elya_Avatar.layer.borderWidth = 3.5
        Elya_Avatar.layer.borderColor = UIColor.systemPink.cgColor
    }
    
    @IBOutlet weak var Elya_Avatar: UIImageView!
    
    @IBOutlet weak var UNameLabel: UILabel!
    
    @IBAction func unwindSegueToRootPage(segue: UIStoryboardSegue) {
        let ViewC = segue.source as! SettingsViewController
        UNameLabel.text = "Пользователь с именем:\n\(ViewC.UserNameTF.text!)"
    }

}

