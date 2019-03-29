//
//  SettingMenuViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 29/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class SettingMenuViewController<Value: Equatable>: UIViewController, SettingMenuViewInput {
  var output: SettingMenuViewOutput!
  private lazy var tableView: UITableView = .init(frame: .zero, style: .plain)
  private lazy var settingMenu: AnySettingMenu<Value> = { preconditionFailure() }()
  private lazy var bypassDataSource: UITableViewBypassDataSource = .init(with: tableView)
  private lazy var bypassDelegate: UITableViewBypassDelegate = .init(with: tableView)
  
  static func make<Value: Equatable>(settingMenu: AnySettingMenu<Value>) -> SettingMenuViewController<Value> {
    let vc = SettingMenuViewController<Value>()
    let configurator = SettingMenuModuleConfigurator<Value>()
    configurator.configureModuleForViewInput(viewInput: vc)
    vc.settingMenu = settingMenu
    vc.setupInitialState()
    return vc
  }
  
  override func loadView() {
    super.loadView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.tableFooterView = UIView()
    tableView.backgroundColor = ColorName.contentBackgroundColor.color
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = ColorName.backgroundColor.color
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    bypassDataSource.dataSource = self
    bypassDelegate.delegate = self
    output.viewIsReady()
  }
  
  // MARK: SettingMenuViewInput
  func setupInitialState() {
  }
}

extension SettingMenuViewController: NonObjcTableViewDataSource, NonObjcTableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return settingMenu.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.backgroundColor = ColorName.contentBackgroundColor.color
    let item = settingMenu.items[indexPath.row]
    cell.textLabel?.text = item.title
    cell.textLabel?.textColor = .white
    cell.accessoryType = settingMenu.dataStore.load() == item.value ? .checkmark : .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let item = settingMenu.items[indexPath.row]
    settingMenu.dataStore.set(item.value)
    tableView.reloadData()
  }
}
