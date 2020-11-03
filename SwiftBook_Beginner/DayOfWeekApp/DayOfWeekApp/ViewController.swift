//
//  ViewController.swift
//  DayOfWeekApp
//
//  Created by Анас Бен Мустафа on 13.08.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DayTextField: UITextField!
    @IBOutlet weak var MonthTextField: UITextField!
    @IBOutlet weak var YearTextField: UITextField!
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet weak var FButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FButton.layer.cornerRadius = 10.0
        FButton.layer.masksToBounds = true
    }
    
    @IBAction func FindButton(_ sender: Any) {

        let calendar = Calendar.current

        var dateComponents = DateComponents()
        dateComponents.day = Int(DayTextField.text!)
        dateComponents.month = Int(MonthTextField.text!)
        dateComponents.year = Int(YearTextField.text!)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"

        let date = calendar.date(from: dateComponents)
        let weekday = dateFormatter.string(from: date!)

        ResultLabel.text = weekday
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}

