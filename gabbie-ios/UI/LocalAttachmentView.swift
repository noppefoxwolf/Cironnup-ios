//
//  LocalAttachmentView.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/15.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

@available(*, deprecated: 1.0)
final class LocalAttachmentView: UIImageView {
  private let overlayView: UIView = .init()
  private let closeButton = UIButton(type: .custom)
  private let indicator: UIActivityIndicatorView = .init()
  private let statusLabel: UILabel = .init()
  var didTappedCloseButton: (() -> Void)? = nil
  
  func configure(statusText: String?) {
    if let statusText = statusText {
      indicator.startAnimating()
      overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
      let style = NSMutableParagraphStyle()
      style.alignment = .center
      statusLabel.attributedText = statusText.withFont(.boldSystemFont(ofSize: 14)).withTextColor(.white).withParagraphStyle(style)
      closeButton.isHidden = true
    } else {
      indicator.stopAnimating()
      overlayView.backgroundColor = .clear
      statusLabel.attributedText = nil
      closeButton.isHidden = false
    }
  }
  
  init(attachment: LocalAttachment) {
    super.init(frame: .init(x: 0, y: 0, width: 320, height: 320))
    contentMode = .scaleAspectFill
    image = attachment.image
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    isUserInteractionEnabled = true
    
    label: do {
      addSubview(overlayView)
      overlayView.snp.makeConstraints {
        $0.top.left.right.bottom.equalTo(0)
      }
    }
    
    statusLabel: do {
      addSubview(statusLabel)
      statusLabel.snp.makeConstraints {
        $0.center.equalTo(overlayView.snp.center)
      }
    }
    
    indicator: do {
      indicator.style = .white
      indicator.hidesWhenStopped = true
      addSubview(indicator)
      indicator.snp.makeConstraints {
        $0.centerY.equalTo(statusLabel.snp.centerY)
        $0.right.equalTo(statusLabel.snp.left).offset(-8)
      }
    }
    
    closeButton: do {
      //closeButton.setImage(Asset.Icons.removeAttachment.image, for: .normal)
      closeButton.addTarget(self, action: #selector(tappedRemoveButton), for: .touchUpInside)
      addSubview(closeButton)
      closeButton.snp.makeConstraints {
        $0.top.equalTo(snp.top).offset(10)
        $0.right.equalTo(snp.right).offset(-10)
        $0.width.height.equalTo(26)
      }
    }
  }
  
  @objc private func tappedRemoveButton(_ button: UIButton) {
    didTappedCloseButton?()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 12.0
    layer.masksToBounds = true
  }
}
