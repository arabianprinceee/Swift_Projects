//
//  ViewController.swift
//  UIKit_Course_TrainingApp2
//
//  Created by Анас Бен Мустафа on 20.09.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ProgressView: UIProgressView!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var Stepper: UIStepper!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.isHidden = true
//        textView.alpha = 0
        
        textView.delegate = self
        
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 19 )
        textView.backgroundColor = self.view.backgroundColor
        textView.layer.cornerRadius = 10
        
        Stepper.value = 17
        Stepper.minimumValue = 10
        Stepper.maximumValue = 25
        
        ProgressView.setProgress(0, animated: true)
        Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { _ in
            if self.ProgressView.progress != 1 {
                self.ProgressView.progress += 0.005
            } else {
                self.ActivityIndicator.stopAnimating()
                self.textView.isHidden = false
                self.view.isUserInteractionEnabled = true
                self.ProgressView.isHidden = true
            }
        }
        
        ActivityIndicator.hidesWhenStopped = true
        ActivityIndicator.color = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        ActivityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false // запрет на взаимодействие пользователя с интерфейсом
        
        Label.text = String(textView.text.count)
        
//        UIView.animate(withDuration: 0, delay: 3.5, options: .curveEaseIn, animations: {
//            self.textView.alpha = 1
//        }) { (finished) in
//            self.ActivityIndicator.stopAnimating()
//            self.textView.isHidden = false
//            self.view.isUserInteractionEnabled = true
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func FontSize(_ sender: UIStepper) {
        let font = textView.font?.fontName
        let fontsize = CGFloat(sender.value)
        
        textView.font = UIFont(name: font!, size: fontsize )
    }
}

extension ViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = .white
        textView.textColor = .darkGray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = self.view.backgroundColor
        textView.textColor = .black
    }
    
}
