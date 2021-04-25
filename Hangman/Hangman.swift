//
//  Hangman.swift
//  Hangman
//
//  Created by Paul Richardson on 24/04/2021.
//

import Foundation

// TODO: success should be an enum with associated value
typealias HangmanResult = Result<String, HangmanError>

class Hangman: HangmanProtocol {
	var delegate: HangmanDelegateProtocol?


	private var wordToGuess: String
	var score: Int
	var correctGuesses = [String]()
	var currentGuess: String {
		var word = ""
		for letter in wordToGuess {
			let strLetter = String(letter)
			if  correctGuesses.contains(strLetter) {
				word += strLetter
			} else {
				word += "?"
			}
		}
		return word
	}

	init?(wordToGuess: String = "hangman"  ) {
		// TODO: Load word from file
		self.wordToGuess = wordToGuess
		score = 0
	}

	func makeGuess(letter: String) -> HangmanResult {

		let letter = letter.lowercased()
		let result: HangmanResult
		
		if wordToGuess.contains(letter) {
			// correct
			correctGuesses.append(letter)

			// TODO: determine state of play

			return .success(currentGuess)
			
		} else {
			// incorrect
			score += 1
			if score < 7 {
				result = .failure(.incorrect)
			} else {
				reset()
				result = .failure(.hung)
			}
			return result
		}
	}

	func reset() {
		score = 0
		correctGuesses.removeAll()
	}

}
