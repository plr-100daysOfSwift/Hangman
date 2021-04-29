//
//  Hangman.swift
//  Hangman
//
//  Created by Paul Richardson on 24/04/2021.
//

import Foundation

class Hangman: HangmanProtocol {

	var delegate: HangmanDelegateProtocol?

	var words = [String]()

	var wordToGuess: String

	var lettersToGuess: Set<String> {
		return Set(wordToGuess.map { char in String(char) })
	}

	var guesses = Set<String>()

	var score: Int {
		return guesses.subtracting(lettersToGuess).count
	}

	var currentGuess: String {
		var word = ""
		for letter in wordToGuess {
			let strLetter = String(letter)
			word += guesses.contains(strLetter) ? strLetter : "?"
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
			switch isGameOver {
			case true:
				result = .success(.win(wordToGuess))
			case false:
				result = .success(.correct(currentGuess))
			}
		} else {
			switch score {
			case _ where score >= 7:
				reset()
				result = .failure(.loss)
			default:
				result = .failure(.incorrect)
			}
		}
		return result
	}

	func reset() {
		guesses.removeAll()
	}
	
	func newGame() {
		reset()
		wordToGuess = words.randomElement() ?? "hangman"
	}

}
