//
//  HangmanTests.swift
//  HangmanTests
//
//  Created by Paul Richardson on 24/04/2021.
//

import XCTest
@testable import Hangman

class HangmanTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testChosenLetter_IsNotInWord_ScoreIncreases() {

		// Arrange
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let sut = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController {
			let currentScore = sut.score
			sut.setWord(word: "rhythm")

			// Act
			sut.makeGuess(letter: "q")

			//Assert
			XCTAssert(sut.score == currentScore + 1, "The score should be \(currentScore + 1) but is \(sut.score)")

		}









	}

}
