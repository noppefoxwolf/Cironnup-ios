//
//  ShareViewController.swift
//  gabbie-ShareExtension
//
//  Created by Tomoya Hirano on 2018/10/20.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import UIKit
import Social
import CironnupKit
import GabKit
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
  
  private let accounts = AccountStore()!.accounts
  
  override func isContentValid() -> Bool {
    guard accounts.count > 0 else { return false }
    return contentText.count > 0
  }
  
  override func didSelectPost() {
    var body = contentText ?? ""
    if let extensionItem = self.extensionContext?.inputItems.first as? NSExtensionItem,
       let itemProvider = extensionItem.attachments?.first {
      let puclicURL = String(kUTTypeURL)  // "public.url"
      if itemProvider.hasItemConformingToTypeIdentifier(puclicURL) {
        itemProvider.loadItem(forTypeIdentifier: puclicURL, options: nil, completionHandler: { [weak self] (data, error) in
          body += " \((data as! URL).absoluteString)"
          self?.publish(body: body) { [weak self] in
            self?.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
          }
          self?.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        })
      }
    } else {
      publish(body: body) { [weak self] in
        self?.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
      }
    }
  }
  
  override func configurationItems() -> [Any]! {
    return items
  }
  
  private func publish(body: String, completions: @escaping (() -> Void)) {
    guard let account = accounts.first else { return completions() }
    let credential = account.clientSource.credential
    let gab = Gab.default(with: credential)
    gab.publish(body, success: { (_) in
      completions()
    }) { (_) in
      completions()
    }
  }
  
  
  private var items: [SLComposeSheetConfigurationItem] {
    let items = accounts.compactMap({ (account) -> SLComposeSheetConfigurationItem in
      let item = SLComposeSheetConfigurationItem()!
      item.title = "\(account.name) (@\(account.username))"
      item.tapHandler = {
      }
      return item
    })
    return items
  }
}

