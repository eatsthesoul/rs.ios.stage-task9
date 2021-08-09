//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 2.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GalleryVC: ItemContentVC {
    
    var data: Gallery
    
//MARK: - UI properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isUserInteractionEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "GalleryCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var collectionViewHeightConstraint = {
        NSLayoutConstraint(item: collectionView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 0)
    }()
    
//MARK: - Initializers

    init(with data: Gallery) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData(with: data)
        
        contentView.addSubview(collectionView)
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let verticalImageHeight = (view.safeAreaLayoutGuide.layoutFrame.width - 40) * 1.337
        
        //collectionView height for vertical orientation
        if view.bounds.height > view.bounds.width {
            collectionViewHeightConstraint.constant = (verticalImageHeight + 20) * CGFloat(data.images.count)
        //for horizontal
        } else {
            let linesForImages = (CGFloat(data.images.count) / 3).rounded(.up)
            collectionViewHeightConstraint.constant = verticalImageHeight / 3 * linesForImages + 20
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
//MARK: - Setup methods
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 40),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionViewHeightConstraint
        ])
    }
}

//MARK: - Collection View Data Source

extension GalleryVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCollectionViewCell
        cell.imageView.image = data.images[indexPath.row]

        return cell
    }
}

//MARK: - Collection View Layout

extension GalleryVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if view.bounds.height > view.bounds.width {
            let width = view.safeAreaLayoutGuide.layoutFrame.width - 40
            let height = width * 1.337
            return CGSize(width: width, height: height)
        } else {
            let width = view.safeAreaLayoutGuide.layoutFrame.width / 3 - 27
            let height = width * 1.337
            return CGSize(width: width, height: height)
        }
    }
}

//MARK: - Collection View Delegate

extension GalleryVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let imageDetailVC = ImageDetailVC()

        let image = data.images[indexPath.row]
        imageDetailVC.setupImage(image)

        imageDetailVC.modalPresentationStyle = .fullScreen
        self.present(imageDetailVC, animated: true, completion: nil)
    }
}
