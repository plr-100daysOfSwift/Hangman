//
//  MockHangman.swift
//  HangmanTests
//
//  Created by Paul Richardson on 25/04/2021.
//

import Foundation
@testable import Hangman

class MockHangman: HangmanProtocol {

	var wordToGuess: String = "hangman"

	var delegate: HangmanDelegateProtocol?

	var makeGuessWasCalled = false

	var currentGuess: String {
		return ""
	}

	func makeGuess(letter: String) -> HangmanResult {
		makeGuessWasCalled = true
		return .success("")
	}

	func newGame() {
		// Do something
	}

}
