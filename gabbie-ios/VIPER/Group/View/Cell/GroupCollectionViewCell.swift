//
//  GroupCollectionViewCell.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/11/12.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit
import Reusable
import PINRemoteImage

class GroupCollectionViewCell: UICollectionViewCell, NibReusable {
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 16.0
    imageView.layer.masksToBounds = true
  }
  
  func configure(coverImage url: String) {
    imageView.pin_setImage(from: URL(string: url))
  }
  
  func configure(isNSFW: Bool) {
    if isNSFW {
      imageView.addBlur()
    } else {
      imageView.removeBlur()
    }
  }
  
  func configure(title: String) {
    titleLabel.attributedText = title.withFont(.boldSystemFont(ofSize: 14)).withTextColor(.white)
  }
}
