//
//  SlideCell.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit

class SlideCell: UICollectionViewCell {
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.contentView.addSubview(image)
        
        setNeedsUpdateConstraints()
    }
    
    
    override func updateConstraints() {
        image.snp.remakeConstraints { (make) -> Void in
            make.width.height.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
    }
}
