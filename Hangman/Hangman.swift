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

	var words = [String]()

	private var wordToGuess: String
	var lettersToGuess: Set<String> {
		var temp = Set<String>()
		wordToGuess.forEach {temp.insert(String($0))}
		return temp
	}

	var guesses = Set<String>()
	var score: Int {
		return guesses.subtracting(lettersToGuess).count
	}

	var currentGuess: String {
		var word = ""
		for letter in wordToGuess {
			let strLetter = String(letter)
			if  guesses.contains(strLetter) {
				word += strLetter
			} else {
				word += "?"
			}
		}
		return word
	}

	init?(wordToGuess: String?) {

		if let wordToGuess = wordToGuess {
			self.wordToGuess = wordToGuess
		} else {
			if let wordsFileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
				if let wordsFileContents = try? String(contentsOf: wordsFileURL) {
					let lines = wordsFileContents.components(separatedBy: "\n")
					words.append(contentsOf: lines)
				}
			}
			self.wordToGuess = words.randomElement() ?? "hangman"
		}

//		score = 0
	}

	func makeGuess(letter: String) -> HangmanResult {

		let letter = letter.lowercased()
		let result: HangmanResult
		
		guesses.insert(letter)

			// TODO: determine state of play

			return .success(currentGuess)
			
		} else {
			// incorrect
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
		guesses.removeAll()
	}

}
