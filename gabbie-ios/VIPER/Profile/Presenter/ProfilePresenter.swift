//
//  ProfilePresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 23/10/2018.
//  Copyright © 2018 . All rights reserved.
//
import GabKit

class ProfilePresenter: ProfileModuleInput, ProfileViewOutput, ProfileInteractorOutput {
  weak var view: ProfileViewInput!
  var interactor: ProfileInteractorInput!
  var router: ProfileRouterInput!
  private lazy var target: ProfileTarget = { preconditionFailure() }()
  private lazy var credential: Credential = { preconditionFailure() }()
  
  func viewIsReady() {
    switch target {
    case .me:
      interactor.fetchMe(credential: credential)
    case .user(let username):
      interactor.fetchUser(username: username, credential: credential)
    }
  }
  
  func setup(target: ProfileTarget, credential: Credential) {
    self.target = target
    self.credential = credential
  }
  
  func didReceivedUser(_ user: UserDetail) {
    DispatchQueue.main.async { [weak self] in
      self?.applyUserDetail(user)
      self?.view.configure(scrollViewIsHidden: false)
    }
  }
  
  func didReceivedError(_ error: Error) {
    InAppNotification.error(error)
  }
  
  private func applyUserDetail(_ user: UserDetail) {
    view.configure(name: user.name)
    view.configure(post: user.postCount)
    view.configure(score: user.score)
    view.configure(follows: user.followerCount)
    view.configure(following: user.followingCount)
    view.configure(username: user.username)
    view.configure(coverImage: URL(string: user.coverUrl))
    view.configure(profileImage: URL(string: user.pictureUrl))
    view.configure(createdAtMonth: user.createdAtMonthLabel)
    view.configure(bio: user.bio)
  }
}

