//
//  PurchaseLog.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/30.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import KeychainAccess

class PurchaseLog {
  static let shared = PurchaseLog()
  private let key: String = "com.noppelab.cironnup.purchased"
  
  func log(product identifier: String) throws {
    var records = try fetchRecords()
    records.append(PurchaseRecord(productID: identifier))
    try saveRecords(records)
  }
  
  var isPurchased: Bool {
    do {
      return try _isPurchased()
    } catch {
      return false
    }
  }
  
  private func _isPurchased() throws -> Bool {
    let records = try fetchRecords()
    return records.count > 0
  }
  
  func reset() throws {
    try Keychain().synchronizable(true).remove(key)
  }
  
  private func fetchRecords() throws -> [PurchaseRecord] {
    guard let data = try Keychain().synchronizable(true).getData(key) else { return [] }
    let decoder = JSONDecoder()
    return try decoder.decode([PurchaseRecord].self, from: data)
  }
  
  private func saveRecords(_ records: [PurchaseRecord]) throws {
    let encoder = JSONEncoder()
    let data = try encoder.encode(records)
    try Keychain().synchronizable(true).set(data, key: key)
  }
}

private struct PurchaseRecord: Codable {
  let productID: String
  let date: Date = Date()
}
