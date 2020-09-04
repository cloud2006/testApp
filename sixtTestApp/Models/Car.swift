//
//  Car.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 03.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import Foundation

struct Car: Codable {
    let id: String
    let modelName: String
    let name: String
    let make: String
    let fuelType: String
    let fuelLevel: Float
    let transmission: String
    let licensePlate: String
    let latitude: Double
    let longitude: Double
    let innerCleanliness: String
    let carImageUrl: String
}
