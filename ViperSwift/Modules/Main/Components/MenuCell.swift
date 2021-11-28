//
//  MenuCell.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit

class MenuCell: UITableViewCell {
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 1
        view.layer.masksToBounds = true
        return view
    }()
    
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
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add To Cart", for: .normal)
        button.addTarget(self, action: #selector(didTouchUpInsideAddButton(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray

        return button
    }()
    
    @objc func didTouchUpInsideAddButton(_ button: UIButton) {
        CartManager.shared.addToCart(id: button.tag)
    }
    
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
        self.contentView.addSubview(container)
        container.addSubview(image)
        container.addSubview(title)
        container.addSubview(price)
        container.addSubview(addButton)
        
        setNeedsUpdateConstraints()
    }
    
    
    override func updateConstraints() {
        container.snp.remakeConstraints { (make) -> Void in
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
        image.snp.remakeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(230)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        title.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        price.snp.remakeConstraints { (make) -> Void in
            make.centerY.equalTo(title)
            make.leading.equalTo(title.snp.trailing).offset(20)
        }
        
        addButton.snp.remakeConstraints { (make) -> Void in
            make.centerY.equalTo(title)
            make.width.equalTo(120)
            make.trailing.equalTo(-20)
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
