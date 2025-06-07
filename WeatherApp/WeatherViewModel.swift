//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Raji on 06/06/2025.
//

import Foundation
import CoreLocation
class WeatherViewModel : ObservableObject {
    @Published var weatherData : WeatherModel?
    @Published var errorMessage : String?
    @Published var isLoading : Bool = false
    
    private let weatherRepository : WeatherRepository = WeatherRepository()
    
    
    func fethWeatherData(for location :CLLocationCoordinate2D) {
        
        isLoading = true
        errorMessage = nil
        
        Task {@MainActor in 
            let result =  await weatherRepository.gerWeatherData(
                latitude: location.latitude,
                longitude: location.longitude
            )
            
            isLoading = false
            switch(result){
            case .success(let data):
                self.weatherData = data
            case .failure(let error):
                self.errorMessage = error.localizedDescription // Or handle error more specifically
                print("Error fetching weather: \(error)")
            }
            
        }
        
        
    }
}
