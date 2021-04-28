//
//  HangmanProtocol.swift
//  Hangman
//
//  Created by Paul Richardson on 25/04/2021.
//

import Foundation

protocol HangmanProtocol: AnyObject {
	var wordToGuess: String { get }
	var currentGuess: String { get }
	var delegate: HangmanDelegateProtocol? { get set }

	func makeGuess(letter: String) -> HangmanResult
}
