//
//  UILabel+extension.swift
//  KozyFinance
//
//  Created by Michael Kozub on 4/30/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit

extension UILabel {
    func setQualifiedAmountFont() {
        self.font = UIFont(name: "Arial-BoldMT", size: 25)
    }
    
    func setTitleFont() {
        self.font = UIFont(name: "Arial", size: 18)
//        self.adjustsFontSizeToFitWidth = true
    }
    
    func setValueFont() {
        self.font = UIFont(name: "Arial", size: 18)
    }
}
