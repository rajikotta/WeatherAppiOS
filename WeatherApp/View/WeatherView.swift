//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Raji on 06/06/2025.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    var location: CLLocationCoordinate2D
    
    @StateObject var viewModel = WeatherViewModel()
    
    
    
    var body: some View {
        
        
        
        NavigationStack {
            
            
            VStack{
                
                if viewModel.isLoading {
                    
                    LoadingView()
                }
                else if let weather = viewModel.weatherData {
                   
                    ZStack(alignment: .leading) {
                                VStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(weather.name)
                                            .bold()
                                            .font(.title)
                                        
                                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                                            .fontWeight(.light)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Spacer()
                                    
                                    VStack {
                                        HStack {
                                            VStack(spacing: 20) {
                                                Image(systemName: "cloud")
                                                    .font(.system(size: 40))
                                                
                                                Text("\(weather.weather[0].main)")
                                            }
                                            .frame(width: 150, alignment: .leading)
                                            
                                            Spacer()
                                            
                                            Text(weather.main.feels_like.roundDouble() + "°")
                                                .font(.system(size: 100))
                                                .fontWeight(.bold)
                                                .padding()
                                        }
                                        
                                        Spacer()
                                            .frame(height:  80)
                                        
                                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 350)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                VStack {
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 20) {
                                        Text("Weather now")
                                            .bold()
                                            .padding(.bottom)
                                        
                                        HStack {
                                            WeatherRow(
                                                logo: "thermometer",
                                                name: "Min temp",
                                                value: (
                                                    weather.main.temp_min
                                                        .roundDouble() + ("°")
                                                )
                                            )
                                            Spacer()
                                            WeatherRow(
                                                logo: "thermometer",
                                                name: "Max temp",
                                                value: (
                                                    weather.main.temp_max
                                                        .roundDouble() + "°"
                                                )
                                            )
                                        }
                                        
                                        HStack {
                                            WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                                            Spacer()
                                            WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .padding(.bottom, 20)
                                    .foregroundColor(Color( hue: 0.762,
                                                            saturation: 0.516,
                                                            brightness: 0.409,
                                                            opacity: 0.555))
                                    .background(.white)
                                    .cornerRadius(20, corners: [.topLeft, .topRight])
                                }
                            }
                            .edgesIgnoringSafeArea(.bottom)
                            .background(Color( hue: 0.762,
                                               saturation: 0.516,
                                               brightness: 0.409,
                                               opacity: 0.555))
                            .preferredColorScheme(.dark)
                    
                }
                else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                }
            }
        }.onAppear {
            viewModel.fethWeatherData(for: location)

        }
    }
}
    #Preview {
//        WeatherView()
    }
