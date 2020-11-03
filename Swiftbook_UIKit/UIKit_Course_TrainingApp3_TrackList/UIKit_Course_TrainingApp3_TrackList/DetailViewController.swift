//
//  DetailViewController.swift
//  UIKit_Course_TrainingApp3_TrackList
//
//  Created by Анас Бен Мустафа on 22.09.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Image: UIImageView!
    
    var trackTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Image.image = UIImage(named: trackTitle)
        Label.text = trackTitle
        Label.numberOfLines = 0
    }
    
    

}
