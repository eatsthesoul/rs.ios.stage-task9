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
    
    var needToRedrawCollectionView = false

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate =  self
        return scroll
    }()
    
    let closeButton: CloseButton = {
        let button = CloseButton()
        button.addTarget(self, action: #selector(closeButtonHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var titleView: CoverView = {
        let view = CoverView(title: data?.title, image: data?.coverImage)
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
        scrollView.addSubview(vectorImagesCollectionView)
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
            
            vectorImagesCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            vectorImagesCollectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 40),
            vectorImagesCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            vectorImagesCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            textLabel.topAnchor.constraint(equalTo: vectorImagesCollectionView.bottomAnchor, constant: 40),
            textLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //reload collection view data because of settings could be changed
        vectorImagesCollectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        //redraw visible cells if vectorImagesCollectionView is visible
        if contentOrigin <= collectionOrigin + collectionHeight
            && contentOrigin + view.bounds.height >= collectionOrigin {
            drawCells()
        }
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
        return cell
    }
    
}
extension StoryVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let vectorCell = cell as? VectorImageCell {
            vectorCell.prepare(data!.paths[indexPath.row])
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
    
    private func checkIfNeedToRedraw() {
        //visible area above the collection view - need to clear cells
        if contentOrigin + view.bounds.height < collectionOrigin
            && !needToRedrawCollectionView {
            needToRedrawCollectionView = true
        }
        
        //visible area above the collection view - need to clear cells
        if  contentOrigin > collectionOrigin + collectionHeight
                && !needToRedrawCollectionView {
            needToRedrawCollectionView = true
        }

        //collection view is visible - need to redraw cells
        if contentOrigin <= collectionOrigin + collectionHeight
            && contentOrigin + view.bounds.height >= collectionOrigin
            && needToRedrawCollectionView {
            needToRedrawCollectionView = false
            drawCells()
        }
    }
    
    private func drawCells() {
        vectorImagesCollectionView.visibleCells.forEach { cell in
            if let vectorCell = cell as? VectorImageCell { vectorCell.drawCell() }
        }
    }
}

