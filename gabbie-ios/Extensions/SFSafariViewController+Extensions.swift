//
//  SFSafariViewController+Extensions.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/19.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import SafariServices

extension SFSafariViewController: AlwaysModalyPresenting {
  var navigationControllerType: UINavigationController.Type? {
    return nil
  }
}
