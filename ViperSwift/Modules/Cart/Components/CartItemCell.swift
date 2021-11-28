//
//  CartItemCell.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/29/21.
//

import Foundation
import UIKit

class CartItemCell: UITableViewCell {
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubviews()
        backgroundColor = .clear
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.contentView.addSubview(image)
        self.contentView.addSubview(title)
        self.contentView.addSubview(price)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        
        image.snp.remakeConstraints { (make) -> Void in
            make.width.height.equalTo(44)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        title.snp.remakeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(20)
        }
        
        price.snp.remakeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-40)
        }
        
        super.updateConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        self.title.text = nil
        self.price.text = nil
    }
}
