//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 1.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class StoryVC: UIViewController {
    
    var data: Story?

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let closeButton: CloseButton = {
        let button = CloseButton()
        button.addTarget(self, action: #selector(closeButtonHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var titleView: TitleView = {
        let view = TitleView(title: data?.title, image: data?.coverImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var typeLabel: ItemTypeLabel = {
        let label = ItemTypeLabel(with: "Story")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var vectorImagesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 100
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 20)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(VectorImageCell.self, forCellWithReuseIdentifier: "VectorCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    lazy var textLabel: TextLabel = {
        let label = TextLabel(with: data?.text)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(with data: Story) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(titleView)
        scrollView.addSubview(typeLabel)
        scrollView.addSubview(lineView)
        scrollView.addSubview(vectorImagesCollection)
        scrollView.addSubview(textLabel)
        
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25),
            
            titleView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            titleView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            titleView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            titleView.heightAnchor.constraint(equalTo: titleView.widthAnchor, multiplier: 1.337),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            typeLabel.heightAnchor.constraint(equalToConstant: 40),
            typeLabel.widthAnchor.constraint(equalToConstant: 122),
            typeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeLabel.centerYAnchor.constraint(equalTo: titleView.bottomAnchor),
            
            lineView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 100),
            lineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 39),
            lineView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -100),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            vectorImagesCollection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            vectorImagesCollection.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 40),
            vectorImagesCollection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            vectorImagesCollection.heightAnchor.constraint(equalToConstant: 100),
            
            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            textLabel.topAnchor.constraint(equalTo: vectorImagesCollection.bottomAnchor, constant: 40),
            textLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vectorImagesCollection.reloadData()
    }
    
    @objc func closeButtonHandler() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension StoryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.paths.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VectorCell", for: indexPath) as! VectorImageCell
        cell.prepare(data!.paths[indexPath.row])
        cell.drawVector()

        return cell
    }
    
}

extension StoryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
}
