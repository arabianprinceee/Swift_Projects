//
//  ViewController.swift
//  Sunny
//
//  Created by Ivan Akulov on 24/02/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var NetWorkWM = NetWorkWeatherManager();
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { cityName in
            self.NetWorkWM.fetchCurrentWeather(forRequestType: .cityName(city: cityName))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetWorkWM.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
}


extension ViewController : NetworkWeatherManagerDelegate {
    func updateInterface(_: NetWorkWeatherManager, with currentWeather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = currentWeather.cityName
            self.temperatureLabel.text = currentWeather.tempString
            self.feelsLikeTemperatureLabel.text = currentWeather.feeldLikeString
            self.weatherIconImageView.image = UIImage(systemName: currentWeather.systemIconNameString)
        }
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        NetWorkWM.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
