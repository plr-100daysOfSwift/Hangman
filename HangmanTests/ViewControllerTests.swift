//
//  ViewControllerTests.swift
//  HangmanTests
//
//  Created by Paul Richardson on 25/04/2021.
//

import XCTest
@testable import Hangman

class ViewControllerTests: XCTestCase {

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testViewController_WhenLetterTapped_MakesGuess() {
		// Arrange
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let sut = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController

		let mockHangman = MockHangman()
		sut?.hangman = mockHangman
		sut?.loadViewIfNeeded()

		// Act
		sut?.letterButtons[0].sendActions(for: .touchUpInside)

		// Assert
		XCTAssert(mockHangman.makeGuessWasCalled, "makeGuess should be called when pressing letter button")

	}

}
