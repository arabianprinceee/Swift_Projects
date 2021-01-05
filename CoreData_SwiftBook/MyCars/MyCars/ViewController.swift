//
//  ViewController.swift
//  MyCars
//
//  Created by Ivan Akulov on 08/02/20.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var context: NSManagedObjectContext!
    var car: Car!
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet { // Срабатывает при инициализации сегментед контрола
            updateSegmentedControl()
            segmentedControl.selectedSegmentTintColor = .white
            
            let whiteTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            let blackTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
            
            UISegmentedControl.appearance().setTitleTextAttributes(whiteTitleTextAttributes, for: .normal)
            UISegmentedControl.appearance().setTitleTextAttributes(blackTitleTextAttributes, for: .selected)
        }
    }
    
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var lastTimeStartedLabel: UILabel!
    @IBOutlet weak var numberOfTripsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var myChoiceImageView: UIImageView!
    
    @IBAction func segmentedCtrlPressed(_ sender: UISegmentedControl) {
        updateSegmentedControl()
    }
    
    @IBAction func startEnginePressed(_ sender: UIButton) {
        car.timesDriven += 1
        car.lastStarted = Date()
        
        do {
            try context.save()
            insertDataFrom(SelectedCar: car)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func rateItPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Rate it", message: "Rate this car", preferredStyle: .alert)
        
        let rateAction = UIAlertAction(title: "Rate", style: .default) { action in
            if let text = alertController.textFields?.first?.text {
                self.update(rating: (text as NSString).floatValue)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(rateAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateSegmentedControl() {
        let fetchRequset: NSFetchRequest<Car> = Car.fetchRequest()
        let mark = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        fetchRequset.predicate = NSPredicate(format: "mark == %@", mark!)
        
        do {
            let results = try context.fetch(fetchRequset)
            car = results.first
            insertDataFrom(SelectedCar: car!)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func update(rating: Float) {
        car.rating = rating
        
        do { 
            try context.save()
            insertDataFrom(SelectedCar: car)
        } catch let _ as NSError {
            let alertController = UIAlertController(title: "Invalid value", message: "Wrong input", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    private func insertDataFrom(SelectedCar car: Car) {
        carImageView.image = UIImage(data: car.imageData!)
        markLabel.text = car.mark
        modelLabel.text = car.model
        myChoiceImageView.isHidden = !(car.myChoice)
        ratingLabel.text = "Rating: \(car.rating) / 10"
        numberOfTripsLabel.text = "Number of trips: \(car.timesDriven)"
        
        lastTimeStartedLabel.text = "Last time started: \(dateFormatter.string(from: car.lastStarted!))"
        segmentedControl.backgroundColor = car.tintColor as? UIColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getdataFromFile()
        
        let fetchRequset: NSFetchRequest<Car> = Car.fetchRequest()
        let mark = segmentedControl.titleForSegment(at: 0)
        fetchRequset.predicate = NSPredicate(format: "mark == %@", mark!)
        
        do {
            let results = try context.fetch(fetchRequset)
            car = results.first
            insertDataFrom(SelectedCar: car!)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
}

// Для извлечения данных из data.plist
extension ViewController {
    
    private func getdataFromFile() {
        
        let fetchRequset: NSFetchRequest<Car> = Car.fetchRequest()
        fetchRequset.predicate = NSPredicate(format: "mark != nil")
        
        var records = 0
        
        do {
            records = try context.count(for: fetchRequset)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        guard let pathToFile = Bundle.main.path(forResource: "data", ofType: "plist"),
              let dataArray = NSArray(contentsOfFile: pathToFile) else { return }
        
        for dictionary in dataArray {
            
            let entity = NSEntityDescription.entity(forEntityName: "Car", in: context)
            let car = NSManagedObject(entity: entity!, insertInto: context) as! Car
            
            let carDictionary = dictionary as! [String : AnyObject]
            car.mark = carDictionary["mark"] as? String
            car.model = carDictionary["model"] as? String
            car.rating =  carDictionary["rating"] as! Float
            car.lastStarted = carDictionary["lastStarted"] as? Date
            car.timesDriven = carDictionary["timesDriven"] as! Int16
            car.myChoice = carDictionary["myChoice"] as! Bool
            
            let imageName = carDictionary["imageName"] as? String
            let image = UIImage(named: imageName!)
            let imageData = image?.pngData()
            car.imageData = imageData
            
            if let colorDictionary = carDictionary["tintColor"] as? [String : Float] {
                car.tintColor = getColor(colorDictionary : colorDictionary)
            }
        }
    }
    
    private func getColor(colorDictionary: [String : Float]) -> UIColor {
        guard let red = colorDictionary["red"],
              let green = colorDictionary["green"],
              let blue = colorDictionary["blue"]
        else { return UIColor() }
        
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: 1.0)
    }
    
}

