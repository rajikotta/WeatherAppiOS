//
//  ContentView.swift
//  WeatherApp
//
//  Created by Raji on 06/06/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()

    var body: some View {

        VStack {
            if let location = locationManager.location {
               WeatherView(location: location)
                    
            }else{
                
                if  locationManager.isLoading {
                    
                    LoadingView()
                }
                else{
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
        }
        .background(
            Color(
                hue: 0.762,
                saturation: 0.516,
                brightness: 0.409,
                opacity: 0.555
            )
        )
        .preferredColorScheme(.dark)
        
    }
}

#Preview {
    ContentView()
}
