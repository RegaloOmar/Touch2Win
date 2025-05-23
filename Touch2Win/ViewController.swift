//
//  ViewController.swift
//  Touch2Win
//
//  Created by Omar Regalado Mendoza on 22/05/25.
//

import UIKit
import CoreHaptics

class ViewController: UIViewController {

    // MARK: - UI Properties
    let gameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Touch 2 Win"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48, weight: .heavy)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // ViewModel
    private var viewModel: GameViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isMultipleTouchEnabled = true
        
        viewModel = GameViewModel()
        viewModel.delegate = self
        setupUI()
        viewModel.viewDidLoad()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(gameLabel)
        view.addSubview(logoLabel)

        NSLayoutConstraint.activate([
            gameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        viewModel.handleTouchesBegan(touches, in: view)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        viewModel.handleTouchesEnded(touches, in: view)
    }

    // MARK: - Animations
    private func animateGameLabelInternal() {
        UIView.animate(withDuration: 0.2, animations: {
            self.gameLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.gameLabel.transform = .identity
            }
        }
    }

    private func animateWinningColorReveal(at center: CGPoint, with overlayColor: UIColor) {
        let animationLayer = CAShapeLayer()
        animationLayer.fillColor = overlayColor.cgColor
        
        if let gameLabelLayer = gameLabel.layer.superlayer?.sublayers?.first(where: { $0 == gameLabel.layer }) {
            view.layer.insertSublayer(animationLayer, below: gameLabelLayer)
        } else {
            view.layer.addSublayer(animationLayer)
        }

        let maxRadius = sqrt(pow(view.bounds.width, 2) + pow(view.bounds.height, 2))
        let initialPath = UIBezierPath(arcCenter: center, radius: maxRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        let finalPath = UIBezierPath(arcCenter: center, radius: 0.1, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath

        animationLayer.path = initialPath
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = initialPath
        animation.toValue = finalPath
        animation.duration = 0.7
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            animationLayer.removeFromSuperlayer()
        }
        animationLayer.add(animation, forKey: "shrinkCircleAnimation")
        CATransaction.commit()
    }
}

//MARK: - GAME DELEGATE EXTENSION
extension ViewController: GameProtocol {
    
    func didUpdateMessage(_ message: String, color: UIColor) {
        gameLabel.text = message
        gameLabel.textColor = color
    }
    
    func didUpdateBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
    func didUpdateLogoTextColor(_ color: UIColor) {
        logoLabel.textColor = color
    }
    
    func didSelectWinnerAt(location: CGPoint, withOverlayColor overlayColor: UIColor) {
        animateWinningColorReveal(at: location, with: overlayColor)
    }
    
    func requestsHapticFeedbackOfType(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
    
    func requestsGameLabelAnimation() {
        animateGameLabelInternal()
    }
    
    func requestsLogoAlphaUpdate(alpha: CGFloat, scale: CGFloat?, animationDuration: TimeInterval, delay: TimeInterval, options: UIView.AnimationOptions, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: animationDuration, delay: delay, options: options, animations: {
                    self.logoLabel.alpha = alpha
                    if let scale = scale {
                        self.logoLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
                    } else {
                        self.logoLabel.transform = .identity
                    }
                }, completion: completion)
    }
    
    func requestsGameLabelAlphaUpdate(alpha: CGFloat, animationDuration: TimeInterval) {
        UIView.animate(withDuration: animationDuration) {
            self.gameLabel.alpha = alpha
        }
    }
    
    
}
