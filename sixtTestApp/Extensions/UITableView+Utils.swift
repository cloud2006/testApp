//
//  UITableView+Utils.swift
//  sixtTestApp
//
//  Created by Pavel Antonyuk on 04.09.2020.
//  Copyright © 2020 Pavel Antonyuk. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Nib name and reuseIdentifier must be equal to the class name
    ///
    /// - Parameter cellClass: any class that inherit from UITableViewCell
    func registerCell(_ cellClass: UITableViewCell.Type) {
        register(UINib(nibName: "\(cellClass)", bundle: nil), forCellReuseIdentifier: "\(cellClass)")
    }
    
    /// Cell reusable Identifier must be equal to cell class name
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(type)", for: indexPath) as! T //swiftlint:disable:this force_cast

    }
    
}
