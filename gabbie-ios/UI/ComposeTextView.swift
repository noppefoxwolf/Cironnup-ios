//
//  ComposeTextView.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/26.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit
import CironnupUI
import TextContainerLayoutGuide

public final class ComposeContentView: UIView {
  private let textView: UITextView = .init(frame: .zero)
  private let placeholderLabel: UILabel = .init(frame: .zero)
  public var placeholder: NSAttributedString? = nil {
    didSet { updatePlaceholder() }
  }
  private let replyBodyView: UILabel = .init(frame: .zero)
  public var replyToBody: NSAttributedString? = nil {
    didSet { updateReplyToBody() }
  }
  private let quoteBodyView: UILabel = .init(frame: .zero)
  public var quoteBody: NSAttributedString? = nil {
    didSet { updateQuoteBody() }
  }
  
  private let collectionView: AttachmentCollectionView = .init(frame: .zero, collectionViewLayout: .init())
  public var attachmentCollectionControlEventDelegate: AttachmentCollectionControlEventDelegate? {
    get { return collectionView.controlEventDelegate }
    set { collectionView.controlEventDelegate = newValue }
  }
  
  private let accountButton: UIButton = .init(frame: .zero)
  
  public var text: String {
    get { return textView.text }
    set {
      textView.text = newValue
      textViewDidChanged()
      didChangedText?()
    }
  }
  var didChangedText: (() -> Void)? = nil
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @discardableResult
  public override func becomeFirstResponder() -> Bool {
    super.becomeFirstResponder()
    return textView.becomeFirstResponder()
  }
  
  @discardableResult
  public override func resignFirstResponder() -> Bool {
    super.resignFirstResponder()
    return textView.resignFirstResponder()
  }
  
  private func setup() {
    textView: do {
      textView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(textView)
      textView.keyboardAppearance = .dark
      textView.delegate = self
      textView.text = ""
      textView.font = UIFont.systemFont(ofSize: 17)
      textView.textColor = .white
      textView.backgroundColor = ColorName.textViewBackgroundColor.color
      textView.alwaysBounceVertical = true
      textView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        textView.topAnchor.constraint(equalTo: topAnchor),
        textView.leftAnchor.constraint(equalTo: leftAnchor),
        textView.bottomAnchor.constraint(equalTo: bottomAnchor),
        textView.rightAnchor.constraint(equalTo: rightAnchor)
      ])
      textView.textContainer.lineFragmentPadding = 0
      NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChanged),
                                             name: UITextView.textDidChangeNotification,
                                             object: textView)
    }
    
    placehodler: do {
      placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
      addSubview(placeholderLabel)
      NSLayoutConstraint.activate([
        placeholderLabel.topAnchor.constraint(equalTo: textView.textContainerLayoutGuide.topAnchor),
        placeholderLabel.leftAnchor.constraint(equalTo: textView.textContainerLayoutGuide.leftAnchor)
      ])
    }
    
    collectionView: do {
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(collectionView)
      collectionView.backgroundColor = .clear
      NSLayoutConstraint.activate([
        collectionView.leftAnchor.constraint(equalTo: textView.textContainerLayoutGuide.leftAnchor),
        collectionView.rightAnchor.constraint(equalTo: textView.textContainerLayoutGuide.rightAnchor),
        collectionView.topAnchor.constraint(equalTo: textView.textContainerLayoutGuide.bottomAnchor, constant: 8.0),
        collectionView.heightAnchor.constraint(equalToConstant: 0)
      ])
    }
    
    accountButton: do {
      accountButton.translatesAutoresizingMaskIntoConstraints = false
      accountButton.backgroundColor = .lightGray
      accountButton.layer.cornerRadius = 18
      accountButton.layer.masksToBounds = true
      addSubview(accountButton)
      NSLayoutConstraint.activate([
        accountButton.topAnchor.constraint(equalTo: textView.textContainerLayoutGuide.topAnchor),
        textView.textContainerLayoutGuide.leftAnchor.constraint(equalTo: accountButton.rightAnchor, constant: 8),
        accountButton.widthAnchor.constraint(equalToConstant: 36),
        accountButton.heightAnchor.constraint(equalToConstant: 36)
      ])
    }
    
    replyBodyView: do {
      replyBodyView.numberOfLines = 0
      replyBodyView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(replyBodyView)
      NSLayoutConstraint.activate([
        replyBodyView.leftAnchor.constraint(equalTo: leftAnchor),
        replyBodyView.rightAnchor.constraint(equalTo: rightAnchor),
        textView.textContainerLayoutGuide.topAnchor.constraint(equalTo: replyBodyView.bottomAnchor, constant: 12)
      ])
    }
    
    quoteBodyView: do {
      quoteBodyView.numberOfLines = 0
      quoteBodyView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(quoteBodyView)
      NSLayoutConstraint.activate([
        quoteBodyView.leftAnchor.constraint(equalTo: textView.textContainerLayoutGuide.leftAnchor, constant: 8.0),
        quoteBodyView.rightAnchor.constraint(equalTo: rightAnchor),
        quoteBodyView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
      ])
    }
  }
  
  public override func layoutIfNeeded() {
    super.layoutIfNeeded()
    textView.textContainerInset = .init(top: 12, left: 16 + 36 + 8, bottom: 12, right: 16)
  }
  
  @objc private func textViewDidChanged() {
    placeholderLabel.isHidden = textView.text.count > 0
  }
  
  private func updatePlaceholder() {
    placeholderLabel.attributedText = placeholder
    layoutIfNeeded()
  }
  
  private func updateReplyToBody() {
    replyBodyView.attributedText = replyToBody
    layoutIfNeeded()
  }
  
  private func updateQuoteBody() {
    quoteBodyView.attributedText = quoteBody
    layoutIfNeeded()
  }
  
  func configure(accountPicture url: URL?) {
    accountButton.pin_setImage(from: url)
  }
  
  func reload(using items: [AttachmentDisplayItem]) {
    collectionView.reload(using: items)
  }
}

extension ComposeContentView: UITextViewDelegate {
  public func textViewDidChange(_ textView: UITextView) {
    didChangedText?()
  }
}
