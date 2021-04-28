//
//  Hangman.swift
//  Hangman
//
//  Created by Paul Richardson on 24/04/2021.
//

import Foundation

typealias HangmanResult = Result<HangmanSuccess, HangmanFailure>

class Hangman: HangmanProtocol {

	var delegate: HangmanDelegateProtocol?

	var words = [String]()

	var wordToGuess: String
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
	var isGameOver: Bool {
		return guesses.isSuperset(of: lettersToGuess )
	}

	init?(wordToGuess: String?) {

		if let wordToGuess = wordToGuess {
			self.wordToGuess = wordToGuess
		} else {
			if let wordsFileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
				if let wordsFileContents = try? String(contentsOf: wordsFileURL) {
					let lines = wordsFileContents.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
					words.append(contentsOf: lines)
				}
			}
			self.wordToGuess = words.randomElement() ?? "hangman"
		}

	}

	func makeGuess(letter: String) -> HangmanResult {

		guard !isGameOver else {
			return .failure(.finished)
		}

		let letter = letter.lowercased()
		let result: HangmanResult
		
		guesses.insert(letter)

		if wordToGuess.contains(letter) {
			// correct
			if isGameOver {
				// result =  .win
				result = .success(.win)
			} else {
				result = .success(.correct(currentGuess))
			}

		} else {
			// incorrect
			if score < 7 {
				result = .failure(.incorrect)
			} else {
				reset()
				result = .failure(.loss)
			}
		}
		return result
	}

	func reset() {
		guesses.removeAll()
		// fetch new word to guess
	}
	
	func newGame() {
		reset()
		wordToGuess = words.randomElement() ?? "hangman"
	}

}
