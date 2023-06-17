//
//  ViewController.swift
//  Weather App
//
//  Created by Administrator on 17/06/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    @IBOutlet weak var inputCity: UITextField!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelDegree: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBAction func onSearchLocation(_ sender: UIButton) {
        textFieldShouldReturn(inputCity)
    }
    @IBAction func onResetLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            weatherManager.fetchWeatherByLocation(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        inputCity.delegate = self

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputCity.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if inputCity.text == "" {
            inputCity.placeholder = "Type your city"
            return false
        } else {
            inputCity.placeholder = "Search"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = inputCity.text {
            weatherManager.fetchWeatherByCityName(cityName: cityName)
        }
        inputCity.text = ""
    }
    
    func didUpdateWeather(_ weather: WeatherModel) {
        print(weather.temperature)
        DispatchQueue.main.async {
            self.labelDegree.text = weather.temperature
            self.labelCity.text = weather.cityName
            self.imageWeather.image = UIImage(systemName: weather.iconName)
        }
    }
    
    func didFailure(_ error: Error) {
        print(error)
    }
}
