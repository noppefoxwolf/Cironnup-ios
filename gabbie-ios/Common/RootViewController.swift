//
//  RootViewController.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/13.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
  private var viewController: UIViewController? = nil
  
  func configure(_ viewController: UIViewController) {
    if let oldContent = self.viewController {
      dismiss(oldContent)
    }
    present(viewController)
  }
  
  private func present(_ content: UIViewController) {
    addChild(content)
    view.addSubview(content.view)
    content.didMove(toParent: self)
  }
  
  private func dismiss(_ content: UIViewController) {
    content.willMove(toParent: nil)
    content.view.removeFromSuperview()
    content.removeFromParent()
  }
  
  private func flip(from: UIViewController,
                    to: UIViewController,
                    duration: TimeInterval,
                    options: UIView.AnimationOptions,
                    animations: (() -> Void)?,
                    completion: ((Bool) -> Void)?) {
    from.willMove(toParent: nil)
    addChild(to)
    transition(from: from,
               to: to,
               duration: duration,
               options: options,
               animations: animations) { [weak self] (finished) in
                guard let self = self else { return }
                from.removeFromParent()
                to.didMove(toParent: self)
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
