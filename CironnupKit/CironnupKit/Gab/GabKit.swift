//
//  GabKit.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/13.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit

extension Gab {
  public static var `default`: Gab {
    return Gab(clientID: Environment.current.clientID,
               clientSecret: Environment.current.clientSecret,
               scopes: [.read, .writePost, .engagePost, .engageUser, .notifications])
  }
  
  public static func `default`(with credential: Credential) -> Gab {
    return Gab(clientID: Environment.current.clientID,
               clientSecret: Environment.current.clientSecret,
               credential: credential,
               scopes: [.read, .writePost, .engagePost, .engageUser, .notifications])
  }
}
