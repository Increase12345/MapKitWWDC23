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
    @State var searchText = ""
    @State var results = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var showDetails = false
    @State private var getDirections = false
    
    var body: some View {
        Map(position: $cameraPosition, selection: $mapSelection) {
//            Marker("My location", systemImage: "paperplane", coordinate: .userLocation)
//                .tint(.blue)
            
            Annotation("My location", coordinate: .userLocation) {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.blue)
                        .opacity(0.25)
                    
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                    
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(.blue)
                }
            }
            
            ForEach(results, id: \.self) { item in
                let placemark = item.placemark
                Marker(placemark.name ?? "", coordinate: placemark.coordinate)
            }
        }
        .overlay(alignment: .top) {
            TextField("Search for a location...", text: $searchText)
                .font(.subheadline)
                .padding(12)
                .background(.white)
                .padding()
                .shadow(radius: 10)
        }
        .onSubmit(of: .text) {
            Task {
                await searchPlaces()
            }
        }
        .onChange(of: mapSelection, { oldValue, newValue in
            showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails) {
            LocationDetailsView(mapSelection: $mapSelection, show: $showDetails, getDirections: $getDirections)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        }
        .mapControls {
            MapCompass()
            MapPitchButton()
            MapUserLocationButton()
        }
    }
}

#Preview {
    ContentView()
}
