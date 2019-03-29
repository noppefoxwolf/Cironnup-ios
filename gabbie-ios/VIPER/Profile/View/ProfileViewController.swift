//
//  ProfileViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 23/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import GabKit
import PINRemoteImage

class ProfileViewController: UIViewController, ProfileViewInput {
  
  var output: ProfileViewOutput!
  
  @IBOutlet private weak var scrollView: UIScrollView!
  @IBOutlet private weak var coverImageView: UIImageView!
  @IBOutlet private weak var profileImageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var usernameLabel: UILabel!
  @IBOutlet private weak var contentView: UIView!
  
  @IBOutlet private weak var scoreLabel: UILabel!
  @IBOutlet private weak var postCountLabel: UILabel!
  @IBOutlet private weak var followersCountLabel: UILabel!
  @IBOutlet private weak var followsCountLabel: UILabel!
  @IBOutlet private weak var bioView: UIView!
  @IBOutlet private weak var bioLabel: UILabel!
  @IBOutlet private weak var createdAtLabel: UILabel!
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
    setup()
  }
  
  // MARK: ProfileViewInput
  func setupInitialState(_ target: ProfileTarget, credential: Credential) {
    output.setup(target: target, credential: credential)
  }
}

extension ProfileViewController {
  private func setup() {
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.barTintColor = .clear
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    
    view.backgroundColor = ColorName.backgroundColor.color
    contentView.backgroundColor = ColorName.contentBackgroundColor.color
    profileImageView.layer.cornerRadius = 60.0
    profileImageView.layer.masksToBounds = true
    profileImageView.layer.borderColor = ColorName.contentBackgroundColor.color.cgColor
    profileImageView.layer.borderWidth = 4.0
    
    bioView.backgroundColor = ColorName.navigationTintColor.color
    bioView.layer.cornerRadius = 16.0
    bioView.layer.masksToBounds = true
    
    scrollView.isHidden = true
  }
  
  func configure(scrollViewIsHidden isHidden: Bool) {
    scrollView.isHidden = isHidden
  }
  
  func configure(coverImage url: URL?) {
    coverImageView.pin_setImage(from: url)
  }
  
  func configure(profileImage url: URL?) {
    profileImageView.pin_setImage(from: url)
  }
  
  func configure(name: String) {
    nameLabel.attributedText = name.withFont(.boldSystemFont(ofSize: 18)).withTextColor(.white)
  }
  
  func configure(username: String) {
    usernameLabel.attributedText = "@\(username)".withFont(.systemFont(ofSize: 18)).withTextColor(.white)
  }
  
  func configure(score: Int) {
    scoreLabel.attributedText = "\(score)".withFont(.boldSystemFont(ofSize: 18)).withTextColor(.white)
  }
  
  func configure(following count: Int) {
    followsCountLabel.attributedText = "\(count)".withFont(.boldSystemFont(ofSize: 18)).withTextColor(.white)
  }
  
  func configure(follows count: Int) {
    followersCountLabel.attributedText = "\(count)".withFont(.boldSystemFont(ofSize: 18)).withTextColor(.white)
  }
  
  func configure(post count: Int) {
    postCountLabel.attributedText = "\(count)".withFont(.boldSystemFont(ofSize: 18)).withTextColor(.white)
  }
  
  func configure(bio: String) {
    bioLabel.attributedText = bio.withFont(.boldSystemFont(ofSize: 14)).withTextColor(.white)
  }
  
  func configure(createdAtMonth: String) {
    createdAtLabel.attributedText = createdAtMonth.withFont(.boldSystemFont(ofSize: 12)).withTextColor(.lightGray)
  }
}

