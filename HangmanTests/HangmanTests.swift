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

	func testChosenLetter_IsNotInWord_ScoreIncreases() {

		// Arrange
		let currentScore = sut.score

		// Act
		let result = sut.makeGuess(letter: incorrectLetter)

		//Assert
		XCTAssert(result == .failure(.incorrect), "The result should be .incorrect")
		XCTAssert(sut.score == currentScore + 1, "The score should be \(currentScore + 1) but is \(sut.score)")

	}

	func testChosenLetter_IsInWord_ScoreRemainsConstant() {

		// Arrange
		let currentScore = sut.score

		// Act
		let _ = sut.makeGuess(letter: correctLetter)

		//Assert
		XCTAssert(sut.score == currentScore, "The score should be \(currentScore) but is \(sut.score)")

	}

	func testChosenLetter_IsInWord_LetterAppendedToCorrectGuesses() {
		// Arrange
		let letter = correctLetter
		let oldCount = sut.correctGuesses.count

		// Act
		let _ = sut.makeGuess(letter: letter)
		let newCount = sut.correctGuesses.count

		// Assert
		XCTAssert(sut.correctGuesses.contains(letter), "Correct Guesses should contain \(letter), but does not: \(sut.correctGuesses.description)")
		XCTAssert(newCount == oldCount + 1, "Correct Guesses has not grown in size")
	}

	func testChosenLetter_IsInNotWord_CorrectGuessesRemainsConstant() {
		// Arrange
		let letter = incorrectLetter
		let oldCount = sut.correctGuesses.count

		// Act
		let _ = sut.makeGuess(letter: letter)
		let newCount = sut.correctGuesses.count

		// Assert
		XCTAssertFalse(sut.correctGuesses.contains(letter), "Correct Guesses should not contain \(letter), but does so: \(sut.correctGuesses.description)")
		XCTAssert(oldCount == newCount, "Correct guesses has increased by \(newCount - oldCount)")
	}

}
