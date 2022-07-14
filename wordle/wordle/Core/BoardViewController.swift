//
//  BoardViewController.swift
//  wordle
//
//  Created by Amanda Detofol on 29/05/22.
//

import UIKit

protocol BoardViewControllerDataSource: AnyObject {
    var currentGuesses: [[Character?]] { get }
    func boxColor(at indexPath: IndexPath) -> UIColor?
}

class BoardViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(KeyCollectionViewCell.self, forCellWithReuseIdentifier: KeyCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
    }
    
    var datasource: BoardViewControllerDataSource?
    
    func reloadData(){
        self.collectionView.reloadData()
    }
    
    private func setupView() {
        self.view.addSubview(collectionView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
}


extension BoardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let size = (collectionView.frame.size.width-margin)/5
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 1, bottom: 2, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension BoardViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource?.currentGuesses.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource?.currentGuesses[section].count ?? 0 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCollectionViewCell.identifier, for: indexPath) as? KeyCollectionViewCell else { return UICollectionViewCell() }
       
        if let guesses = datasource?.currentGuesses {
            if let letter = guesses[indexPath.section][indexPath.row] {
                cell.letter = String(letter)
            }
        }
        
        cell.backgroundColor = datasource?.boxColor(at: indexPath) 
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.white.cgColor
        return cell
    }
}
