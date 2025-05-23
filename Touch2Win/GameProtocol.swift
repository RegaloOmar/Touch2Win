//
//  GameProtocol.swift
//  Touch2Win
//
//  Created by Omar Regalado Mendoza on 22/05/25.
//

import Foundation
import UIKit

protocol GameProtocol: AnyObject {
    func didUpdateMessage(_ message: String, color: UIColor)
    func didUpdateBackgroundColor(_ color: UIColor)
    func didUpdateLogoTextColor(_ color: UIColor)
    func didSelectWinnerAt(location: CGPoint, withOverlayColor overlayColor: UIColor)
    func requestsHapticFeedbackOfType(_ style: UIImpactFeedbackGenerator.FeedbackStyle)
    func requestsGameLabelAnimation()
    func requestsLogoAlphaUpdate(alpha: CGFloat, scale: CGFloat?, animationDuration: TimeInterval, delay: TimeInterval, options: UIView.AnimationOptions, completion: ((Bool) -> Void)?)
    func requestsGameLabelAlphaUpdate(alpha: CGFloat, animationDuration: TimeInterval)
}
