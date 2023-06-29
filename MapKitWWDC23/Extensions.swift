//
//  Extensions.swift
//  MapKitWWDC23
//
//  Created by Nick Pavlov on 6/29/23.
//

import Foundation
import MapKit

// For contentView
extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        .init(latitude: 25.7602, longitude: -80.1959)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        .init(center: .userLocation, latitudinalMeters: 10_000, longitudinalMeters: 10_000)
    }
}

extension ContentView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        
        let results = try? await MKLocalSearch(request: request).start()
        self.results = results?.mapItems ?? []
    }
}

// For LocationDetailsView
extension LocationDetailsView {
    func fetchLookArroundPreview() {
        if let mapSelection {
            lookArroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookArroundScene = try? await request.scene
            }
        }
    }
}
