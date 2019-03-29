//
//  GroupRouterInput.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 12/11/2018.
//  Copyright © 2018 . All rights reserved.
//

import Foundation
import CironnupKit

protocol GroupRouterInput {
  func pushTimeline(of groupID: String, account: Account, view: GroupViewInput)
}
