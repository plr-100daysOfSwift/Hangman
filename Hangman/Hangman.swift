//
//  Hangman.swift
//  Hangman
//
//  Created by Paul Richardson on 24/04/2021.
//

import Foundation

class Hangman {

	private var wordToGuess: String
	var score: Int
	var correctGuesses = [Character]()

	init?(wordToGuess: String = "hangman"  ) {
		self.wordToGuess = wordToGuess
		score = 0
	}

	func makeGuess(letter: Character) {
		if wordToGuess.contains(String(letter)) {
			// correct
			correctGuesses.append(letter)
		} else {
			// incorrect
			score += 1
		}
	}

}
