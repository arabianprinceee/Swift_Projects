//
//  ViewController.swift
//  PassDataBetweenWindows
//
//  Created by Анас Бен Мустафа on 16.08.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogInButton.layer.cornerRadius = 10.0
        LogInButton.layer.masksToBounds = true
    }
    
    @IBOutlet weak var LogInTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var ResultLabel: UILabel!
    
     
    @IBAction func TouchedLogIn(_ sender: UIButton) {
        performSegue(withIdentifier: "SomeIdentyfier", sender: nil)
    }
    
    @IBAction func unwindSegueToMainScreen(segue: UIStoryboardSegue) {
        self.ResultLabel.text = "Последний выполненный вход \nсовершён пользователем: '\(LogInTF.text!)'"
        self.LogInTF.text = ""
        self.PasswordTF.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sdcheck = segue.destination as? AfterLogInViewController else { return }
        sdcheck.LoginText = LogInTF.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

