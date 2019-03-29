//
//  SettingsViewController.swift
//  gabbie-ios
//
//  Created by noppefoxwolf on 28/10/2018.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, SettingsViewInput, AlwaysModalyPresenting {
  let navigationControllerType: UINavigationController.Type? = NavigationController.self
  var output: SettingsViewOutput!
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  // MARK: SettingsViewInput
  func setupInitialState() {
  }
  
  func setupUI() {
    view.backgroundColor = ColorName.backgroundColor.color
    
    tableView: do {
      tableView.tableFooterView = UIView()
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      tableView.separatorStyle = .none
    }
    
    title: do {
      let titleLabel = UILabel()
      titleLabel.attributedText = "Settings".withFont(.boldSystemFont(ofSize: 16)).withTextColor(.white)
      navigationItem.titleView = titleLabel
    }
    
    barButtonItem: do {
      let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDoneButton))
      done.tintColor = ColorName.buttonTintColor.color
      navigationItem.rightBarButtonItem = done
    }
  }
  
  @objc private func tappedDoneButton(_ sender: UIBarButtonItem) {
    output.tappedDoneButton()
  }
}

extension SettingsViewController {
  public override func numberOfSections(in tableView: UITableView) -> Int {
    return Section.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Section(rawValue: section)!.rowCount
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard section == Section.allCases.count - 1 else { return UIView() }
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    let label = UILabel()
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    label.attributedText = "©︎2018 noppelab, Cironnup \(version) - (\(build))".withFont(.systemFont(ofSize: 12)).withTextColor(.lightGray).withParagraphStyle(style)
    return label
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch Section(rawValue: indexPath.section)! {
    case .general: return general(tableView, cellForRowAt: indexPath)
    case .assistance: return assistance(tableView, cellForRowAt: indexPath)
    case .contentUs: return contactUs(tableView, cellForRowAt: indexPath)
    }
  }
  
  private func general(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let menu = Section.generalItems[indexPath.row]
    cell.backgroundColor = ColorName.contentBackgroundColor.color
    cell.textLabel?.textColor = .white
    cell.textLabel?.text = menu.title
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  private func assistance(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.backgroundColor = ColorName.contentBackgroundColor.color
    cell.textLabel?.textAlignment = .center
    cell.textLabel?.textColor = .white
    switch Section.Assistance(rawValue: indexPath.row)! {
    case .review:
      cell.textLabel?.text = "Review Cironnup on iTunes"
    case .tip:
      cell.textLabel?.text = "Tip Cironnup"
    }
    return cell
  }
  
  private func contactUs(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.backgroundColor = ColorName.brandColor.color
    cell.textLabel?.textAlignment = .center
    cell.textLabel?.textColor = .white
    cell.textLabel?.text = "Contact Us"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    switch Section(rawValue: indexPath.section)! {
    case .general:
      output.tappedGeneralSettingMenu(Section.generalItems[indexPath.row])
    case .assistance:
      switch Section.Assistance(rawValue: indexPath.row)! {
      case .review:
        output.tappedReviewButton()
      case .tip:
        output.tappedTipButton()
      }
    case .contentUs:
      switch Section.ContactUs(rawValue: indexPath.row)! {
      case .contactUs:
        output.tappedContactUsButton()
      }
    }
  }
}

extension SettingsViewController {
  enum Section: Int, CaseIterable {
    case general
    case assistance
    case contentUs
  }
}

extension SettingsViewController.Section {
  var rowCount: Int {
    switch self {
    case .general: return SettingsViewController.Section.generalItems.count
    case .assistance: return Assistance.allCases.count
    case .contentUs: return ContactUs.allCases.count
    }
  }
  
  static var generalItems: [AnySettingMenu<String>] {
    if PurchaseLog.shared.isPurchased {
      return [BrowserSetting()].map(AnySettingMenu.init)
    } else {
      return []
    }
  }
  
  enum Assistance: Int, CaseIterable {
    case review
    case tip
  }
  
  enum ContactUs: Int, CaseIterable {
    case contactUs
  }
}
