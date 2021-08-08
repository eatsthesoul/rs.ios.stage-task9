//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 1.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class VectorImageCell: UICollectionViewCell {
    
    private lazy var shape: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor(fromHexString: SettingsMaster.sharedInstance().strokeHex).cgColor
        layer.fillColor = nil
        layer.lineWidth = 1.0
        return layer
    }()
    
    private lazy var drawView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(drawView)
        
        NSLayoutConstraint.activate([
            drawView.leadingAnchor.constraint(equalTo:leadingAnchor, constant: 13),
            drawView.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(_ path: CGPath) {
        shape.path = path
    }
    
    func drawCell() {
        
        drawView.layer.addSublayer(shape)
        
        //animated drawing
        if (SettingsMaster.sharedInstance().isStoriesDrawn) {
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.duration = 3
                animation.fromValue = 0
                animation.toValue = 1
                shape.add(animation, forKey: "animatePath")
        //static
        } else {
            self.shape.strokeEnd = 1
        }
    }
}


//
