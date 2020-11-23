//
//  MainTabBarController.swift
//  IMusic
//
//  Created by Анас Бен Мустафа on 11/21/20.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white;
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
        
        viewControllers = [ // Для tabBarVC добавляем вьюконтроллеры в массив
            generateViewController(rootVC: searchVC, image: #imageLiteral(resourceName: "search"), title: "Search"),
            generateViewController(rootVC: ViewController(), image: #imageLiteral(resourceName: "library"), title: "Library")
        ]
    }
     
    private func generateViewController(rootVC: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootVC.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
}
