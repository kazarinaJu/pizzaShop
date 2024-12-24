//
//  CustomLabel.swift
//  dodo
//
//  Created by Юлия Ястребова on 02.12.2024.
//

import UIKit

final class CustomLabel: UILabel {
    
    static var centerRoundedThin11: CustomLabel {
        let label = CustomLabel()
        label.font = Fonts.proRoundedThin11
        label.textColor = Colors.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    static var centerRegular15: CustomLabel {
        let label = CustomLabel()
        label.font = Fonts.proRoundedRegular15
        label.textColor = Colors.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    static var centerRoundedBold15: CustomLabel {
        let label = CustomLabel()
        label.font = Fonts.proRoundedBold15
        label.textColor = Colors.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    static var centerRoundedBold22: CustomLabel {
        let label = CustomLabel()
        label.font = Fonts.proRoundedBold22
        label.textColor = Colors.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    static var leftRoundedBold22: CustomLabel {
        let label = CustomLabel()
        label.font = Fonts.proRoundedBold22
        label.textColor = Colors.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
    
    static var leftRoundedBold15: CustomLabel {
        let label = CustomLabel()
        label.font = Fonts.proRoundedBold15
        label.textColor = Colors.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
    
    static var leftRegular15: CustomLabel {
        let label = CustomLabel()
        label.font = Fonts.proRoundedRegular15
        label.textColor = Colors.black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }
    
    static var rightRegular15: CustomLabel {
        let label = CustomLabel()
        label.font = Fonts.proRoundedRegular15
        label.textColor = Colors.black
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }
}

