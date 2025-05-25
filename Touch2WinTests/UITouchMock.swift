//
//  UITouchMock.swift
//  Touch2WinTests
//
//  Created by Omar Regalado Mendoza on 25/05/25.
//

import UIKit

class UITouchMock: UITouch {
    private var _location: CGPoint
    init(location: CGPoint) {
        self._location = location
        super.init()
    }
    override func location(in view: UIView?) -> CGPoint {
        return _location
    }
}
