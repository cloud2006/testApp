//
//  MainViewModel.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 03.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainViewModelOutput: AnyObject {
    func reload()
}

protocol MainViewModeling: AnyObject {

    var output: MainViewModelOutput? { get set }
    
    var annotations: [MapAnnotation] { get }
    
    func getCellCount() -> Int
    
    func item(at index: Int) -> Car
    
    func carLocation(at index: Int) -> CLLocation
}

final class MainViewModel {
    
    // MARK: - Private properties
    
    private var carData: [Car] = [] {
        didSet {
            output?.reload()
        }
    }
    
    private let network = NetworkService()

    // MARK: - Public properties
    
    weak var output: MainViewModelOutput?
    
    init() {
        network.fetchData { [weak self] in
            switch $0 {
            case let .success(cars): self?.carData = cars
            case let .failure(error): print(error)
            }
        }
    }
}

extension MainViewModel: MainViewModeling {
    var annotations: [MapAnnotation] {
        carData.map { MapAnnotation(car: $0) }
    }
    
    func item(at index: Int) -> Car {
        carData[index]
    }
    
    func getCellCount() -> Int {
        carData.count
    }
    
    func carLocation(at index: Int) -> CLLocation {
        let car = carData[index]
        return CLLocation(latitude: car.latitude, longitude: car.longitude)
    }
}
