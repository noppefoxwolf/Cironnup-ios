//
//  FileManager+Extensions.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/20.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import Foundation

extension FileManager {
  public var appGroupURL: URL {
    return containerURL(forSecurityApplicationGroupIdentifier: "group.com.noppelab.gabbie")!
  }
  
  func dumpFiles(url: URL) {
    let list = try! contentsOfDirectory(atPath: url.path)
    print("###")
    print(list)
    print("###")
  }
}
