//
//  ViewController.swift
//  wordle
//
//  Created by Amanda Detofol on 29/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var keyboardViewController: KeyboardViewController = {
        let viewController = KeyboardViewController()
        viewController.didMove(toParent: self)
        viewController.delegate = self
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    private lazy var boardViewController: BoardViewController = {
        let viewController = BoardViewController()
        viewController.didMove(toParent: self)
        viewController.datasource = self
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5),
                                       count: 5)
    
    let correctAnswer: String = "after"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView(){
        self.view.backgroundColor = .black
        self.addChild(keyboardViewController)
        self.addChild(boardViewController)
        self.view.addSubview(keyboardViewController.view)
        self.view.addSubview(boardViewController.view)
        self.setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            boardViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            boardViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            boardViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            boardViewController.view.heightAnchor.constraint(equalToConstant: self.view.bounds.width),
            
            keyboardViewController.view.topAnchor.constraint(equalTo: self.boardViewController.view.bottomAnchor),
            keyboardViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            keyboardViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            keyboardViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        
        ])
    }

}

extension ViewController: BoardViewControllerDataSource {
    func boxColor(at indexPath: IndexPath) -> UIColor? {

        let count = guesses[indexPath.section].compactMap({ $0 }).count
        guard count == 5 else {
            return nil
        }
        
        let indexedAnswer = Array(correctAnswer)
    
        guard let letter = guesses[indexPath.section][indexPath.row]?.lowercased(),
              indexedAnswer.contains(Character(letter)) else {
            return nil
        }
        
        if indexedAnswer[indexPath.row] == Character(letter) {
            return .systemGreen
        }
        
        return .systemOrange
    }
    
    var currentGuesses: [[Character?]] {
        return self.guesses
    }
}

extension ViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ viewController: KeyboardViewController, didTapKey letter: Character) {
        var stop: Bool = false
        
        for line in 0..<guesses.count {
            for columnn in 0..<guesses[line].count {
                if guesses[line][columnn] == nil {
                    guesses[line][columnn] = letter
                    stop = true
                    break
                }
            }
            
            if stop {
                break
            }
        }
        
        boardViewController.reloadData()
    }
}
