//
//  MapAnnotation.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 04.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import Foundation
import MapKit

final class MapAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(car: Car) {
        title = car.title
        coordinate = CLLocationCoordinate2D(latitude: car.latitude, longitude: car.longitude)
        
        super.init()
    }
}
