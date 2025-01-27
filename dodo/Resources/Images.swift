//
//  Images.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.11.2024.
//

import UIKit

struct Images {    
    static let infoCircle = UIImage(systemName: "info.circle")
    static let xmark = UIImage(systemName: "xmark")
    static let locationFill = UIImage(
        systemName: "location.fill",
        withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 25.0
        )
    )
    static let address = UIImage(
        systemName: "figure.walk",
        withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 20.0
        )
    )
    static let cart = UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
    static let personFill = UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30.0))
    static let flagCircleFill = UIImage(systemName: "flag.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30.0))
    
    
    static let pinUrl = URL(string: "https://f.uguu.se/daYCEAyz.png")
    static let emptyCartUrl = URL(string: "https://d.uguu.se/hCKrDNhL.jpg")
    static let loginUrl = URL(string: "https://f.uguu.se/uxrkzwVG.jpeg")
    static let splashUrl = URL(string: "https://example.com/image.png")
}


