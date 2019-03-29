//
//  Cache.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Cache
import GabKit
import Foundation

extension DiskConfig {
  static let appgroupDirectory: URL = FileManager.default.appGroupURL
  
  static var accountsConfig: DiskConfig {
    let diskConfig = DiskConfig(name: "Accounts",
                                maxSize: 10000,
                                directory: appgroupDirectory,
                                protectionType: .complete)
    return diskConfig
  }
  
  static var timelineConfig: DiskConfig {
    let diskConfig = DiskConfig(name: "Timeline",
                                expiry: .date(Date().addingTimeInterval(2*24*3600)),
                                maxSize: 10000,
                                directory: appgroupDirectory,
                                protectionType: .complete)
    return diskConfig
  }
}

struct StorageFactory {
  static var accountsStorage: Storage<Account>? {
    let diskConfig = DiskConfig.accountsConfig
    let memoryConfig = MemoryConfig(expiry: .never, countLimit: 0, totalCostLimit: 0)
    return try? Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType: Account.self))
  }
  
  static var timelineStorage: Storage<FeedResponse>? {
    let diskConfig = DiskConfig.timelineConfig
    let memoryConfig = MemoryConfig(expiry: .never, countLimit: 0, totalCostLimit: 0)
    return try? Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType: FeedResponse.self))
  }
}
