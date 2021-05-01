//
//  HangmanResult.swift
//  Hangman
//
//  Created by Paul Richardson on 25/04/2021.
//

import Foundation

typealias HangmanResult = Result<HangmanSuccess, HangmanFailure>

enum HangmanSuccess: Equatable {
	case correct(String)
	case win(String)

	var description: String {
		switch self {
		case .correct(_):
			return "correct"
		case .win(_):
			return "win"
		}
	}

}

enum HangmanFailure: Error {
	case incorrect
	case loss
	case finished
	case unknown
}

extension HangmanResult {
	func get() throws -> String {
		switch self {
		case .success(let value):
			return value.description
		case.failure(let error):
			throw error
		}
	}
}
