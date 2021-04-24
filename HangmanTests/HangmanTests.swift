//
//  HangmanTests.swift
//  HangmanTests
//
//  Created by Paul Richardson on 24/04/2021.
//

import XCTest
@testable import Hangman

class HangmanTests: XCTestCase {

	var sut: Hangman!

	override func setUpWithError() throws {
		sut = Hangman(wordToGuess: "rhtyhm")
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testChosenLetter_IsNotInWord_ScoreIncreases() {

		// Arrange
		let currentScore = sut.score

		// Act
		sut.makeGuess(letter: "q")

		//Assert
		XCTAssert(sut.score == currentScore + 1, "The score should be \(currentScore + 1) but is \(sut.score)")

	}

	func testChosenLetter_IsInWord_ScoreRemainsConstant() {

		// Arrange
		let currentScore = sut.score

		// Act
		sut.makeGuess(letter: "r")

		//Assert
		XCTAssert(sut.score == currentScore, "The score should be \(currentScore) but is \(sut.score)")

	}

}
