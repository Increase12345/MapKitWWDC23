//
//  Extensions.swift
//  MapKitWWDC23
//
//  Created by Nick Pavlov on 6/29/23.
//

import Foundation
import MapKit

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
