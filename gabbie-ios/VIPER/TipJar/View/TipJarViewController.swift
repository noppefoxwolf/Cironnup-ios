//
//  TipJarViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

final class TipJarViewController: UIViewController, TipJarViewInput, AlwaysModalyPresenting {
  let navigationControllerType: UINavigationController.Type? = nil
  let animatedWhenPresent: Bool = false
  var output: TipJarViewOutput!
  
  @IBOutlet private weak var heartImageView: UIImageView!
  @IBOutlet private weak var contentView: UIView!
  @IBOutlet private weak var closeButton: UIButton!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var purchaseContentView: UIStackView!
  @IBOutlet private var purchaseContentBackgroundTopConstrant: NSLayoutConstraint!
  @IBOutlet private var contentViewBottonConstraint: NSLayoutConstraint!
  @IBOutlet private weak var purchaseButtonStackView: UIStackView!
  private let debugButton: UIButton = .init(type: .custom)
  private let gradientLayer = CAGradientLayer()
  
  private let welcomeImage: UIImage = Asset.Icons.Tip.heart.image
  private let welcomeTitle: String = """
Thanks for using Cironnup.
"""
  private let welcomeDescription: String = """
Cironnup is free and free of ads.
If you like this app and have fun with it, what about leaving a dollar in the tip jar.
"""
  private let thankImage: UIImage = Asset.Icons.Tip.heartFill.image
  private let thankTitle: String = """
Thanks for your support!!
"""
  private let thankDescription: String = """
The evidence of purchase was saved in the keychain.
Please carefully back up the key chain.
And, gave some new feature as return!!
"""
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    modalPresentationStyle = .overCurrentContext
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    modalPresentationStyle = .overCurrentContext
  }
  
  override func loadView() {
    super.loadView()
    view.backgroundColor = .clear
  }
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    contentView.transform = .init(translationX: 0, y: view.bounds.height)
    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: { [weak self] in
      self?.contentView.transform = .identity
    }, completion: nil)
  }
  
  // MARK: TipJarViewInput
  func setupInitialState() {
  }
  
  func close() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.view.backgroundColor = .clear
    }
    
    contentView.transform = .identity
    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: { [weak self] in
      guard let self = self else { return }
      self.contentView.transform = .init(translationX: 0, y: self.view.bounds.height)
    }, completion: { [weak self] (_) in
        self?.dismiss(animated: false, completion: nil)
    })
  }
  
  func disablePurchaseButtons() {
    purchaseButtonStackView
      .arrangedSubviews
      .compactMap({ $0 as? IAPProductButton })
      .forEach { $0.isEnabled = false }
  }
  
  func enablePurchaseButtons() {
    purchaseButtonStackView
      .arrangedSubviews
      .compactMap({ $0 as? IAPProductButton })
      .forEach { $0.isEnabled = true }
  }
  
  func setupUI() {
    symbol: do {
      heartImageView.image = welcomeImage.withRenderingMode(.alwaysTemplate)
      heartImageView.tintColor = ColorName.tipHeartColor.color
    }
    
    labels: do {
      titleLabel.attributedText = welcomeTitle.withFont(.boldSystemFont(ofSize: 17)).withTextColor(.black)
      descriptionLabel.attributedText = welcomeDescription.withFont(.systemFont(ofSize: 17)).withTextColor(.lightGray)
    }
    
    closeButton: do {
      closeButton.setTitle(nil, for: .normal)
      closeButton.setImage(Asset.Icons.Tip.tintedClose.image.withRenderingMode(.alwaysOriginal), for: .normal)
      closeButton.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
    }
    
    contentView: do {
      contentView.layer.cornerRadius = 16.0
      contentView.layer.masksToBounds = true
      gradientLayer.colors = [UIColor.white.cgColor, ColorName.brandColor.color.cgColor]
      contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    #if DEBUG
    debugButton: do {
      debugButton.setTitle("DEBUG", for: .normal)
      debugButton.addTarget(self, action: #selector(tappedDebugButton), for: .touchUpInside)
      debugButton.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(debugButton)
      NSLayoutConstraint.activate([
        debugButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        view.rightAnchor.constraint(equalTo: debugButton.rightAnchor, constant: 20),
      ])
    }
    #endif
    
    purchaseContent(isHidden: true)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    gradientLayer.frame = contentView.bounds
  }
  
  func configure(products: [IAPProductable]) {
    purchaseContent(isHidden: products.count == 0)
    for product in products {
      let button = IAPProductButton(product: product)
      button.didTap = { [weak self] in
        self?.output.didSelect(product: product.productIdentifier)
      }
      purchaseButtonStackView.addArrangedSubview(button)
    }
    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: { [weak self] in
      self?.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  func showPurchasedAlert(identifier: String) {
    heartImageView.image = thankImage.withRenderingMode(.alwaysTemplate)
    titleLabel.attributedText = thankTitle.withFont(.boldSystemFont(ofSize: 17)).withTextColor(.black)
    descriptionLabel.attributedText = thankDescription.withFont(.systemFont(ofSize: 17)).withTextColor(ColorName.tipHeartColor.color)
    purchaseContent(isHidden: true)
    UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: { [weak self] in
      self?.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  private func purchaseContent(isHidden: Bool) {
    purchaseContentView.isHidden = isHidden
    contentViewBottonConstraint.isActive = !isHidden
    purchaseContentBackgroundTopConstrant.isActive = !isHidden
  }
  
  @objc private func tappedCloseButton(_ sender: UIButton) {
    output.tappedCloseButton()
  }
  
  @objc private func tappedDebugButton(_ sender: UIButton) {
    try! PurchaseLog.shared.reset()
  }
  
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(.init(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}


