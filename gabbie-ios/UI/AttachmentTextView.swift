//
//  AttachmentTextView.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/15.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

@available(*, deprecated: 1.0)
final class AttachmentTextView: UITextView {
  var inset: UIEdgeInsets = .zero {
    didSet {
      updateInset()
    }
  }
  var attachmentSpacing: CGFloat = 16.0 {
    didSet {
      updateInset()
    }
  }
  var attachmentView: UIView? = nil {
    didSet {
      if let oldView = oldValue, attachmentView == nil {
        removeWithAnimation(oldView)
      } else {
        oldValue?.removeFromSuperview()
      }
      
      if let attachmentView = attachmentView {
        addSubview(attachmentView)
        attachmentView.snp.makeConstraints {
          $0.left.top.equalTo(0)
          $0.width.equalTo(attachmentView.bounds.width)
          $0.height.equalTo(attachmentView.bounds.height)
        }
        updateAttachmentLayout()
        if oldValue == nil {
          showAnimation(attachmentView)
        }
      }
      updateInset()
    }
  }
  
  private func removeWithAnimation(_ view: UIView) {
    view.alpha = 1
    view.transform = .identity
    UIView.animate(withDuration: 0.2, animations: {
      view.alpha = 0
      view.transform = .init(scaleX: 1.05, y: 1.05)
    }) { (_) in
      view.removeFromSuperview()
    }
  }
  
  private func showAnimation(_ view: UIView) {
    view.alpha = 0
    view.transform = .init(scaleX: 1.05, y: 1.05)
    UIView.animate(withDuration: 0.2) {
      view.alpha = 1
      view.transform = .identity
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    textContainer.lineFragmentPadding = 0
    alwaysBounceVertical = true
  }
  
  private func updateInset() {
    if let attachmentView = attachmentView {
      textContainerInset = .init(top: inset.top,
                                 left: inset.left,
                                 bottom: attachmentSpacing + attachmentView.bounds.height + inset.bottom,
                                 right: inset.right)
    } else {
      textContainerInset = inset
    }
  }
  
  func updateAttachmentLayout() {
    if let attachmentView = attachmentView {
      let size = CGSize(width: bounds.width - textContainerInset.left - textContainerInset.right, height: .greatestFiniteMagnitude)
      let textSize = attributedText.boundingRect(with: size,
                                                 options: .usesLineFragmentOrigin,
                                                 context: nil).size
      
      attachmentView.snp.updateConstraints {
        $0.top.equalTo(inset.top + textSize.height + attachmentSpacing)
        $0.left.equalTo(bounds.width - attachmentView.bounds.width - inset.right)
      }
    }
  }
}
