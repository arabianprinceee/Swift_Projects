 //
//  ViewController.swift
//  TempConverter
//
//  Created by Анас Бен Мустафа on 14.08.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    @IBOutlet weak var CelsiusLabel: UILabel!
    @IBOutlet weak var FarengeitLabel: UILabel!
    @IBOutlet weak var HorizSlider: UISlider! {
        didSet {
            HorizSlider.maximumValue = 100
            HorizSlider.minimumValue = -100
            HorizSlider.value = 0
        }
    }
    
    @IBAction func SliderChanged(_ sender: UISlider) {
        let TempCelsius = Int(round(sender.value))
        CelsiusLabel.text = "\(TempCelsius)ºC"
        let FarenTemp = Int(round(((sender.value * 9) / 5) + 32))
        FarengeitLabel.text = "\(FarenTemp)ºF"
    }
}

