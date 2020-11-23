//
//  UIViewController + Storyboard.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 11/22/20.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T : UIViewController> () -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        }
        else {
            fatalError("Error: No initial VC in \(name) storyboard")
        }
    }
    
}
