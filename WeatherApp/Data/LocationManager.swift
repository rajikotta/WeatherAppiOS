//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Raji on 06/06/2025.
//

import Foundation
import CoreLocation

/// <#Description#>
class LocationManager : NSObject,ObservableObject, CLLocationManagerDelegate {
    
    @Published var location : CLLocationCoordinate2D?
    
    @Published var isLoading : Bool = false
   
    let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationUpdate() {
        
        isLoading = true
         locationManager.requestLocation( )
    }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        location = lastLocation.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error \(error)")
        isLoading = false
    }
}
