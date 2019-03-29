//
//  Account.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation
import GabKit

public class Account: Codable {
  public let id: Int
  public let name: String
  public let username: String
  public let pictureUrl: String
  public let clientSource: ClientSource
  
  public init(user: UserType, clientSource: ClientSource) {
    id = user.id
    name = user.name
    username = user.username
    pictureUrl = user.pictureUrl
    self.clientSource = clientSource
  }
}
