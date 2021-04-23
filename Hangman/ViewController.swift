//
//  ViewController.swift
//  Hangman
//
//  Created by Paul Richardson on 24/04/2021.
//

import UIKit

class ViewController: UIViewController {

	var wordToGuess: String?
	var score: Int = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	func setWord(word: String) {
		wordToGuess = word
	}

	func makeGuess(letter: Character) {
		if wordToGuess != nil {
			if wordToGuess!.contains(letter) {
				// correct
			} else {
				score += 1
			}
		}
	}

}

