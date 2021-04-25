//
//  Hangman.swift
//  Hangman
//
//  Created by Paul Richardson on 24/04/2021.
//

import Foundation

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
		self.wordToGuess = wordToGuess
		score = 0
	}

	func makeGuess(letter: String) {
		if wordToGuess.contains(letter) {
			// correct
			correctGuesses.append(letter)
		} else {
			// incorrect
			score += 1
		}
		delegate?.hangmanDidMakeGuessWithResult()
	}

}
