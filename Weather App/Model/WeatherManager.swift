//
//  WeatherManager.swift
//  Weather App
//
//  Created by Administrator on 18/06/2023.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailure(_ error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let nameURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=7a63d8e9b9fdd064b66ff477710e6f75"
    let coordURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=7a63d8e9b9fdd064b66ff477710e6f75"
    
    func fetchWeatherByCityName(cityName: String) {
        var fullURL = "\(nameURL)&q=\(cityName)"
        print(fullURL)
        performURL(urlString: fullURL)
    }
    
    func fetchWeatherByLocation(lat: Double, lon: Double) {
        var fullURL = "\(coordURL)&lat=\(lat)&lon=\(lon)"
        print(fullURL)
        performURL(urlString: fullURL)
    }
    
    func performURL(urlString: String) {
        let url = URL(string: urlString)
        if let safeUrl = url {
            let sesson = URLSession(configuration: .default)
            let task = sesson.dataTask(with: safeUrl) {(data, response, error) in
                if (error != nil) {
                    self.delegate?.didFailure(error!)
                }
                if let safeData = data {
                    var weather = parseData(data: safeData)
                    if (weather != nil) {
                        self.delegate?.didUpdateWeather(weather!)
                    }
                } else {
                    print("Data is nil")
                }}
            task.resume()
        } else {
            print("URL: \(urlString) is not correct.")
        }
    }
    
    func parseData(data: Data) -> WeatherModel? {
        do {
            let weather = try JSONDecoder().decode(WeatherData.self, from: data)
            
            if weather.message == nil {
                let model = WeatherModel(temp: weather.main!.temp, statusCode: weather.weather![0].id, cityName: weather.name!)
                return model
            }
            else {
                print(weather.message)
            }
        } catch {
            delegate?.didFailure(error)
        }
        return nil
    }
}
