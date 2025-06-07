//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Raji on 06/06/2025.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = WeatherViewModel()

    
    var body: some View {
        VStack {
                   VStack(spacing: 20) {
                       Text("Welcome to the Weather App")
                           .bold()
                           .font(.title)
                       
                       Text("Please share your current location to get the weather in your area")
                           .padding()
                   }
                   .multilineTextAlignment(.center)
                   .padding()

                   
                   
                   LocationButton(.shareCurrentLocation) {
                       locationManager.requestLocationUpdate()
                   }
                   .cornerRadius(30)
                   .symbolVariant(.fill)
                   .foregroundColor(.white)
               }
               .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
//    WelcomeView()
}
