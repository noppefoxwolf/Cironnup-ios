//
//  IAPProductButton.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/30.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

final class IAPProductButton: UIView {
  private let separatorView: UIView = .init(frame: .zero)
  private let imageView: UIImageView = .init(frame: .zero)
  private let label: UILabel = .init(frame: .zero)
  private let button: UIButton = .init(frame: .zero)
  var isEnabled: Bool = true { didSet { didChangedIsEnabled() } }
  var didTap: (() -> Void)? = nil
  
  init(product: IAPProductable) {
    super.init(frame: .zero)
    configure(image: product.identifier?.image)
    configure(price: product.localizedPrice)
    configure(title: product.localizedTitle)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func didChangedIsEnabled() {
    button.isEnabled = isEnabled
  }
  
  private func setup() {
    NSLayoutConstraint.activate([
      heightAnchor.constraint(equalToConstant: 44)
    ])
    separatorView: do {
      separatorView.translatesAutoresizingMaskIntoConstraints = false
      separatorView.backgroundColor = .white
      addSubview(separatorView)
      NSLayoutConstraint.activate([
        separatorView.topAnchor.constraint(equalTo: topAnchor),
        separatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
        rightAnchor.constraint(equalTo: separatorView.rightAnchor, constant: 20),
        separatorView.heightAnchor.constraint(equalToConstant: 1)
      ])
    }
    imageView: do {
      imageView.tintColor = .white
      imageView.translatesAutoresizingMaskIntoConstraints = false
      addSubview(imageView)
      NSLayoutConstraint.activate([
        imageView.heightAnchor.constraint(equalToConstant: 24),
        imageView.widthAnchor.constraint(equalToConstant: 24),
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      ])
    }
    label: do {
      label.textAlignment = .left
      label.translatesAutoresizingMaskIntoConstraints = false
      addSubview(label)
      
      NSLayoutConstraint.activate([
        label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
        label.centerYAnchor.constraint(equalTo: centerYAnchor),
      ])
    }
    button: do {
      button.translatesAutoresizingMaskIntoConstraints = false
      button.layer.borderColor = UIColor.white.cgColor
      button.layer.borderWidth = 1.0
      button.layer.cornerRadius = 6.0
      button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
      addSubview(button)
      NSLayoutConstraint.activate([
        button.widthAnchor.constraint(equalToConstant: 120),
        rightAnchor.constraint(equalTo: button.rightAnchor, constant: 20),
        button.centerYAnchor.constraint(equalTo: centerYAnchor),
        button.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 20)
      ])
    }
  }
  
  @objc private func tappedButton(_ sender: UIButton) {
    didTap?()
  }
  
  private func configure(title: String?) {
    label.attributedText = title?.withFont(.systemFont(ofSize: 14)).withTextColor(.white)
  }
  
  private func configure(price: String?) {
    button.setAttributedTitle(price?.withFont(.systemFont(ofSize: 14)).withTextColor(.white), for: .normal)
  }
  
  private func configure(image: UIImage?) {
    imageView.image = image?.withRenderingMode(.alwaysTemplate)
  }
}
