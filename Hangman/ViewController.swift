//
//  ViewController.swift
//  Hangman
//
//  Created by Paul Richardson on 24/04/2021.
//

import UIKit

class ViewController: UIViewController {

	var hangman: Hangman?
	let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "L", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "", "Y", "Z", ""]
	var wordView = UITextField()

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white

		wordView.translatesAutoresizingMaskIntoConstraints = false
		wordView.textAlignment = .center
		wordView.font = UIFont.systemFont(ofSize: 48)
		wordView.text = "?????"
		view.addSubview(wordView)

		let inputView = UIView()
		inputView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(inputView)

		let rows = 7
		let columns = 4
		let width = 44
		let height = 44

		NSLayoutConstraint.activate([

			wordView.widthAnchor.constraint(equalToConstant: 200),
			wordView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			wordView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),

			inputView.widthAnchor.constraint(equalToConstant: CGFloat(columns * width)),
			inputView.heightAnchor.constraint(equalToConstant: CGFloat(rows * height)),
			inputView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
			inputView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

		])

		for row in 0 ..< rows {
			for column in 0 ..< columns {
				let letter = alphabet[(columns * row) + column]
				let button = UIButton(type: .system)
				button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
				button.setTitle(letter, for: .normal)
				button.layer.borderWidth = 0.5
				let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
				button.frame = frame
				inputView.addSubview(button)
			}
		}

	}

	override func viewDidLoad() {
		super.viewDidLoad()
		hangman = Hangman()
	}

}

