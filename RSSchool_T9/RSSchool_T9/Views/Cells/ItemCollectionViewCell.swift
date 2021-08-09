//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 31.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Rockwell-Regular", size: 16)
        return label
    }()
    
    lazy var contentTypeLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        label.font = UIFont(name: "Rockwell-Regular", size: 12)
        return label
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = imageView.bounds
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.7, 1.0]
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 18
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(contentTypeLabel)
        imageView.layer.addSublayer(gradientLayer)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = imageView.bounds
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 17),

            contentTypeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentTypeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            contentTypeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            contentTypeLabel.heightAnchor.constraint(equalToConstant: 13),
            
        ])
    }
}
