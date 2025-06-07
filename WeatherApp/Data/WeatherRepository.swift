//
//  Untitled.swift
//  WeatherApp
//
//  Created by Raji on 06/06/2025.
//
import CoreLocation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}


class WeatherRepository{
    
    func gerWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async -> Result<WeatherModel, Error> {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=30b6a42b5796b1bea23e08701cafc14a&units=metric") else {
            return .failure(NetworkError.invalidURL)

        }

        do {
                let (data, response) = try await URLSession.shared.data(from: url)

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    return .failure(NetworkError.invalidResponse)
                }

                let decoder = JSONDecoder()
            let weatherData = try decoder.decode(WeatherModel.self, from: data)
                return .success(weatherData)

            } catch {
                return .failure(NetworkError.requestFailed(error))
            }
        
    }
}


struct WeatherModel: Decodable {
    
    var coord: CoordinatesResponse
        var weather: [WeatherResponse]
        var main: MainResponse
        var name: String
        var wind: WindResponse

        struct CoordinatesResponse: Decodable {
            var lon: Double
            var lat: Double
        }

        struct WeatherResponse: Decodable {
            var id: Double
            var main: String
            var description: String
            var icon: String
        }

        struct MainResponse: Decodable {
            var temp: Double
            var feels_like: Double
            var temp_min: Double
            var temp_max: Double
            var pressure: Double
            var humidity: Double
        }
        
        struct WindResponse: Decodable {
            var speed: Double
            var deg: Double
        }
}
