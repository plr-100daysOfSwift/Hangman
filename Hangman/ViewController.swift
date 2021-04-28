//
//  ViewController.swift
//  Hangman
//
//  Created by Paul Richardson on 24/04/2021.
//

import UIKit

class ViewController: UIViewController, HangmanDelegateProtocol {

	var hangman: HangmanProtocol?
	let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
	var wordView = UITextField()
	var letterButtons = [UIButton]()

	override func loadView() {

		if hangman == nil {
			hangman = Hangman(wordToGuess: nil)
			hangman?.delegate = self
		}

		view = UIView()
		view.backgroundColor = .white

		wordView.translatesAutoresizingMaskIntoConstraints = false
		wordView.textAlignment = .center
		wordView.font = UIFont.monospacedSystemFont(ofSize: 48, weight: .medium)
		wordView.text = hangman?.currentGuess
		view.addSubview(wordView)

		let inputView = UIView()
		inputView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(inputView)

		let rows = 7
		let columns = 4
		let width = 44
		let height = 44

		NSLayoutConstraint.activate([

			wordView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
			wordView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			wordView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),

			inputView.widthAnchor.constraint(equalToConstant: CGFloat(columns * width)),
			inputView.heightAnchor.constraint(equalToConstant: CGFloat(rows * height)),
			inputView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
			inputView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

		])

		var alphabetExtended = alphabet
		alphabetExtended.insert("", at: 24)
		alphabetExtended.append("")

		for row in 0 ..< rows {
			for column in 0 ..< columns {
				let letter = alphabetExtended[(columns * row) + column]
				guard !letter.isEmpty else {
					continue
				}
				let button = UIButton(type: .system)
				button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
				button.setTitle(letter, for: .normal)
				button.layer.borderWidth = 0.5
				let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
				button.frame = frame
				button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
				inputView.addSubview(button)
				letterButtons.append(button)
			}
		}

	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@objc func letterTapped(_ sender: UIButton) {
		guard let letter = sender.titleLabel?.text else { return }
		sender.isEnabled = false
		if let result: HangmanResult = hangman?.makeGuess(letter: letter) {
			switch result {
			case .success(let answer):
				wordView.text = answer.uppercased()
				// TODO: Handle successful completiom of game
			case.failure(.loss):
				showAlert()
			default:
				break
			}
		}
	}

	fileprivate func showAlert(isWinner win: Bool) {
		let title: String
		let action: UIAlertAction
		switch win {
		case true:
			title = "Well done!"
			action = UIAlertAction(title: "New game", style: .default, handler: newGame)
		case false:
			title = "Hmm, too bad."
			action = UIAlertAction(title: "Try again", style: .default, handler: resetInterface)
		}
		let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
		ac.addAction(action)
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		present(ac, animated: true)
	}

	@objc func resetInterface(action: UIAlertAction) {
		wordView.text = hangman?.currentGuess
		for button in letterButtons {
			button.isEnabled = true
		}
	}

	@objc func newGame(action: UIAlertAction) {
		hangman?.newGame()
		resetInterface(action: action)
	}

}

