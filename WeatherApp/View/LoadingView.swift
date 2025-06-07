//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Raji on 06/06/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle( CircularProgressViewStyle(tint: .white))
            .frame(width: .infinity,height: .infinity)
         
    }
}

#Preview {
    LoadingView()
}
