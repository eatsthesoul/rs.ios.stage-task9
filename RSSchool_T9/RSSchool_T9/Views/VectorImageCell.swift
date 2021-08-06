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
    
    var timer: Timer?
    
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
    
    func drawVector() {
        
        drawView.layer.addSublayer(shape)
        
        if (SettingsMaster.sharedInstance().isStoriesDrawn) {
            timer?.invalidate()
            self.shape.strokeStart = 0
            self.shape.strokeEnd = 0
            self.timer = Timer.scheduledTimer(withTimeInterval: 1 / 60, repeats: true) { [self] timer in
                shape.strokeEnd += (0.01667 / 3)
                if (shape.strokeEnd >= 1) {
                    timer.invalidate()
                }
            }
            RunLoop.current.add(timer!, forMode: .common)
        } else {
            timer?.invalidate()
            self.shape.strokeEnd = 1
        }
    }
    
    func removeShapeLayer() {
        timer?.invalidate()
        self.shape.strokeStart = 0
        self.shape.strokeEnd = 0
        shape.removeFromSuperlayer()
    }
}


//
