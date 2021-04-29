//
//  HangmanResult.swift
//  Hangman
//
//  Created by Paul Richardson on 25/04/2021.
//

import Foundation

typealias HangmanResult = Result<HangmanSuccess, HangmanFailure>

enum HangmanSuccess {
	case correct(String)
	case win(String)
}

enum HangmanFailure: Error {
	case incorrect
	case loss
	case finished
	case unknown
}
