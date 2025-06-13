//
//  GameProtocol.swift
//  Touch2Win
//
//  Created by Omar Regalado Mendoza on 22/05/25.
//

import Foundation
import UIKit
/**
 A protocol that defines communication methods from a logic layer (such as a ViewModel) to a presentation layer (such as a ViewController).

 It allows game logic to notify the view about UI updates and events that require a visual response, keeping both layers decoupled. The component of this protocol, usually the ViewController, is responsible for implementing the visual logic for each of these requests.
*/
protocol GameProtocol: AnyObject {
    
    /// Notifies that the game's main message needs to be updated.
    /// - Parameters:
    ///   - message: The new text to display.
    ///   - color: The suggested color for the text, calculated for optimal contrast.
    func didUpdateMessage(_ message: String, color: UIColor)
    
    /// Requests an update to the main view's background color.
    /// - Parameter color: The new background color to apply.
    func didUpdateBackgroundColor(_ color: UIColor)
    
    /// Request an update to the logo text color.
    /// - Parameter color: The new color to apply to the logo text.
    func didUpdateLogoTextColor(_ color: UIColor)
    
    /// Notify that a winner has been selected and that the reveal animation should begin.
    /// - Parameters:
    ///   - location: The point on the screen where the animation will originate (the location of the winning touch).
    ///   - overlayColor: The color the reveal animation should use for the shrinking layer.
    func didSelectWinnerAt(location: CGPoint, withOverlayColor overlayColor: UIColor)
    
    /// Requests the generation of haptic feedback.
    /// - Parameter style: The style or intensity of the haptic impact to be generated (e.g. `.medium`, `.heavy`).
    func requestsHapticFeedbackOfType(_ style: UIImpactFeedbackGenerator.FeedbackStyle)
    
    /// Requests an emphasis animation to be played on the main game label.
    func requestsGameLabelAnimation()
    
    /// Request an opacity and scale animation for the logo.
    ///
    /// It is typically used for the logo fade-in and fade-out animations at startup.
    /// - Parameters:
    ///   - alpha: The final opacity value (0.0 to 1.0).
    ///   - scale: The optional final scale value.
    ///   - animationDuration: The total duration of the animation.
    ///   - delay: The waiting time before the animation starts.
    ///   - options: The animation curve options (e.g. `.curveEaseOut`).
    ///   - completion: An optional block of code to execute when the animation ends.
    func requestsLogoAlphaUpdate(alpha: CGFloat, scale: CGFloat?, animationDuration: TimeInterval, delay: TimeInterval, options: UIView.AnimationOptions, completion: ((Bool) -> Void)?)
    
    /// Request an opacity animation for the main game label.
    /// - Parameters:
    ///   - alpha: The final opacity value (0.0 to 1.0).
    ///   - animationDuration: The duration of the animation.
    func requestsGameLabelAlphaUpdate(alpha: CGFloat, animationDuration: TimeInterval)
}
