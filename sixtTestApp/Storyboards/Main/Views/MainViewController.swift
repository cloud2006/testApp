//
//  ViewController.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 03.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Public properties
    
    var viewModel: MainViewModeling!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MainViewModel()
        viewModel.output = self
    }


}

extension MainViewController: MainViewModelOutput {
    
}
