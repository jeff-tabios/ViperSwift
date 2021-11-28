//
//  Menu.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit
import SnapKit

class Menu: UIView {
    
    var pizzas: [Pizza]?
    
    lazy var pizzaMenu: UITableView = {
        let tableView = UITableView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.register(MenuCell.self, forCellReuseIdentifier: MenuCell.identity)

        return tableView
    }()
    
    // MARK: Lifecycle
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .blue
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(pizzaMenu)
        needsUpdateConstraints()
    }
    
    override func updateConstraints() {
        pizzaMenu.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    func reload(pizzas: [Pizza]?) {
        self.pizzas = pizzas
        DispatchQueue.main.async { [weak self] in
            self?.pizzaMenu.reloadData()
        }
    }
}

extension Menu: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pizzas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
        
        if let pizza = pizzas?[indexPath.row],
           let id = pizzas?[indexPath.row].id,
           let image = pizzas?[indexPath.row].image,
           let title = pizzas?[indexPath.row].name,
           let price = pizzas?[indexPath.row].price {
            cell.image.image = UIImage(named: image)
            cell.title.text = title
            cell.title.sizeToFit()
            cell.price.text = "\(price)"
            cell.price.sizeToFit()
            cell.addButton.tag = id
            cell.pizza = pizza
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
}
