//
//  ViewController.swift
//  UIKit_Course_TrainingApp
//
//  Created by Анас Бен Мустафа on 08.09.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var UIelementsNames = ["UISegmentedController", "UILabel", "UISlider", "UITextField", "UIButton"]

    @IBOutlet weak var SegControl: UISegmentedControl!
    @IBOutlet weak var MyLabel: UILabel!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var ButtonForTF: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Slider.value = 1
        MyLabel.text = String(Slider.value)
        MyLabel.numberOfLines = 2
        MyLabel.font = MyLabel.font.withSize(35)
        MyLabel.textColor = .purple
        MyLabel.textAlignment = .center
        
        TextField.placeholder = "Enter some text"
        TextField.clearButtonMode = .whileEditing
        ButtonForTF.setTitle("Done", for: .normal)
        ButtonForTF.backgroundColor = .purple
        ButtonForTF.titleLabel?.textColor = .green
        
        SegControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        Slider.minimumValue = 0
        Slider.maximumValue = 1
        Slider.minimumTrackTintColor = .magenta
        Slider.maximumTrackTintColor = .red
        Slider.tintColor = .blue
        
    }
    
    @IBAction func TFButtonPressed(_ sender: UIButton) {
        
        guard TextField.text?.isEmpty == false else { return }
        
        if let _ = Double(TextField.text!) {
            let alert = UIAlertController(title: "Wrong name format", message: "Please, enter your name correctly", preferredStyle: .alert)
            let okAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(okAlert)
            present(alert, animated: true, completion: nil)
            
        } else {
            MyLabel.text = TextField.text
        }
        
        TextField.text = nil
    }
    
    
    @IBAction func SlideSlider(_ sender: UISlider) {
        MyLabel.text = String(sender.value)
        
        let backgroundcolor = self.view.backgroundColor
        self.view.backgroundColor = backgroundcolor?.withAlphaComponent(CGFloat(Slider.value))
    }
    
    @IBAction func ChoiceSegment(_ sender: UISegmentedControl) {
        
        MyLabel.isHidden = false
        
        switch SegControl.selectedSegmentIndex {
        case 0:
            MyLabel.text = "First segment"
            MyLabel.textColor = .green
        case 1:
            MyLabel.text = "Second segment"
            MyLabel.textColor = .yellow
        case 2:
            MyLabel.text = "Third segment"
            MyLabel.textColor = .red
        default:
             return
        }
    }
    

}

