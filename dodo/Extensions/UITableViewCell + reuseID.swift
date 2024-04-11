//
//  UITableViewCell + reuseID.swift
//  dodo
//
//  Created by Юлия Ястребова on 30.01.2024.
//

import UIKit

protocol Reusable {}

extension UITableViewCell: Reusable {}

extension Reusable where Self: UITableViewCell {
    
    static var reuseID: String {
        return String.init(describing: self)
    }
}
