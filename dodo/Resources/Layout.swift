//
//  Layout.swift
//  dodo
//
//  Created by Юлия Ястребова on 28.11.2024.
//

import UIKit

enum ScreenSize {
    static let bounds = UIScreen.main.bounds
    static let width =  UIScreen.main.bounds.width
    static let height =  UIScreen.main.bounds.height
}

enum Layout {
    enum Detail {
        static let imageHeight = ScreenSize.width
        static let imageWidth = ScreenSize.width
    }
}
