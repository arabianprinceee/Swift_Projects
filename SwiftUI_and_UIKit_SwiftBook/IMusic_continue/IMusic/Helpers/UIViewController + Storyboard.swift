//
//  UIViewController + Storyboard.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 1/1/21.
//  Copyright © 2021 Анас Бен Мустафа. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard!")
        }
    }
    
}
