//
//  MenuCell.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit

class MenuCell: UITableViewCell {
    var pizza: Pizza?
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 5
        return view
    }()
    
    lazy var wrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var infoBg: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
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
        if let pizza = pizza {
            CartManager.shared.addToCart(pizza: pizza)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubviews()
        backgroundColor = .clear
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.contentView.addSubview(container)
        container.addSubview(wrapper)
        wrapper.addSubview(image)
        wrapper.addSubview(infoBg)
        wrapper.addSubview(title)
        wrapper.addSubview(price)
        wrapper.addSubview(addButton)
        
        setNeedsUpdateConstraints()
    }
    
    
    override func updateConstraints() {
        container.snp.remakeConstraints { (make) -> Void in
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
        wrapper.snp.remakeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        image.snp.remakeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(230)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        infoBg.snp.remakeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview()
        }
        
        title.snp.remakeConstraints { (make) -> Void in
            make.centerY.equalTo(infoBg)
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
