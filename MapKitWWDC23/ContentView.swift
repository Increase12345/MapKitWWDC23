//
//  ContentView.swift
//  MapKitWWDC23
//
//  Created by Nick Pavlov on 6/29/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    var body: some View {
        Map(position: $cameraPosition) {
            Marker("My location", systemImage: "paperplane", coordinate: .userLocation)
                .tint(.blue)
        }
    }
}

#Preview {
    ContentView()
}
