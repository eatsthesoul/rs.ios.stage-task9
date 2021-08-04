//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 2.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GalleryHeaderView: UICollectionReusableView {
    
    let closeButton: CloseButton = {
        let button = CloseButton()
        return button
    }()
    
    lazy var titleView: CoverView = {
        let view = CoverView(title: "", image: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var typeLabel: ItemTypeLabel = {
        let label = ItemTypeLabel(with: "Gallery")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(closeButton)
        self.addSubview(titleView)
        self.addSubview(typeLabel)
        self.addSubview(lineView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(_ data: Gallery?) {
        titleView.titleLabel.text = data?.title.trimmingCharacters(in: .newlines)
        titleView.image = data?.coverImage
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
                                        
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleView.heightAnchor.constraint(equalTo: titleView.widthAnchor, multiplier: 1.337),
            
            typeLabel.heightAnchor.constraint(equalToConstant: 40),
            typeLabel.widthAnchor.constraint(equalToConstant: 152),
            typeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            typeLabel.centerYAnchor.constraint(equalTo: titleView.bottomAnchor),
            
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            lineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 39),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
