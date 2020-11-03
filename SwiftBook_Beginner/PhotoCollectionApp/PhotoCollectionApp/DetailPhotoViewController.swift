//
//  DetailPhotoViewController.swift
//  PhotoCollectionApp
//
//  Created by Анас Бен Мустафа on 06.09.2020.
//  Copyright © 2020 Анас Бен Мустафа. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {

    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimalPhotoIV.image = image
    }
    
    @IBAction func ShareAction(_ sender: UIButton) {
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var AnimalPhotoIV: UIImageView!
}
