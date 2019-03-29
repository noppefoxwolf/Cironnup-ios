//
//  UITableViewBypassDataSource.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/29.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit

protocol NonObjcTableViewDataSource: class {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
protocol NonObjcTableViewDelegate: class {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

class UITableViewBypassDataSource: NSObject, UITableViewDataSource {
  weak var dataSource: NonObjcTableViewDataSource? = nil
  
  init(with tableView: UITableView) {
    super.init()
    tableView.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return dataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
  }
}

class UITableViewBypassDelegate: NSObject, UITableViewDelegate {
  weak var delegate: NonObjcTableViewDelegate? = nil
  
  init(with tableView: UITableView) {
    super.init()
    tableView.delegate = self
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.tableView(tableView, didSelectRowAt: indexPath)
  }
}
