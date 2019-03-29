//
//  UIView+Extensions.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/11/13.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

protocol Bluring {
  func addBlur()
  func removeBlur()
}

extension Bluring where Self: UIView {
  func addBlur() {
    removeBlur()
    let effect = UIBlurEffect(style: .light)
    let effectView = UIVisualEffectView(effect: effect)
    effectView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(effectView)
    NSLayoutConstraint.activate([
      effectView.topAnchor.constraint(equalTo: topAnchor),
      effectView.bottomAnchor.constraint(equalTo: bottomAnchor),
      effectView.leftAnchor.constraint(equalTo: leftAnchor),
      effectView.rightAnchor.constraint(equalTo: rightAnchor),
      ])
  }
  
  func removeBlur() {
    subviews.compactMap({ $0 as? UIVisualEffectView }).forEach({ $0.removeFromSuperview() })
  }
}

extension UIImageView: Bluring {}
