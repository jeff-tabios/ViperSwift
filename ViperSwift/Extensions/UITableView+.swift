//
//  UITableView+.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueCellAtIndexPath<T: UITableViewCell>(indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.identity, for: indexPath) as? T {
            return cell
        } else {
            fatalError("cell with \"\(T.identity)\" identifier is not registered!")
        }
    }
}
