//
//  ProfileViewInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 23/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import GabKit

protocol ProfileViewInput: class {
  
  /**
   @author noppefoxwolf
   Setup initial state of the view
   */
  
  func setupInitialState(_ target: ProfileTarget, credential: Credential)
  func configure(scrollViewIsHidden isHidden: Bool)
  func configure(coverImage url: URL?)
  func configure(profileImage url: URL?)
  func configure(name: String)
  func configure(username: String)
  func configure(score: Int)
  func configure(following count: Int)
  func configure(follows count: Int)
  func configure(post count: Int)
  func configure(bio: String)
  func configure(createdAtMonth: String)
}

