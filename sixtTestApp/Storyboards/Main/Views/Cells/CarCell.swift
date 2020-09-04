//
//  CarCell.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 04.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import UIKit

final class CarCell: UITableViewCell {
    
    @IBOutlet private weak var imgCar: UIImageView!
    @IBOutlet private weak var lblModelName: UILabel!
    @IBOutlet private weak var lblFuelType: UILabel!
    @IBOutlet private weak var lblLicensePlate: UILabel!
    @IBOutlet private weak var lblInnerCleanliness: UILabel!
    
    func configure(with car: Car) -> Self {
        imgCar.image = UIImage(named: "car")
        lblModelName.text = car.modelName
        lblFuelType.text = car.fuelType
        lblLicensePlate.text = car.licensePlate
        lblInnerCleanliness.text = car.innerCleanliness
        return self
    }
}
