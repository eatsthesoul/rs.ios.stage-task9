//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 31.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ItemsViewController: UIViewController {
    
    let numberOfCellsInLine = 2
    let data = FillingData.data
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 30
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        
        collection.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ItemsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCollectionViewCell
        
        switch data[indexPath.row] {
        case .story(let story):
            cell.imageView.image = story.coverImage
            cell.titleLabel.text = story.title
            cell.contentTypeLabel.text = "Story"
        case .gallery(let gallery):
            cell.contentTypeLabel.text = "Galery"
            cell.imageView.image = gallery.coverImage
            cell.titleLabel.text = gallery.title
        }

        return cell
    }
    
}

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 2 - 8 - 20
        let height = width * 1.229
        
        return CGSize(width: width, height: height)
    }
}

extension ItemsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch data[indexPath.row] {
        case .story(let story):
            let storyVC = StoryVC(with: story)
            storyVC.modalPresentationStyle = .fullScreen
            present(storyVC, animated: true, completion: nil)
        case .gallery(let gallery):
            let galleryVC = GalleryVC(with: gallery)
            galleryVC.modalPresentationStyle = .fullScreen
            present(galleryVC, animated: true, completion: nil)
        }
    }
}




