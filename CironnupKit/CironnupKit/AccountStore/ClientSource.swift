//
//  ClientSource.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation
import GabKit

public struct ClientSource: Codable {
  public let id: String
  public let secret: String
  public let credential: Credential
  public let scopes: [Scope]
  
  public init(id: String, secret: String, credential: Credential, scopes: [Scope]) {
    self.id = id
    self.secret = secret
    self.credential = credential
    self.scopes = scopes
  }
}
