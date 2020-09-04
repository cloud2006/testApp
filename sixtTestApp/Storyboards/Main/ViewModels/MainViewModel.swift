//
//  MainViewModel.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 03.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import Foundation

protocol MainViewModelOutput: AnyObject {
    
}

protocol MainViewModeling: AnyObject {

    var output: MainViewModelOutput? { get set }
    
    func getCellCount() -> Int
    
    func getCar(at index: Int) -> Car
}

final class MainViewModel {
    
    // MARK: - Private properties
    
    private var carData: [Car] = []
    
    private let network = NetworkService()

    // MARK: - Public properties
    
    weak var output: MainViewModelOutput?
    
    init() {
        network.fetchData { [weak self] in
            if let data = $0 {
                self?.carData = data
                debugPrint(data)
            }
        }
    }
}

extension MainViewModel: MainViewModeling {
    func getCar(at index: Int) -> Car {
        carData[index]
    }
    
    func getCellCount() -> Int {
        carData.count
    }
}
