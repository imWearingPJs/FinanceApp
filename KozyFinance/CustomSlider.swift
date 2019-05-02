//
//  CustomSlider.swift
//  KozyFinance
//
//  Created by Michael Kozub on 5/1/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
}
