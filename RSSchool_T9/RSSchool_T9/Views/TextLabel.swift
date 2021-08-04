//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 1.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class TextLabel: UIView {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.black
        label.font = UIFont(name: "Rockwell-Regular", size: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    init(with text: String?) {
        super.init(frame: CGRect.zero)
        backgroundColor = .black
        
        self.addSubview(textLabel)
        textLabel.text = text

        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 40)
//        super.drawText(in: rect.inset(by: insets))
//    }

}
