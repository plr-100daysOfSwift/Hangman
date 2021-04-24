//
//  HangmanTests.swift
//  HangmanTests
//
//  Created by Paul Richardson on 24/04/2021.
//

import XCTest
@testable import Hangman

class HangmanTests: XCTestCase {

	var storyboard: UIStoryboard!
	var sut: ViewController!

	override func setUpWithError() throws {
		storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController
		sut.loadViewIfNeeded()
	}

	override func tearDownWithError() throws {
		storyboard = nil
		sut = nil
	}

	func testChosenLetter_IsNotInWord_ScoreIncreases() {

		// Arrange
		let currentScore = sut.score
		sut.setWord(word: "rhythm")

		// Act
		sut.makeGuess(letter: "q")

		//Assert
		XCTAssert(sut.score == currentScore + 1, "The score should be \(currentScore + 1) but is \(sut.score)")

	}

}
