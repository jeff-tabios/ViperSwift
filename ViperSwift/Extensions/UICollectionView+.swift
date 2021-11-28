//
//  UICollectionView+.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func dequeueCellAtIndexPath<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: T.identity, for: indexPath) as? T {
            return cell
        } else {
            fatalError("cell with \"\(T.identity)\" identifier is not registered!")
        }
    }
}
