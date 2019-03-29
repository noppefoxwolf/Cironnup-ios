//
//  GroupPresenter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import CironnupKit
import GabKit

class GroupPresenter: GroupModuleInput, GroupViewOutput {
  weak var view: GroupViewInput!
  var interactor: GroupInteractorInput!
  var router: GroupRouterInput!
  lazy var account: Account = { preconditionFailure() }()
  
  func viewIsReady() {
    view.setupUI()
    interactor.fetchJoinedGroups(credential: account.clientSource.credential)
  }
  
  func setupAccount(_ account: Account) {
    self.account = account
  }
  
  func didSelectGroup(id: String) {
    router.pushTimeline(of: id, account: account, view: view)
  }
  
  func pullToRefreshed() {
    interactor.fetchJoinedGroups(credential: account.clientSource.credential)
  }
}

extension GroupPresenter: GroupInteractorOutput {
  func didReceived(_ groups: [Group]) {
    view.reload(groups: groups)
  }
  
  func didReceived(_ error: Error) {
    
  }
}
