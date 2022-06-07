//
//  KeyCollectionViewCell.swift
//  wordle
//
//  Created by Amanda Detofol on 29/05/22.
//

import UIKit

class KeyCollectionViewCell: UICollectionViewCell {
    static let identifier: String  = "KeyCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var letter: String = "" {
        didSet {
            self.label.text = self.letter
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.label.text = nil 
    }
    
    private func setupView() {
        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 3
        self.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
