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
	let word = "rhythm"
	let correctLetter = "r"
	let incorrectLetter = "x"

	override func setUpWithError() throws {
		sut = Hangman(wordToGuess: word)
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testHangman_WhenChosenLetterIsNotInWord_ScoreIncreases() {

		// Arrange
		let currentScore = sut.score

		// Act
		let result = sut.makeGuess(letter: incorrectLetter)

		//Assert
		XCTAssert(result == .failure(.incorrect), "The result should be .incorrect")
		XCTAssert(sut.score == currentScore + 1, "The score should be \(currentScore + 1) but is \(sut.score)")

	}

	func testHangman_WhenChosenLetterIsInWord_ScoreRemainsConstant() {

		// Arrange
		let currentScore = sut.score

		// Act
		let _ = sut.makeGuess(letter: correctLetter)

		//Assert
		XCTAssert(sut.score == currentScore, "The score should be \(currentScore) but is \(sut.score)")

	}

	func testHangman_WhenLetterIsChosen_LetterAppendedToGuesses() {
		// Arrange
		let letter = correctLetter
		let oldCount = sut.guesses.count

		// Act
		let _ = sut.makeGuess(letter: letter)
		let newCount = sut.guesses.count

		// Assert
		XCTAssert(sut.guesses.contains(letter), "Correct Guesses should contain \(letter), but does not: \(sut.guesses.description)")
		XCTAssert(newCount == oldCount + 1, "Correct Guesses has not grown in size")
	}

	func testHangman_WhenAllLettersAreGuessed_GameEndsWithWin() {

		// Arrange
		// Act
		sut.lettersToGuess.forEach { let _ = sut.makeGuess(letter: String($0)) }

		// Assert
		XCTAssert(sut.guesses.isSuperset(of: sut.lettersToGuess), "All letters should be in guesses")
		XCTAssert(sut.isGameOver, "Game is won but isGameOver returns false")

	}

	// TODO: test makeGuess is returning correctly

}
