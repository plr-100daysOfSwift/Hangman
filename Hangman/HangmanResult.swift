//
//  HangmanResult.swift
//  Hangman
//
//  Created by Paul Richardson on 25/04/2021.
//

import Foundation

enum HangmanSuccess {
	case correct(String)
	case win
}

enum HangmanFailure: Error {
	case incorrect
	case loss
	case finished
	case unknown
}
