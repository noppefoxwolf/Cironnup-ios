//
//  Mock.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/13.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation
import GabKit
import Fakery

extension Decodable {
  fileprivate static func make(params: [String : Any]) -> Self {
    do {
      let json = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
      return try JSONDecoder().decode(Self.self, from: json)
    } catch {
      preconditionFailure(String(describing: error))
    }
  }
}

extension Faker {
  static var `default`: Faker {
    return Faker(locale: "en")
  }
}

extension Internet {
  func placeimg(width: Int = 120, height: Int = 120, q: String = "face") -> String {
    return "https://placeimg.com/\(width)/\(height)/\(q)"
  }
}

extension Credential {
  static func mock() -> Credential {
    let params: [String : Any] = [
      "tokenType":"",
      "expiresIn":0,
      "accessToken":"",
      "refreshToken":""
    ]
    return make(params: params)
  }
}

extension Post {
  static func mock(faker: Faker = .default) -> Post {
    let params: [String : Any] = [
      "id" : faker.number.randomInt(),
      "createdAt" : faker.number.randomInt(),
      "revisedAt" : faker.number.randomInt(),
      "edited" : false,
      "body" : faker.lorem.sentences(),
      "bodyHtml" : "",
      "bodyHtmlSummary" : "",
      "bodyHtmlSummaryTruncated" : false,
      "liked" : false,
      "disliked" : false,
      "bookmarked" : false,
      "repost" : false,
      "reported" : false,
      "score": 0,
      "likeCount": 0,
      "dislikeCount": 0,
      "replyCount": 0,
      "repostCount": 0,
      "isQuote" : false,
      "isReply" : false,
      "attachment": ["type" : nil],
      "language" : "",
      "nsfw" : false,
      "isPremium" : false,
      "isLocked" : false,
      "premiumMinTier": 0,
      "currentTier": 0,
      "user" : [
        "id": 0,
        "name": faker.name.name(),
        "username": faker.lorem.word(),
        "pictureUrl": faker.internet.placeimg(),
        "verified": false,
        "isDonor": false,
        "isInvestor": false,
        "isPro": false,
        "isPrivate": false,
        "isPremium": false,
      ]
    ]
    return make(params: params)
  }
}
