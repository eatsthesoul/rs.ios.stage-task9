//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 1.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class TitleView: UIImageView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rockwell-Regular", size: 48)
        label.textColor = .white
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = self.bounds
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.7, 1.0]
        return layer
    }()

    init(title: String?, image: UIImage?) {
        super.init(frame: CGRect.zero)
        
        self.image = image
        self.contentMode = .scaleAspectFill
        titleLabel.text = title?.trimmingCharacters(in: .newlines)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
        
        self.layer.addSublayer(gradientLayer)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -55)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    
}
