//
//  AttachmentCollectionViewCell.swift
//  CironnupUI
//
//  Created by Tomoya Hirano on 2018/10/27.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

final class AttachmentCollectionViewCell: UICollectionViewCell {
  private let imageView: UIImageView = .init(frame: .zero)
  private let closeButton: UIButton = .init(type: .custom)
  private let coverView: UIView = .init(frame: .zero)
  private let statusStackView: UIStackView = .init(frame: .zero)
  private let statusLabel: UILabel = .init(frame: .zero)
  private let indicatorView: UIActivityIndicatorView = .init(style: .white)
  var didTap: (() -> Void)? = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView: do {
      contentView.layer.cornerRadius = 16.0
      contentView.layer.masksToBounds = true
    }
    
    imageView: do {
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFill
      contentView.addSubview(imageView)
    }
    
    closeButton: do {
      closeButton.translatesAutoresizingMaskIntoConstraints = false
      closeButton.setImage(Asset.removeAttachment.image, for: .normal)
      closeButton.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
      contentView.addSubview(closeButton)
    }
    
    coverView: do {
      coverView.translatesAutoresizingMaskIntoConstraints = false
      coverView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
      contentView.addSubview(coverView)
    }
    
    statusStackView: do {
      statusStackView.translatesAutoresizingMaskIntoConstraints = false
      statusStackView.axis = .horizontal
      statusStackView.spacing = 8.0
      coverView.addSubview(statusStackView)
    }
    
    indicatorView: do {
      indicatorView.hidesWhenStopped = true
      indicatorView.translatesAutoresizingMaskIntoConstraints = false
      statusStackView.addArrangedSubview(indicatorView)
    }
    
    statusLabel: do {
      statusLabel.translatesAutoresizingMaskIntoConstraints = false
      statusStackView.addArrangedSubview(statusLabel)
    }
    
    layout: do {
      NSLayoutConstraint.activate([
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
      ])
      NSLayoutConstraint.activate([
        closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        contentView.rightAnchor.constraint(equalTo: closeButton.rightAnchor, constant: 8)
      ])
      NSLayoutConstraint.activate([
        coverView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        coverView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        coverView.topAnchor.constraint(equalTo: contentView.topAnchor),
        coverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
      ])
      NSLayoutConstraint.activate([
        statusStackView.centerXAnchor.constraint(equalTo: coverView.centerXAnchor),
        statusStackView.centerYAnchor.constraint(equalTo: coverView.centerYAnchor)
      ])
    }
  }
  
  internal func configure(image: UIImage) {
    imageView.image = image
  }
  
  internal func configure(attributedString: NSAttributedString?) {
    coverView.isHidden = attributedString == nil
    closeButton.isHidden = attributedString != nil
    statusLabel.attributedText = attributedString
    if attributedString != nil {
      indicatorView.startAnimating()
    } else {
      indicatorView.stopAnimating()
    }
  }
  
  @objc private func tappedCloseButton(_ sender: UIButton) {
    didTap?()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
