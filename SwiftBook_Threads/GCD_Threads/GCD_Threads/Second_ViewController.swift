//
//  Second_ViewController.swift
//  GCD_Threads
//
//  Created by Анас Бен Мустафа on 11/5/20.
//

import UIKit

class Second_ViewController: UIViewController {
   
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return ImageView.image
        }
        set {
            ActivityIndicator.stopAnimating()
            ActivityIndicator.isHidden = true
            ImageView.image = newValue
            ImageView.contentMode = .scaleAspectFit
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicator.tintColor = .black
        fetchImage()
        delay(3) {
            self.LoginAlert()
        }
    }
    
    // delay - задержка
    // Функция задерживает некий код, передаваемый в замыкание на delay секунд
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func LoginAlert() {
        
        let ac: UIAlertController = UIAlertController(title: "Login", message: "Enter data", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (userNameTF) in
            userNameTF.placeholder = "Enter login"
        }
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Enter password"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://images.wallpaperscraft.ru/image/gorod_vid_sverhu_zdaniia_191753_3840x2160.jpg")
        ActivityIndicator.isHidden = false
        ActivityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility) // Создали другой поток
        queue.async {
            guard let URL = self.imageURL, let imageData = try? Data(contentsOf: URL) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
