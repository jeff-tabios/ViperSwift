//
//  CartView.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/29/21.
//

import Foundation
import UIKit
import RxSwift

final class CartView: UIViewController {
    let disposeBag = DisposeBag()
    
    var presenter: CartPresenter?
    
    var items: [Pizza]?
    
    lazy var itemList: UITableView = {
        let tableView = UITableView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        tableView.alwaysBounceVertical = false
        tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.identity)

        return tableView
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menuIcon"), for: .normal)
        button.layer.cornerRadius = 24
        button.setTitleColor(.white, for: .normal)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        self.title = "Cart"
        
    }
    
    func bind() {
        menuButton.rx.tap.asDriver()
            .drive(presenter!.menuButtonTappedTrigger)
            .disposed(by: disposeBag)
        
        presenter?.items
            .subscribe(onNext: { [weak self] items in
                self?.items = items
                DispatchQueue.main.async { [weak self] in
                    self?.itemList.reloadData()
                }
            }).disposed(by: disposeBag)
        
        presenter?.viewLoadedTrigger.onNext(())
    }
    
    func addSubviews() {
        view.addSubview(itemList)
        view.addSubview(menuButton)
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        
        itemList.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        menuButton.snp.remakeConstraints { make in
            make.width.height.equalTo(48)
            make.trailing.bottom.equalToSuperview().offset(-30)
        }
        
        super.updateViewConstraints()
    }
}

extension CartView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartItemCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
        
        if let image = items?[indexPath.row].image,
           let title = items?[indexPath.row].name,
           let price = items?[indexPath.row].price {
            cell.image.image = UIImage(named: image)
            cell.title.text = title
            cell.title.sizeToFit()
            cell.price.text = "\(price)"
            cell.price.sizeToFit()
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

