//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 1.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class CloseButton: UIButton {
    
    private lazy var xImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "xmark")
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 20
        
        self.addSubview(xImageView)
        
        NSLayoutConstraint.activate([
    
            self.heightAnchor.constraint(equalToConstant: 40),
            self.widthAnchor.constraint(equalToConstant: 40),
            
            xImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            xImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            xImageView.heightAnchor.constraint(equalToConstant: 21),
            xImageView.widthAnchor.constraint(equalToConstant: 19)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                xImageView.tintColor = UIColor(red: 0.475, green: 0.475, blue: 0.475, alpha: 1)
            } else {
                xImageView.tintColor = .white
            }
        }
    }
}
