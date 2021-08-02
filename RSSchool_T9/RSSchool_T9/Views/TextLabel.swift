//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 1.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class TextLabel: UILabel {

    init(with text: String?) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .black
        
        self.text = text
        font = UIFont(name: "Rockwell-Regular", size: 24)
        textColor = .white
        
        numberOfLines = 0
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 40)
        super.drawText(in: rect.inset(by: insets))
    }

}
