//
//  MockGameDelegate.swift
//  Touch2Win
//
//  Created by Omar Regalado Mendoza on 25/05/25.
//

import UIKit
@testable import Touch2Win

class MockGameDelegate: GameProtocol {
    var didUpdateMessageCalled = false
    var updatedMessage: String?
    var updatedMessageColor: UIColor?

    var didUpdateBackgroundColorCalled = false
    var updatedBackgroundColor: UIColor?

    var didUpdateLogoTextColorCalled = false
    var updatedLogoTextColor: UIColor?

    var didSelectWinnerCalled = false
    var winnerLocation: CGPoint?
    var winnerOverlayColor: UIColor?

    var requestedHapticFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle?
    
    var didRequestGameLabelAnimation = false
    var didRequestLogoAlphaUpdate = false
    var didRequestGameLabelAlphaUpdate = false
    
    func didUpdateMessage(_ message: String, color: UIColor) {
        didUpdateMessageCalled = true
        updatedMessage = message
        updatedMessageColor = color
    }
    
    func didUpdateBackgroundColor(_ color: UIColor) {
        didUpdateBackgroundColorCalled = true
        updatedBackgroundColor = color
    }
    
    func didUpdateLogoTextColor(_ color: UIColor) {
        didUpdateLogoTextColorCalled = true
        updatedLogoTextColor = color
    }
    
    func didSelectWinnerAt(location: CGPoint, withOverlayColor overlayColor: UIColor) {
        didSelectWinnerCalled = true
        winnerLocation = location
        winnerOverlayColor = overlayColor
    }
    
    func requestsHapticFeedbackOfType(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        requestedHapticFeedbackStyle = style
    }
    
    func requestsGameLabelAnimation() {
        didRequestGameLabelAnimation = true
    }
    
    func requestsLogoAlphaUpdate(alpha: CGFloat, scale: CGFloat?, animationDuration: TimeInterval, delay: TimeInterval, options: UIView.AnimationOptions, completion: ((Bool) -> Void)?) {
        didRequestLogoAlphaUpdate = true
        completion?(true)
    }
    
    func requestsGameLabelAlphaUpdate(alpha: CGFloat, animationDuration: TimeInterval) {
        didRequestGameLabelAlphaUpdate = true
    }
}
