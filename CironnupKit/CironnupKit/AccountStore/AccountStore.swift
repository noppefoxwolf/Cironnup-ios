//
//  AccountStore.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/14.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation
import Cache

public class AccountStore {
  private let storage: Storage<Account>
  private let userDefaults: UserDefaults
  private static let accountIdsKey: String = "com.noppelab.gabbie.accounts.key"
  
  public init?() {
    guard let storage = StorageFactory.accountsStorage else { return nil }
    self.storage = storage
    self.userDefaults = UserDefaults.appGroups
  }
  
  public var isAccountExists: Bool {
    return !(userDefaults.stringArray(forKey: AccountStore.accountIdsKey) ?? []).isEmpty
  }
  
  public var accounts: [Account] {
    let ids = userDefaults.stringArray(forKey: AccountStore.accountIdsKey) ?? []
    return ids.compactMap({ try? storage.object(forKey: $0) })
  }
  
  public func save(_ account: Account) {
    do {
      try storage.setObject(account, forKey: "\(account.id)")
      saveKeys(id: account.id)
    } catch {
      debugPrint(error)
    }
  }
  
  public func account(with id: Int) -> Account? {
    return try? storage.object(forKey: "\(id)")
  }
  
  public func remove(with id: Int) {
    try? storage.removeObject(forKey: "\(id)")
    removeKey(id: id)
  }
  
  public func removeAll() {
    try? storage.removeAll()
    userDefaults.removeObject(forKey: AccountStore.accountIdsKey)
  }
  
  public func renewCredential(for account: Account) {
    #warning("not impl")
  }
  
  private func saveKeys(id: Int) {
    let ids = userDefaults.stringArray(forKey: AccountStore.accountIdsKey) ?? []
    var idsSet = Set(ids)
    idsSet.insert("\(id)")
    userDefaults.set(Array(idsSet), forKey: AccountStore.accountIdsKey)
    userDefaults.synchronize()
  }
  
  private func removeKey(id: Int) {
    userDefaults.removeObject(forKey: "\(id)")
  }
}
