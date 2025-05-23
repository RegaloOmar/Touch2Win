//
//  GameViewModel.swift
//  Touch2Win
//
//  Created by Omar Regalado Mendoza on 22/05/25.
//

import UIKit
import Foundation

class GameViewModel {
    
    // MARK: - Delegate
       weak var delegate: GameProtocol?

       // MARK: - State Properties
       private var touchLocations: [UITouch: CGPoint] = [:]
       private var winnerSelectionTimer: Timer?
       private var currentBackgroundColor: UIColor? {
           didSet {
               if let color = currentBackgroundColor {
                   delegate?.didUpdateBackgroundColor(color)
                   updateTextColorBasedOnBackground(color: color)
               }
           }
       }
       private(set) var gameMessage: String = "" {
           didSet {
               delegate?.didUpdateMessage(gameMessage, color: gameMessageColor)
           }
       }
       private var gameMessageColor: UIColor = .white
       private var logoTextColor: UIColor = .white {
           didSet {
               delegate?.didUpdateLogoTextColor(logoTextColor)
           }
       }

       // MARK: - Initialization
       init() { }
       
       func viewDidLoad() {
           setupInitialState()
           delegate?.requestsGameLabelAlphaUpdate(alpha: 0, animationDuration: 0)
           delegate?.requestsLogoAlphaUpdate(alpha: 0, scale: nil, animationDuration: 0, delay: 0, options: [], completion: nil)
           startLogoAnimationSequence()
       }

       private func setupInitialState() {
           currentBackgroundColor = generateRandomColor()
           gameMessage = "Touch the screen to play"
       }

       // MARK: - Game Logic
       func handleTouchesBegan(_ touches: Set<UITouch>, in view: UIView) {
           for touch in touches {
               let location = touch.location(in: view)
               touchLocations[touch] = location
               delegate?.requestsHapticFeedbackOfType(.medium)
           }

           if winnerSelectionTimer == nil && touchLocations.count >= 2 {
               gameMessage = "Keep the screen tapped!"
               startWinnerSelectionTimer()
           }
       }

       func handleTouchesEnded(_ touches: Set<UITouch>, in view: UIView) {
           for touch in touches {
               touchLocations[touch] = nil
           }

           let remainingTouches = touchLocations

           if winnerSelectionTimer == nil && remainingTouches.isEmpty {
               self.resetGame()
           } else if !remainingTouches.isEmpty && winnerSelectionTimer != nil && remainingTouches.count < 2 {
                winnerSelectionTimer?.invalidate()
                winnerSelectionTimer = nil
                gameMessage = "¡Ooops, remmember the game is for 2 o more players"
               DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.resetGame()
                }
           } else if remainingTouches.isEmpty && winnerSelectionTimer != nil {
               winnerSelectionTimer?.invalidate()
               winnerSelectionTimer = nil
               gameMessage = "Keep yor fingers in the game"
               DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                   self.resetGame()
               }
           }
       }

       private func startWinnerSelectionTimer() {
           winnerSelectionTimer?.invalidate()
           winnerSelectionTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
               self?.selectAndRevealWinner()
           }
       }

       private func selectAndRevealWinner() {
           winnerSelectionTimer?.invalidate()
           winnerSelectionTimer = nil

           let validTouches = touchLocations

           guard !validTouches.isEmpty else {
               gameMessage = "Please remmember is a 2 or more players game :D"
               resetGame()
               return
           }

           if let randomTouchKey = validTouches.keys.randomElement(),
              let winningLocation = touchLocations[randomTouchKey] {

               let previousBackgroundColor = self.currentBackgroundColor ?? .systemTeal
               var newWinningColor = generateRandomColor()
               var attempts = 0
               while newWinningColor == previousBackgroundColor && attempts < 10 {
                   newWinningColor = generateRandomColor()
                   attempts += 1
               }
               
               self.currentBackgroundColor = newWinningColor
               
               delegate?.didSelectWinnerAt(location: winningLocation, withOverlayColor: previousBackgroundColor)

               gameMessage = "Congratulations, you are the winner!!"
               delegate?.requestsGameLabelAnimation()
               delegate?.requestsHapticFeedbackOfType(.heavy)
           } else {
               gameMessage = "No one win"
           }
       }

       func resetGame() {
           winnerSelectionTimer?.invalidate()
           winnerSelectionTimer = nil
           touchLocations.removeAll()
           
           setupInitialState()
           delegate?.requestsGameLabelAlphaUpdate(alpha: 1.0, animationDuration: 0.5)
       }

       // MARK: - Color Logic
       private func generateRandomColor() -> UIColor {
           var red, green, blue: CGFloat
           var generatedColor: UIColor = .clear
           var isColorAcceptable = false
           let minBrightness: CGFloat = 0.15
           let maxBrightness: CGFloat = 0.85

           while !isColorAcceptable {
               red = CGFloat.random(in: 0...1)
               green = CGFloat.random(in: 0...1)
               blue = CGFloat.random(in: 0...1)

               let isPureBlack = red < 0.05 && green < 0.05 && blue < 0.05
               let isPureWhite = red > 0.95 && green > 0.95 && blue > 0.95

               // Not too dark colors
               let isTooDark = red < minBrightness && green < minBrightness && blue < minBrightness
               // Not too light colors
               let isTooLight = red > maxBrightness && green > maxBrightness && blue > maxBrightness
               
               if !isPureBlack && !isPureWhite && !isTooDark && !isTooLight {
                   generatedColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
                   isColorAcceptable = true
               }
           }
           return generatedColor
       }
       
       private func isColorLight(_ color: UIColor) -> Bool {
           var white: CGFloat = 0
           color.getWhite(&white, alpha: nil)
           return white > 0.55
       }

       private func updateTextColorBasedOnBackground(color: UIColor?) {
           guard let bgColor = color else { return }
           let determinedTextColor: UIColor = isColorLight(bgColor) ? .black : .white
           
           
           if self.gameMessageColor != determinedTextColor {
                self.gameMessageColor = determinedTextColor
                delegate?.didUpdateMessage(gameMessage, color: self.gameMessageColor)
           }
          
           
           if self.logoTextColor != determinedTextColor {
               self.logoTextColor = determinedTextColor
           }
       }
       
       // MARK: - Logo Animation Logic
       private func startLogoAnimationSequence() {
           delegate?.requestsLogoAlphaUpdate(
               alpha: 1.0,
               scale: 1.1,
               animationDuration: 1.0,
               delay: 0.5,
               options: .curveEaseOut,
               completion: { [weak self] completedFadeIn in
                   guard let self = self, completedFadeIn else { return }

                   self.delegate?.requestsLogoAlphaUpdate(
                       alpha: 0.0,
                       scale: nil,
                       animationDuration: 1.0,
                       delay: 1.0,
                       options: .curveEaseIn,
                       completion: { [weak self] completedFadeOut in
                           guard let self = self, completedFadeOut else { return }
                           self.delegate?.requestsGameLabelAlphaUpdate(alpha: 1.0, animationDuration: 0.5)
                       }
                   )
               }
           )
       }
}
