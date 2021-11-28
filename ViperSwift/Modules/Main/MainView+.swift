//
//  MainView+.swift
//  ViperSwift
//
//  Created by Jeffrey Tabios on 11/29/21.
//

import Foundation
import UIKit

extension MainView {

    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanAction(_:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        containerView.addGestureRecognizer(panGesture)
    }

    @objc func handlePanAction(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y

        // Handle based on gesture state
        switch gesture.state {
        case .changed:
           if newHeight < maximumContainerHeight {
                containerView.snp.updateConstraints { make in
                    make.height.equalTo(newHeight)
                }
               view.layoutIfNeeded()
           }
        case .ended:
           if newHeight < defaultHeight {
               animateContainerHeight(defaultHeight)
           }
           else if newHeight < maximumContainerHeight && isDraggingDown {
               animateContainerHeight(defaultHeight)
           }
           else if newHeight > defaultHeight && !isDraggingDown {
               animateContainerHeight(maximumContainerHeight)
           }
        default:
           break
        }
    }

    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerView.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }

}
