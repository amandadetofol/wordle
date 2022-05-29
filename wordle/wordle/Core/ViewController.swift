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
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    private lazy var boardViewController: BoardViewController = {
        let viewController = BoardViewController()
        viewController.didMove(toParent: self)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()

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
            boardViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            boardViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
            boardViewController.view.heightAnchor.constraint(equalToConstant: self.view.bounds.width),
            
            keyboardViewController.view.topAnchor.constraint(equalTo: self.boardViewController.view.bottomAnchor, constant: 32),
            keyboardViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            keyboardViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
            keyboardViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32),
        
        ])
    }

}
