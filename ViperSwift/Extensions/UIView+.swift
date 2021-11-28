//
//  UIView+.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/28/21.
//

import Foundation
import UIKit

// MARK: Identifiable
extension UIView: Identifiable {
    static var identity: String {
        return String(describing: self)
    }
}
