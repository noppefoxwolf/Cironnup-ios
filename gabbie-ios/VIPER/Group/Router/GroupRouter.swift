//
//  GroupRouter.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//
import CironnupKit
import Router

class GroupRouter: GroupRouterInput {
  func pushTimeline(of groupID: String, account: Account, view: GroupViewInput) {
    guard let vc = view as? UIViewController else { preconditionFailure() }
    let interactor = GroupTimelineInteractor(group: groupID)
    Router.default.navigate(GabNavigation.timeline(account, interactor), from: vc)
  }
}


