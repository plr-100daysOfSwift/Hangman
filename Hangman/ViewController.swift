//
//  ViewController.swift
//  Hangman
//
//  Created by Paul Richardson on 24/04/2021.
//

import UIKit

class ViewController: UIViewController {

	var hangman: Hangman?

	override func viewDidLoad() {
		super.viewDidLoad()
		hangman = Hangman()
	}

}

