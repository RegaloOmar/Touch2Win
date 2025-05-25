//
//  GameViewModelTest.swift
//  Touch2WinTests
//
//  Created by Omar Regalado Mendoza on 25/05/25.
//

import XCTest
@testable import Touch2Win

final class GameViewModelTests: XCTestCase {

    var sut: GameViewModel!
    var mockDelegate: MockGameDelegate!

    override func setUp() {
        super.setUp()
        sut = GameViewModel()
        mockDelegate = MockGameDelegate()
        sut.delegate = mockDelegate
    }

    override func tearDown() {
        sut = nil
        mockDelegate = nil
        super.tearDown()
    }

    // MARK: - viewDidLoad
    
    func test_viewDidLoad_initialStateIsSet() {
        sut.viewDidLoad()

        XCTAssertTrue(mockDelegate.didUpdateBackgroundColorCalled)
        XCTAssertTrue(mockDelegate.didUpdateMessageCalled)
        XCTAssertTrue(mockDelegate.didRequestLogoAlphaUpdate)
        XCTAssertTrue(mockDelegate.didRequestGameLabelAlphaUpdate)
    }

    // MARK: - handleTouchesBegan
    
    func test_handleTouchesBegan_withTwoTouches_startsWinnerSelectionTimer() {
        let view = UIView()
        let touch1 = UITouchMock(location: CGPoint(x: 10, y: 10))
        let touch2 = UITouchMock(location: CGPoint(x: 20, y: 20))

        sut.handleTouchesBegan([touch1, touch2], in: view)

        XCTAssertEqual(mockDelegate.requestedHapticFeedbackStyle, .medium)
        XCTAssertEqual(sut.gameMessage, "Keep the screen tapped!")
    }

    // MARK: - handleTouchesEnded
    
    func test_handleTouchesEnded_withAllTouchesEnded_resetsGame() {
        let view = UIView()
        let touch = UITouchMock(location: CGPoint(x: 10, y: 10))
        sut.handleTouchesBegan([touch], in: view)
        sut.handleTouchesEnded([touch], in: view)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockDelegate.didUpdateMessageCalled)
        }
    }

    // MARK: - resetGame
    
    func test_resetGame_clearsTouchesAndResetsMessage() {
        sut.resetGame()

        XCTAssertTrue(mockDelegate.didUpdateMessageCalled)
        XCTAssertTrue(mockDelegate.didUpdateBackgroundColorCalled)
        XCTAssertTrue(mockDelegate.didRequestGameLabelAlphaUpdate)
    }
}
