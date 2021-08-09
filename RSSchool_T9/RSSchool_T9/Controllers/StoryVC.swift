//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 1.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class StoryVC: ItemContentVC {
    
    var data: Story
    
//MARK: - UI Properties
    
    private var needToRedrawCollectionView = false
    
    lazy var vectorImagesCollectionView: UICollectionView = {
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
        let label = TextLabel(with: data.text)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//MARK: - Initializers
    
    init(with data: Story) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        setupData(with: data)

        contentView.addSubview(vectorImagesCollectionView)
        contentView.addSubview(textLabel)
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //reload collection view data because of settings could be changed
        vectorImagesCollectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        //redraw visible cells if vectorImagesCollectionView is visible
        needToRedrawCollectionView = true
        redrawVisibleCells()
    }
    
//MARK: - Setup methods
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            vectorImagesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vectorImagesCollectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 40),
            vectorImagesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vectorImagesCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textLabel.topAnchor.constraint(equalTo: vectorImagesCollectionView.bottomAnchor, constant: 40),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
        ])
    }
}

//MARK: VectorImagesCollectionView methods

extension StoryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.paths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VectorCell", for: indexPath) as! VectorImageCell
        return cell
    }
    
}
extension StoryVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let vectorCell = cell as? VectorImageCell {
            vectorCell.prepare(data.paths[indexPath.row])
            vectorCell.drawCell()
        }
    }
}

extension StoryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
}

extension StoryVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkIfNeedToRedraw()
    }
}

//MARK: VectorImagesCollectionView Drawings

extension StoryVC {
    
    private var contentOrigin: CGFloat { scrollView.contentOffset.y }
    private var collectionOrigin: CGFloat { vectorImagesCollectionView.frame.origin.y }
    private var collectionHeight: CGFloat { vectorImagesCollectionView.bounds.height }
    private var visibleScrollViewHeight: CGFloat { view.bounds.height - scrollView.frame.origin.y }
    
    private func checkIfNeedToRedraw() {
        //visible area above the collection view - need to clear cells
        if contentOrigin + visibleScrollViewHeight < collectionOrigin
            && !needToRedrawCollectionView {
            needToRedrawCollectionView = true
        }
        
        //visible area above the collection view - need to clear cells
        if  contentOrigin > collectionOrigin + collectionHeight
                && !needToRedrawCollectionView {
            needToRedrawCollectionView = true
        }

        //collection view is visible - need to redraw cells
        redrawVisibleCells()
    }
    
    private func redrawVisibleCells() {
        if contentOrigin <= collectionOrigin + collectionHeight
            && contentOrigin + visibleScrollViewHeight >= collectionOrigin
            && needToRedrawCollectionView {
            //drawing
            vectorImagesCollectionView.visibleCells.forEach { cell in
                if let vectorCell = cell as? VectorImageCell { vectorCell.drawCell() }
            }
            needToRedrawCollectionView = false
        }
    }
}

