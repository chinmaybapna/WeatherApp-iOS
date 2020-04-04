//
//  ViewController.swift
//  WeatherApp
//
//  Created by Chinmay Bapna on 03/04/20.
//  Copyright © 2020 Chinmay Bapna. All rights reserved.
//

import UIKit
import CoreLocation

class weatherViewController : UIViewController {
    
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        textField.delegate = self
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        textField.endEditing(true)
        if let text = textField.text {
             weatherManager.fetchWeatherURL(cityName: text)
        }
        textField.text = ""
    }

    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension weatherViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let city = textField.text {
            weatherManager.fetchWeatherURL(cityName: city)
        }
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Type Something"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate

extension weatherViewController : WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModal) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weather.temperatureString) °C"
            self.cityNameLabel.text = weather.cityName
            self.conditionImage.image = UIImage(systemName: weather.conditionName)
        }
    }
}

//MARK: - CLLocationManagerDelegate

extension weatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeatherURL(lat: lat, lon: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
