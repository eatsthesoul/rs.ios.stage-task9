//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 6.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ItemContentVC: UIViewController {
    
//MARK: - UI Properties
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let closeButton: CloseButton = {
        let view = CloseButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(closeButtonHandler), for: .touchUpInside)
        return view
    }()
    
    lazy var coverView: CoverView = {
        let view = CoverView(title: "", image: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var typeLabel: ItemTypeLabel = {
        let label = ItemTypeLabel(with: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var coverViewLeadingConstraint = {
        NSLayoutConstraint(item: coverView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0)
    }()
    
    private lazy var coverViewTrailingConstraint = {
        NSLayoutConstraint(item: coverView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: contentView,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0)
    }()
    
//MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubviews()
        setupLayout()
    }
    
    override func viewWillLayoutSubviews() {
        
        //cover view X layout
        let isLandscape = view.bounds.height > view.bounds.width
        coverViewLeadingConstraint.constant = isLandscape ? 20 : UIScreen.main.bounds.width * 0.25
        coverViewTrailingConstraint.constant = -coverViewLeadingConstraint.constant
    }
    
//MARK: - Congifure methods
    
    func setupData(with data: ItemContent) {
        coverView.image = data.coverImage
        coverView.titleLabel.text = data.title.trimmingCharacters(in: .newlines)
        setupTypeLabel(with: data.type)
    }
    
    private func setupTypeLabel(with text: String) {
        typeLabel.text = text
        typeLabel.sizeToFit()
        typeLabel.widthAnchor.constraint(equalToConstant: typeLabel.bounds.width + 60).isActive = true
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(closeButton)
        contentView.addSubview(coverView)
        contentView.addSubview(typeLabel)
        contentView.addSubview(lineView)
    }
    
    private func setupLayout() {

        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
            coverViewLeadingConstraint,
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            coverViewTrailingConstraint,
            coverView.heightAnchor.constraint(equalTo: coverView.widthAnchor, multiplier: 1.337),

            typeLabel.heightAnchor.constraint(equalToConstant: 40),
            typeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            typeLabel.centerYAnchor.constraint(equalTo: coverView.bottomAnchor),

            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            lineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 39),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @objc private func closeButtonHandler() {
        self.dismiss(animated: true, completion: nil)
    }
}
