//
//  Slideshow.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit
import SnapKit

class Slideshow: UIView {
    
    var slides: [Slide]?
    
    lazy var slider: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: Lifecycle
    init() {
        super.init(frame: .zero)
        addSubviews()
        slider.register(SlideCell.self, forCellWithReuseIdentifier: SlideCell.identity)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(slider)
        needsUpdateConstraints()
    }
    
    override func updateConstraints() {
        slider.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    func reload(slides: [Slide]?) {
        self.slides = slides
        DispatchQueue.main.async { [weak self] in
            self?.slider.reloadData()
        }
    }
}

extension Slideshow: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SlideCell = collectionView.dequeueCellAtIndexPath(indexPath: indexPath)
        if let slide = slides?[indexPath.row].image {
            cell.image.image = UIImage(named: slide)
        }
        return cell
    }


}

extension Slideshow: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}
